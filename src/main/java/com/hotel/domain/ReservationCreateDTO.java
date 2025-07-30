package com.hotel.domain;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class ReservationCreateDTO {
	private int siId; // 숙소 번호
	private int riId; // 객실 번호
	private String siName; // 숙소 이름
	
	private String miId; // 회원 아이디/이메일(비회원이면 null 가능)

	private String srName; // 예약자명
	private String srEmail; // 예약자 이메일 (비회원시)
	private String srPhone; // 전화번호
	private String srRequest; // 요청사항

	private int srAdult; // 어른
	private int srChild; // 아동
	

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate srCheckin;	//체크인

	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private LocalDate srCheckout;	//체크아웃
	
	private long nights; // 숙박일수 계산
	private int srRoomprice; // 객실 기본 요금
	private int srDiscount; // 할인요금
	private int srAddpersonFee; // 인원 추가요금
	private int srTotalprice; // 전체 요금
	private String srPayment; // 결제 방법

	private String srStatus; // 예약 상태
	private String srPaymentstatus; // 결제 상태
	private String srId; // 예약 번호

}
