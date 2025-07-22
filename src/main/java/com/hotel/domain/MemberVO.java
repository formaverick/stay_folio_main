package com.hotel.domain;

import java.util.Date;

import lombok.Data;

@Data
public class MemberVO {
	private String mi_id;
	private String mi_pw;
	private String mi_name;
	private String mi_gender;
	private String mi_birth;
	private String mi_phone;
	private boolean mi_isad;	// 수정 필요
	private Date mi_date;
	private boolean mi_enabled;
}
