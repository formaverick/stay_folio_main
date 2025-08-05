package com.hotel.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReservationListVO {
	private String srId; //예약 번호
	private int siId; //숙소번호
	private String siName; //숙소 이름
	private int riId; //객실 번호
	private String riName; //객실 이름
	private String spUrl;	// 객실 이미지
	private Date srCheckin; //체크인 날짜
	private Date srCheckout; //체크아웃 날짜
	private int nights; //박
	private int srAdult; //어른 수
	private int srChild; //아이 수
	private int srTotalprice; //전체 가격
	private String srStatus; //예약 상태
}
