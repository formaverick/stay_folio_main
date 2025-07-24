package com.hotel.domain;

import java.util.Map;

import lombok.Data;
@Data
public class ReservationPriceResultDTO {
	private Map<String, Integer> dailyPrices; // 날짜별 가격
	private int totalPrice;                   // 총 가격
	private int extraFee;                     // 인원 추가 요금
	private long nights;                      // 숙박일 수

}
