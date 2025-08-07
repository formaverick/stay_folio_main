package com.hotel.mapper;

import com.hotel.domain.MemberVO;

public interface CommonMapper {
	// 회원 정보
	public MemberVO read(String miId);
	
	// 이메일이 같은 회원 수
	public int countByEmail(String email);
	// 전화번호가 같은 회원 수 
	public int countByPhone(String phone);
	
	// 회원등록
	public int handleRegister(MemberVO vo);
}
