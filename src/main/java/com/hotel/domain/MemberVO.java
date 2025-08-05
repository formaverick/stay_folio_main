package com.hotel.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class MemberVO {
	private String miId;		// 회원 아이디(이메일)
	private String miPw;		// 비밀번호
	private String miName;		// 회원이름
	private String miGender;	// 성별
	private String miBirth;		// 생일
	private String miPhone;		// 전화번호
	private boolean miIsad;		// 광고수신여부
	private Date miDate;		// 가입일자
	private boolean miEnabled;	// 사용여부
	private List<String> roles;	// 권한 정보 리스트
}
