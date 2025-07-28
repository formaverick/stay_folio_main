package com.hotel.domain;

import java.util.Date;

import lombok.Data;

@Data
public class BookmarkVO {
	private int siId;
	private Date sbRegdate;
	private String siName;
	private String siLoca;
	private int siMinperson;
	private int siMaxperson;
	private int siMinprice;
	private double siPeak;
	private double siOff;
	private double siDiscount;
}
