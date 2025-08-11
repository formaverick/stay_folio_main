package com.hotel.domain;

import java.time.LocalDate;
import java.util.Map;

import lombok.Data;
@Data
public class ReservationPriceResultDTO {
	// DB 저장용
		private int riId;
		private int siId;
		
		private int srRoomPrice;      // 객실 요금 (계산된 값, t_stay_reservation.sr_roomprice)
		private int srAddpersonFee;    // 인원 추가 요금
		private int srtotalPrice;      // 최종 객실 요금

		
		private Map<String, Integer> dailyPrices; //1일당 숙박요금 계산
		private int riPrice;           // 기본 1박 요금
		private long nights;           // 숙박일 수
		private double DiscountRate;
		
		private LocalDate srCheckin;
	    private LocalDate srCheckout;
		private int srDiscount;
		
		private double siPeak;     // 성수기 계수
		private double siOff;      // 비성수기 계수
		private double siDiscount; // 할인율
		private int siExtra;       // 추가 인원 금액
		
		private int srAdult;
		private int srChild;

		private int riPerson;
		private double SeasonRate;
	
		
		
		

}
