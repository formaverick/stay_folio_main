package com.hotel.domain;


import java.sql.Timestamp;
import java.time.LocalDate;
import java.util.Date;

import lombok.Data;

@Data
public class ReservationDetailVO {
	private String srId; //예약 번호
	private int siId; //숙소번호
	private String siName; //숙소이름
	private String spUrl; //이미지
	private String siAddress; //숙소 주소
	private String siPhone; //숙소 주인 전화번호
	private String siEmail;//숙소 주인 이메일
	private int riId;//객실 번호
	private String riName; //객실 이름
	private String srName; //예약자 이름
	private String srEmail; //예약자 이메일
	private String srPhone; //예약자 전화번호
	private String srRequest; //요청사항
	private int srAdult; //어른 수
	private int srChild; //아이 수

	private Timestamp srCheckin; //체크인 날짜
	private Timestamp srCheckout; //체크아웃 날짜
	private Timestamp srDate; //예약 일자
	private Timestamp srPaydate; //결제한 일자

	private int srRoomprice; //객실 가격
	private int srDiscount; //객실 할인 율
	private int srAddpersonFee; //추가인원 수
	private int srTotalprice; //전체 가격
	private String srPayment; //결제 방법

	private Date srCancledate; //취소 날짜
	private String srStatus; //예약 상태
	private String srPaymentstatus; //결제 상태
	private String miId; //회원 아이디
	private String riType; //형태
	private int riPerson; //기준 인원
	private String riDesc; //룸설명
	private int riMaxperson; //최대 인원
	
	private int riPrice;
	private long nights;
	
	private String miName;
	private String miPhone;

	private String riBed;
	private int riBedcnt;
	private int riBedroom;
	private int riBathroom;

	private double siPeak;     // 성수기 계수
	private double siOff;      // 비성수기 계수
	private double siDiscount; // 할인율
	
	private String siCheckin;
	private String siCheckout;
	private int siExtra;
	private double seasonRate;
}
