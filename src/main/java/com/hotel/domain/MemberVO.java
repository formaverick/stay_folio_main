package com.hotel.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String miId;
	private String miPw;
	private String miName;
	private String miGender;
	private String miBirth;
	private String miPhone;
	private boolean miIsad;	// 수정 필요
	private Date miDate;
	private boolean miEnabled;
}
