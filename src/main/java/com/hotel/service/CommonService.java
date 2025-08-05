package com.hotel.service;

import java.util.Map;
import com.hotel.domain.MemberVO;

public interface CommonService {
  
	Map<String, Object> getRecommend(int rc_id, String miId);

	int handleRegister(MemberVO vo);

	boolean isEmailDuplicate(String email);

	boolean isPhoneDuplicate(String phone);
}
