package com.hotel.service;



import java.time.LocalDate;
import java.time.Month;
import java.time.temporal.ChronoUnit;
import java.util.LinkedHashMap;
import java.util.Map;

import org.springframework.stereotype.Service;

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
public class ReservationServiceImpl implements ReservationService {

	// 예약 상태 상수 정의
	private static final String STATUS_COMPLETE = "a"; // 예약 완료

	private final ReservationMapper mapper;
	private final ReservationPriceMapper priceMapper;

	@Override
	public ReservationPageVO getReservationPageInfo(int riId, int siId, String miId) {
		return mapper.getReservationPageInfo(riId, siId, miId); 
	}

	
	/**
	 * 1. 예약 등록 처리
	 */
	@Override
	public int reserve(ReservationCreateDTO dto) {
		calculateReservationPrice(dto); // 1. 요금 계산 및 DTO 설정
		dto.setSrStatus(STATUS_COMPLETE); // 2. 예약 상태 기본값 설정
		processEmail(dto); // 3. 이메일 처리 (회원/비회원)

		if (dto.getSrRequest() == null) {
			dto.setSrRequest("");
		}
		
		return mapper.insertReservation(dto); // 5. DB 저장
	}

	/**
	 * 2. 예약 상세 조회
	 */
	@Override
    public ReservationDetail getReservation(String reservationId) {
        return mapper.selectReservationById(reservationId);
    }

	

	@Override
	public ReservationPageVO getReservationPageInfo(int riId, int siId, String miId, LocalDate checkin,
			LocalDate checkout, int adult, int child) {
		ReservationPageVO pageInfo = mapper.getReservationPageInfo(riId, siId, miId);

		ReservationCreateDTO dto = new ReservationCreateDTO();
		dto.setRiId(riId);
		dto.setSiId(siId);
		dto.setSrCheckin(checkin);
		dto.setSrCheckout(checkout);
		dto.setSrAdult(adult);
		dto.setSrChild(child);

		ReservationDTO priceInfo = priceMapper.getReservationPriceInfo(riId, siId);

		// 최대 인원 체크
		int totalPerson = adult + child;
		if (totalPerson > priceInfo.getRiMaxperson()) {
			throw new IllegalArgumentException("최대 인원(" + priceInfo.getRiMaxperson() + "명)을 초과했습니다.");
		}
		ReservationPriceResultDTO result = calculatePrice(checkin, checkout, dto, priceInfo);
		if (pageInfo != null) {
			pageInfo.setRiPrice(priceInfo.getRiPrice());
			pageInfo.setNights(result.getNights());
			pageInfo.setSrAddpersonFee(result.getSrAddpersonFee());
			pageInfo.setSrRoomPrice(result.getSrRoomPrice()); 
			pageInfo.setSrtotalPrice(result.getSrtotalPrice()); 
		}
		return pageInfo;
	}


	/**
	 * ✅ 회원/비회원에 따른 이메일 처리
	 */
	private void processEmail(ReservationCreateDTO dto) {
		if (dto.getMiId() != null && !dto.getMiId().isEmpty()) {
			dto.setSrEmail(dto.getMiId());
		} else {
			if (dto.getSrEmail() == null || dto.getSrEmail().isEmpty()) {
				throw new IllegalArgumentException("비회원 예약 시 이메일은 필수입니다.");
			}
		}
	}

	/**
	 * ✅ 요금 계산 + DTO에 세팅
	 */
	private void calculateReservationPrice(ReservationCreateDTO dto) {
		ReservationDTO priceInfo = priceMapper.getReservationPriceInfo(dto.getRiId(), dto.getSiId());
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

	/**
	 * ✅ 요금 계산 상세 (일자별 요금, 추가인원 요금 등)
	 */
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

	ReservationPriceResultDTO result = new ReservationPriceResultDTO();
	result.setDailyPrices(dailyPrices);
	result.setSrRoomPrice(roomPriceTotal); // 객실 요금만 (성/비수기 포함)
	result.setSrAddpersonFee(extraFee);    // 추가 인원 요금
	result.setSrtotalPrice(roomPriceTotal + extraFee); // 총합 (객실 + 추가요금)
	result.setNights(ChronoUnit.DAYS.between(checkin, checkout));
	result.setRiPrice(priceInfo.getRiPrice()); // 1박 기본 요금

	return result;
}
	
	/**
	 * ✅ 할인 금액 계산 (소수점 절삭)
	 */
	private int calculateDiscount(int baseAmount, double discountRate) {
	    return (int)(baseAmount * discountRate);
	}


	/**
	 * ✅ 월별 시즌 요율 계산
	 */
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
