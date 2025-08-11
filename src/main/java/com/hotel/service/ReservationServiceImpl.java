package com.hotel.service;

import java.sql.Date;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.Month;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hotel.domain.ReservationCancelCheckVO;
import com.hotel.domain.ReservationDTO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationPriceResultDTO;
import com.hotel.mapper.ReservationMapper;
import com.hotel.mapper.ReservationPriceMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Service
@RequiredArgsConstructor
@Log4j
@Transactional
public class ReservationServiceImpl implements ReservationService {

	private final ReservationMapper mapper;
	private final ReservationPriceMapper priceMapper;

	// 예약등록 처리
	@Override
	public int reserve(ReservationDetailVO dto) {
		dto.setSrId(null); // 예약번호 새로 부여받도록 null 처리
		if (isDuplicateReservation(dto.getSiId(), dto.getRiId(), dto.getSrCheckin(), dto.getSrCheckout())) {
			return -1; // 중복 예약 발생 시
		}

		processEmail(dto); // 이메일 처리
		if (dto.getSrRequest() == null)
			dto.setSrRequest("");

		try {
		    return mapper.insertReservation(dto);
		} catch (org.springframework.dao.DataAccessException e) { 
		    dto.setStatus("failed");
		    dto.setMessage("결제에 실패했습니다. 다시 시도해주세요.");
		    return -2;
		}

	}

	// 중복예약 방지 (sr status가 a or d만)
	@Override
	public boolean isDuplicateReservation(int siId, int riId, Timestamp checkin, Timestamp checkout) {
		Date checkinDate = Date.valueOf(checkin.toLocalDateTime().toLocalDate());
		Date checkoutDate = Date.valueOf(checkout.toLocalDateTime().toLocalDate());

		int count = mapper.checkDuplicateReservation(siId, riId, checkinDate, checkoutDate);
		return count > 0;
	}

	// 예약 완료 페이지 (info 몇개 가져옴)
	@Override
	public ReservationDetailVO getReservationPageInfo(int riId, int siId, String miId) {
		return mapper.getReservationPageInfo(riId, siId, miId);
	}

	// 예약 완료 페이지
	@Override
	public ReservationDetailVO getReservation(String reservationId) {
		ReservationDetailVO reservation = mapper.selectReservationById(reservationId);

		if (reservation.getSrCheckin() != null && reservation.getSrCheckout() != null) {

			LocalDate checkinDate = reservation.getSrCheckin().toInstant() // LocalDate로 변환
					.atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate checkoutDate = reservation.getSrCheckout().toInstant().atZone(ZoneId.systemDefault())
					.toLocalDate();

			int nights = (int) ChronoUnit.DAYS.between(checkinDate, checkoutDate); // 박 수체크
			reservation.setNights(nights);
		}

		return reservation;
	}

	// 예약 페이지 설정
	@Override
	public ReservationDetailVO getReservationPageInfo(int riId, int siId, String miId, LocalDate checkin,
			LocalDate checkout, int adult, int child) {
		ReservationDetailVO pageInfo = mapper.getReservationPageInfo(riId, siId, miId);
		ReservationDTO priceInfo = priceMapper.getReservationPriceInfo(riId, siId);
		if (priceInfo == null || pageInfo == null) return null;
		
		int totalPerson = adult + child;

		Integer riMaxperson = priceInfo.getRiMaxperson();
		if (totalPerson > riMaxperson) {
			throw new IllegalArgumentException("최대 인원을 초과했습니다.");
		}

		ReservationDetailVO dto = new ReservationDetailVO();
		dto.setRiId(riId);
		dto.setSiId(siId);
		dto.setSrCheckin(Timestamp.valueOf(checkin.atStartOfDay()));
		dto.setSrCheckout(Timestamp.valueOf(checkout.atStartOfDay()));
		dto.setSrAdult(adult);
		dto.setSrChild(child);

		ReservationPriceResultDTO result = calculatePrice(checkin, checkout, dto, priceInfo);

		dto.setSrRoomprice(result.getSrRoomPrice());
		dto.setSrAddpersonFee(result.getSrAddpersonFee());
		dto.setSrDiscount((int) (result.getSrRoomPrice() * result.getDiscountRate()));
		dto.setSrTotalprice(result.getSrtotalPrice());

		dto.setNights((int) result.getNights());

		if (pageInfo != null) {
			pageInfo.setRiPrice(priceInfo.getRiPrice());
			pageInfo.setNights(dto.getNights());
			pageInfo.setSrRoomprice(dto.getSrRoomprice());
			pageInfo.setSrAddpersonFee(dto.getSrAddpersonFee());
			pageInfo.setSrDiscount(dto.getSrDiscount());
			pageInfo.setSrTotalprice(dto.getSrTotalprice());
		}

		return pageInfo;
	}

	// 이메일처리
	private void processEmail(ReservationDetailVO dto) {
		if (dto.getMiId() != null && !dto.getMiId().isEmpty()) {
			dto.setSrEmail(dto.getMiId());
		} else {
			if (dto.getSrEmail() == null || dto.getSrEmail().isEmpty()) {
				throw new IllegalArgumentException("비회원 예약 시 이메일은 필수입니다.");
			}
		}
	}

	// 요금계산 상세 DB 조회는 안 하고, 계산만 담당
	private ReservationPriceResultDTO calculatePrice(LocalDate checkin, LocalDate checkout, ReservationDetailVO dto,
			ReservationDTO priceInfo) {

		Map<String, Integer> dailyPrices = new LinkedHashMap<>();
		int roomPriceTotal = 0;
		LocalDate current = checkin;

		int basePerson = priceInfo.getRiPerson();
		int totalPerson = dto.getSrAdult() + dto.getSrChild(); // 전체 인원
		int extraPerson = Math.max(0, totalPerson - basePerson); // 추가인원
		int extraFee = extraPerson * priceInfo.getSiExtra(); // 추가인원 * 기준초과시 금액

		while (!current.isEqual(checkout)) {
			double rate = getSeasonRate(current, priceInfo);
			int dailyPrice = (int) (priceInfo.getRiPrice() * rate);

			dailyPrices.put(current.toString(), dailyPrice);
			roomPriceTotal += dailyPrice;

			current = current.plusDays(1);
		}
		double discountRate = priceInfo.getSiDiscount(); // 0.1 → 10%
		int discountAmount = (int) Math.floor(roomPriceTotal * discountRate);
		int discountedRoomPrice = roomPriceTotal - discountAmount;

		ReservationPriceResultDTO result = new ReservationPriceResultDTO();
		result.setDailyPrices(dailyPrices);
		result.setSrRoomPrice(roomPriceTotal); // 객실 요금만 (성/비수기 포함)
		result.setSrAddpersonFee(extraFee); // 추가 인원 요금
		result.setSrtotalPrice(discountedRoomPrice + extraFee); // 총합 (객실 + 추가요금)
		result.setNights(ChronoUnit.DAYS.between(checkin, checkout));
		result.setRiPrice(priceInfo.getRiPrice()); // 1박 기본 요금
		result.setDiscountRate(discountRate); // 할인율

		return result;
	}

	// room price 값 가져온다음에 계산로직
	public ReservationPriceResultDTO calculateRoomPrice(int riId, int siId, LocalDate checkin, LocalDate checkout,
			int adult, int child) {

		ReservationDTO priceInfo = priceMapper.getReservationPriceInfo(riId, siId);

		ReservationDetailVO dto = new ReservationDetailVO();
		dto.setRiId(riId);
		dto.setSiId(siId);
		dto.setSrCheckin(Timestamp.valueOf(checkin.atStartOfDay()));
		dto.setSrCheckout(Timestamp.valueOf(checkout.atStartOfDay()));
		dto.setSrAdult(adult);
		dto.setSrChild(child);

		return calculatePrice(checkin, checkout, dto, priceInfo);
	}

	// 월별 성수기 비성수기 로직 하드코딩 해놓음
	private double getSeasonRate(LocalDate date, ReservationDTO priceInfo) {
		Month month = date.getMonth();

		// 성수기: 7~8월, 12~2월
		if (month == Month.JULY || month == Month.AUGUST || month == Month.DECEMBER || month == Month.JANUARY
				|| month == Month.FEBRUARY) {
			return priceInfo.getSiPeak();
		}

		// 비성수기: 3~5월, 9~11월
		if (month == Month.MARCH || month == Month.APRIL || month == Month.MAY || month == Month.SEPTEMBER
				|| month == Month.OCTOBER || month == Month.NOVEMBER) {
			return priceInfo.getSiOff();
		}

		// 6월: 기본 요율
		if (month == Month.JUNE) {
			return 1.0;
		}

		throw new IllegalArgumentException("요금이 정의되지 않은 달입니다: " + month);
	}

	// 예약 취소 정보
	@Override
	public ReservationCancelCheckVO getReservationById(String id) {
		ReservationCancelCheckVO vo = mapper.selectReservationForCancel(id);
		log.info(vo);
		return vo;
	}

	// 예약 취소
	@Override
	public int cancelReservation(String id) {
		int result = mapper.cancelReservation(id);
		return result;
	}

}
