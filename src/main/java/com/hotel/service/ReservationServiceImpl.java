package com.hotel.service;

import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.Month;
import java.time.temporal.ChronoUnit;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.ibatis.annotations.Param;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import com.hotel.domain.ReservationCancelDTO;
import com.hotel.domain.ReservationCreateDTO;
import com.hotel.domain.ReservationDTO;
import com.hotel.domain.ReservationPageVO;
import com.hotel.domain.ReservationPriceResultDTO;
import com.hotel.mapper.ReservationMapper;
import com.hotel.mapper.ReservationPriceMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {

	// 예약 상태 상수 정의
	private static final String STATUS_COMPLETE = "a"; // 예약 완료
	private static final String STATUS_CANCEL_DONE = "c"; // 취소 완료

	private final ReservationMapper mapper;
	private final ReservationPriceMapper priceMapper;

	@Override
	public ReservationPageVO getReservationPageInfo(int riId, int siId, String miId) {
		return mapper.getReservationPageInfo(riId,siId,miId); // mapper는 MyBatis Mapper
	}
	@Override
	public int findSiIdByRiId(int riId) {
	    return mapper.findSiIdByRiId(riId);
	}

	/**
	 * 1. 예약 등록 처리
	 */
	@Override
	public int reserve(ReservationCreateDTO dto) {

		validateDuplicateReservation(dto); // 1. 중복 예약 체크
		calculateReservationPrice(dto); // 2. 요금 계산 및 DTO 설정
		dto.setSrStatus(STATUS_COMPLETE); // 3. 예약 상태 기본값 설정
		processEmail(dto); // 4. 이메일 처리 (회원/비회원)

		if (dto.getSrRequest() == null) {
			dto.setSrRequest("");
		}
		if (dto.getSrRequest() == null) {
			dto.setSrRequest("");
		}

		return mapper.insertReservation(dto); // 5. DB 저장
	}

	/**
	 * 2. 예약 상세 조회
	 */
	@Override
	public ReservationDTO getReservation(String srId) {
		return mapper.selectReservationById(srId);
	}

	/**
	 * 3. 예약 취소 처리
	 */
	@Override
	public int CancelReservation(ReservationCancelDTO dto) {
		dto.setSrCancledate(new Timestamp(System.currentTimeMillis()));
		dto.setSrStatus(STATUS_CANCEL_DONE);
		return mapper.cancelReservation(dto);
	}
	
	@Override
	public ReservationPageVO getReservationPageInfo(int riId, int siId, String miId,
	                                                LocalDate checkin, LocalDate checkout,
	                                                int adult, int child) {
	    ReservationPageVO pageInfo = mapper.getReservationPageInfo(riId, siId, miId);

	    ReservationCreateDTO dto = new ReservationCreateDTO();
	    dto.setRiId(riId);
	    dto.setSiId(siId);
	    dto.setSrCheckin(checkin);
	    dto.setSrCheckout(checkout);
	    dto.setSrAdult(adult);
	    dto.setSrChild(child);
	    

	    ReservationDTO priceInfo = priceMapper.getReservationPriceInfo(riId, siId);
	    
	    // ✅ 최대 인원 체크
	    int totalPerson = adult + child;
	    if (totalPerson > priceInfo.getRiMaxperson()) {
	        throw new IllegalArgumentException("최대 인원(" + priceInfo.getRiMaxperson() + "명)을 초과했습니다.");
	    }
	    
	    
	    ReservationPriceResultDTO result = calculatePrice(checkin, checkout, dto, priceInfo);

	    if (pageInfo != null) {
	        int totalBeforeDiscount = result.getTotalPrice() + result.getExtraFee();
	        int discount = (int)(totalBeforeDiscount * priceInfo.getSiDiscount());
	        int finalPrice = totalBeforeDiscount - discount;

	        pageInfo.setRiPrice(priceInfo.getRiPrice()); // 1박 요금
	        pageInfo.setNights(result.getNights());      // 숙박일수
	        pageInfo.setExtraFee(result.getExtraFee());  // 추가 인원 요금
	        pageInfo.setSiDiscount(discount);            // 할인 금액
	        pageInfo.setTotalPrice(finalPrice);          // 최종 결제 금액
	    }

	    return pageInfo;
	}


	/**
	 * ✅ 중복 예약 체크
	 */
	private void validateDuplicateReservation(ReservationCreateDTO dto) {
		int count = mapper.checkDuplicateReservation(dto);
		if (count > 0) {
			throw new IllegalStateException("이미 예약된 일정입니다.");
		}
	}

	/**
	 * ✅ 회원/비회원에 따른 이메일 처리
	 */
	private void processEmail(ReservationCreateDTO dto) {
		if (dto.getMiId() != null && !dto.getMiId().isEmpty()) {
			dto.setSrEmail(dto.getMiId()); // ✅ 반드시 srEmail에 값 들어가게!
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

		int totalBeforeDiscount = result.getTotalPrice() + result.getExtraFee();
		int discount = (int) (totalBeforeDiscount * priceInfo.getSiDiscount());
		int finalTotal = totalBeforeDiscount - discount;

		dto.setSrRoomprice(result.getTotalPrice());
		dto.setSrAddpersonFee(result.getExtraFee());
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
		int totalPrice = 0;
		LocalDate current = checkin;

		int basePerson = priceInfo.getRiPerson();
		int totalPerson = dto.getSrAdult() + dto.getSrChild();
		int extraPerson = Math.max(0, totalPerson - basePerson);
		int extraFee = extraPerson * priceInfo.getSiExtra();

		while (!current.isEqual(checkout)) {
			double rate = getSeasonRate(current, priceInfo);
			int dailyPrice = (int) (priceInfo.getRiPrice() * rate);

			dailyPrices.put(current.toString(), dailyPrice);
			totalPrice += dailyPrice;
			current = current.plusDays(1);
		}

		ReservationPriceResultDTO result = new ReservationPriceResultDTO();
		result.setDailyPrices(dailyPrices);
		result.setTotalPrice(totalPrice);
		result.setExtraFee(extraFee);
		result.setNights(ChronoUnit.DAYS.between(checkin, checkout));

		return result;
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

}
