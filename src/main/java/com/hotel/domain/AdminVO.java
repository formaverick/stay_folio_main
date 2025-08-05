package com.hotel.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AdminVO {
	private int aiIdx;
	private String aiId;
	private String aiPw;
	private String aiName;
	private boolean aiIsuse;
	private Date aiDate;
}
