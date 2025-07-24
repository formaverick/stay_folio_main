package com.hotel.domain;

import lombok.Data;

@Data
public class ReservationPageVO {
	private int riId;
    private String riName;
    private int riPerson;
    private int riMaxperson;
    private String riBed;
    private int riBedcnt;
    private int riBedroom;
    private int riBathroom;

    // 숙소 정보
    private int siId;
    private String siName;
    private double siPeak;
    private double siOff;
    private double siDiscount;

    // 회원 정보 (선택)
    private String miId;
    private String miName;
    private String miPhone;
    
	// ✅ 추가
	private int riPrice;         // 1박 요금
	private long nights;         // 숙박일수
	private int extraFee;        // 추가 인원 요금
	private double totalPrice;      // 총 결제 금액
}
