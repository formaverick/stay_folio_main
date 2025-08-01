package com.hotel.service;

import java.time.LocalDate;
import java.time.Month;
import java.time.temporal.ChronoUnit;
import java.sql.Date;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hotel.domain.ReservationCancelCheckVO;
import com.hotel.domain.ReservationCreateDTO;
import com.hotel.domain.ReservationDTO;
import com.hotel.domain.ReservationDetail;
import com.hotel.domain.ReservationPageVO;
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

	@Override
	public ReservationPageVO getReservationPageInfo(int riId, int siId, String miId) {
		return mapper.getReservationPageInfo(riId, siId, miId);
	}

	// 예약등록 처리
	@Override
	public int reserve(ReservationCreateDTO dto) {
		log.info("reserve 진입");
		log.info("srId 초기값: " + dto.getSrId());

		dto.setSrId(null); // 예약번호 새로 부여받도록 null 처리

		if (isDuplicateReservation(dto.getSiId(), dto.getRiId(), dto.getSrCheckin(), dto.getSrCheckout())) {
			log.warn("중복 예약 시도 감지");
			return -1; // 중복 예약 발생 시
		}

		calculateReservationPrice(dto); // 요금 계산
		processEmail(dto); // 이메일 처리

		if (dto.getSrRequest() == null) {
			dto.setSrRequest("");
		}

		int result = mapper.insertReservation(dto);
		log.info("예약 insert 결과: " + result);

		return result;
	}

	// 중복예약 방지
	@Override
	public boolean isDuplicateReservation(int siId, int riId, LocalDate checkin, LocalDate checkout) {
		Date checkinDate = Date.valueOf(checkin);
		Date checkoutDate = Date.valueOf(checkout);

		int count = mapper.checkDuplicateReservation(siId, riId, checkinDate, checkoutDate);
		log.warn("중복 예약 건수: " + count);
		return count > 0;
	}

	// 예약 상세조회
	@Override
	public ReservationDetail getReservation(String reservationId) {
		return mapper.selectReservationById(reservationId);
	}

	@Override
	public ReservationPageVO getReservationPageInfo(int riId, int siId, String miId, LocalDate checkin,
			LocalDate checkout, int adult, int child) {
		ReservationPageVO pageInfo = mapper.getReservationPageInfo(riId, siId, miId);
		ReservationDTO priceInfo = priceMapper.getReservationPriceInfo(riId, siId);

		int totalPerson = adult + child;
		log.warn("adult: " + adult);
		log.warn("child: " + child);
		log.warn("totalPerson = " + totalPerson);
		log.warn("riMaxperson = " + priceInfo.getRiMaxperson());

		Integer riMaxperson = priceInfo.getRiMaxperson();
		if (totalPerson > riMaxperson) {
			log.warn("최대 인원 초과: 현재=" + totalPerson + ", 최대=" + riMaxperson);
			throw new IllegalStateException("redirect:/?error=인원초과");
		}

		ReservationCreateDTO dto = new ReservationCreateDTO();
		dto.setRiId(riId);
		dto.setSiId(siId);
		dto.setSrCheckin(checkin);
		dto.setSrCheckout(checkout);
		dto.setSrAdult(adult);
		dto.setSrChild(child);

		calculateReservationPrice(dto, priceInfo);

		if (pageInfo != null) {
			pageInfo.setRiPrice(priceInfo.getRiPrice());
			pageInfo.setNights(dto.getNights());
			pageInfo.setSrRoomPrice(dto.getSrRoomprice());
			pageInfo.setSrAddpersonFee(dto.getSrAddpersonFee());
			pageInfo.setSrDiscount(dto.getSrDiscount());
			pageInfo.setSrtotalPrice(dto.getSrTotalprice());
		}

		return pageInfo;
	}

	// 이메일처리
	private void processEmail(ReservationCreateDTO dto) {
		if (dto.getMiId() != null && !dto.getMiId().isEmpty()) {
			dto.setSrEmail(dto.getMiId());
		} else {
			if (dto.getSrEmail() == null || dto.getSrEmail().isEmpty()) {
				throw new IllegalArgumentException("비회원 예약 시 이메일은 필수입니다.");
			}
		}
	}

	// 요금계산
	private void calculateReservationPrice(ReservationCreateDTO dto, ReservationDTO priceInfo) {
		ReservationPriceResultDTO result = calculatePrice(dto.getSrCheckin(), dto.getSrCheckout(), dto, priceInfo);

		int totalBeforeDiscount = result.getSrtotalPrice() + result.getSrAddpersonFee();
		int discount = calculateDiscount(totalBeforeDiscount, priceInfo.getSiDiscount());
		int finalTotal = totalBeforeDiscount - discount;

		dto.setSrRoomprice(result.getSrtotalPrice());
		dto.setSrAddpersonFee(result.getSrAddpersonFee());
		dto.setSrDiscount(discount);
		dto.setSrTotalprice(finalTotal);
		dto.setNights(result.getNights());
	}

	// 요금계산 상세
	private ReservationPriceResultDTO calculatePrice(LocalDate checkin, LocalDate checkout, ReservationCreateDTO dto,
			ReservationDTO priceInfo) {

		Map<String, Integer> dailyPrices = new LinkedHashMap<>();
		int roomPriceTotal = 0;
		LocalDate current = checkin;

		int basePerson = priceInfo.getRiPerson();
		int totalPerson = dto.getSrAdult() + dto.getSrChild();
		int extraPerson = Math.max(0, totalPerson - basePerson);
		int extraFee = extraPerson * priceInfo.getSiExtra();

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
		result.setDiscountRate(discountRate);	// 할인율
		System.out.println("할인율 확인: " + priceInfo.getSiDiscount());

		return result;
	}

	public ReservationPriceResultDTO calculateRoomPrice(int riId, int siId, LocalDate checkin, LocalDate checkout,
			int adult, int child) {

		ReservationDTO priceInfo = priceMapper.getReservationPriceInfo(riId, siId);

		ReservationCreateDTO dto = new ReservationCreateDTO();
		dto.setRiId(riId);
		dto.setSiId(siId);
		dto.setSrCheckin(checkin);
		dto.setSrCheckout(checkout);
		dto.setSrAdult(adult);
		dto.setSrChild(child);

		return calculatePrice(checkin, checkout, dto, priceInfo);
	}

	// 할인 금액 계산
	private int calculateDiscount(int baseAmount, double discountRate) {
		return (int) (baseAmount * discountRate);
	}

	private void calculateReservationPrice(ReservationCreateDTO dto) {
		ReservationDTO priceInfo = priceMapper.getReservationPriceInfo(dto.getRiId(), dto.getSiId());
		calculateReservationPrice(dto, priceInfo);
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
