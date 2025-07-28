package com.hotel.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReservationListVO {
	private String srId;
	private int siId;
	private String siName;
	private int riId;
	private String riName;
	private String spUrl;	// 객실 이미지
	private Date srCheckin;
	private Date srCheckout;
	private int nights;
	private int srAdult;
	private int srChild;
	private int srTotalprice;
	private String srStatus;
}
