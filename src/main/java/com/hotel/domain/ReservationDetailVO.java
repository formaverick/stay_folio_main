package com.hotel.domain;

import java.util.Date;

import lombok.Data;

@Data
public class ReservationDetailVO {
	private String srId;
	private int siId;
	private String siName;
	private String spUrl;
	private String siAddress;
	private String siPhone;
	private String siEmail;
	private int riId;
	private String riName;
	private String srName;
	private String srEmail;
	private String srPhone;
	private String srRequest;
	private Date srDate;
	private int srAdult;
	private int srChild;
	private Date srCheckin;
	private Date srCheckout;
	private int srRoomprice;
	private int srDiscount;
	private int srAddpersonFee;
	private int srTotalprice;
	private String srPayment;
	private Date srPaydate;
	private Date srCancledate;
	private String srStatus;
	private String srPaymentstatus;
}
