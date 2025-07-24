package com.hotel.domain;

import lombok.Data;

@Data
public class ReservationPriceDTO {
	// RoomInfoVO
	private int riId;        // 객실 번호
	private String riName;   // 객실 이름
	private int riPrice;     // 기본 가격
	private int riPerson;    // 기준 인원

	// StayInfoVO
	private int siId;          // 숙소 번호
	private double siPeak;     // 성수기 계수
	private double siOff;      // 비성수기 계수
	private double siDiscount; // 할인율
	private int siExtra;       // 추가 인원 금액


}
