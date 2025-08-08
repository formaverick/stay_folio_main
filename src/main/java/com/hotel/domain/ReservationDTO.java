package com.hotel.domain;

import java.time.LocalDate;

import lombok.Data;
@Data
public class ReservationDTO {
	private int siId; // 숙소 번호
	private int riId; // 객실 번호
	private String siName; // 숙소 이름
	private String riName; // 객실 이름

	private String miId; // 회원 아이디/이메일(비회원이면 null 가능)
	private String srName; // 예약자명
	private String srEmail; // 예약자 이메일 (비회원시)
	private String srPhone; // 전화번호
	private String srRequest; // 요청사항

	private String siAddress; // 숙소 주소
	private String siPhone; // 숙소 관리자 전화번호
	private String siEmail; // 숙소 판매자 이메일

	private int riPerson; // 기준 인원
	private int siExtra; // 추가 인원 금액
	private int riMaxperson;//최대 인원
	private int srAdult; // 어른
	private int srChild; // 아동
	private int srBaby; // 유아

	private double siPeak; // 성수기
	private double siOff; // 비성수기
	private LocalDate srCheckin; // 체크인
	private LocalDate srCheckout; // 체크아웃

	private long nights; // 숙박일수 계산
	private int riPrice; // 객실 기본 요금
	private double siDiscount; // 할인율
	private int srAddpersonFee; // 인원 추가 요금
	private int srTotalprice; // 전체 요금

	private String srPayment; // 결제 방법
	private String srStatus; // 예약 상태
	private String srId; // 예약 번호

	
	
	
}
