package com.hotel.domain;

import java.time.LocalDate;

import lombok.Data;

@Data
public class ReservationDetail {
	private String spUrl; // 숙소 이미지
	private String riName; // 객실 이름
	private String srId; // 예약번호
	private String siAddress; // 숙소 주소
	private String siPhone; // 관리자 전화번호
	private String siEmail; // 관리자 이메일
	private String srStatus; // 예약 상태
	private Integer srAdult; // 어른 수
	private Integer srChild; // 아이 수
	private LocalDate srCheckin; // 체크인 날짜
	private LocalDate srCheckout; // 체크아웃 날짜
	private String srRequest; // 요청사항
	private Integer srTotalPrice; // 총 결제 금액
	private Integer srDiscount; // 할인 금액
	private String srPayment; // 결제 방법
	private String srPaydate; // 결제 날짜
	private String srCancelDate; // 취소 날짜
}
