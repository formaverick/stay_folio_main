package com.hotel.mapper;

import com.hotel.domain.MemberVO;

public interface CommonMapper {
	public MemberVO read(String miId);
	
	public int countByEmail(String email);
	public int countByPhone(String phone);
	
	public int handleRegister(MemberVO vo);
}
