package com.hotel.service;

import com.hotel.domain.MemberVO;

public interface CommonService {

	int handleRegister(MemberVO vo);

	boolean isEmailDuplicate(String email);

	boolean isPhoneDuplicate(String phone);
}
