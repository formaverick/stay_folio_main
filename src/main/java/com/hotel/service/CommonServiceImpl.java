package com.hotel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hotel.domain.MemberVO;
import com.hotel.mapper.CommonMapper;

@Service
public class CommonServiceImpl implements CommonService {
	
	@Autowired
	private CommonMapper commonMapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public int handleRegister(MemberVO vo) {
		String encodedPassword = passwordEncoder.encode(vo.getMiPw());
		vo.setMiPw(encodedPassword);
		int result = commonMapper.handleRegister(vo);
		return result;
	}

	@Override
	public boolean isEmailDuplicate(String email) {
		System.out.println("isEmailDuplicate : " + commonMapper.countByEmail(email));
		return commonMapper.countByEmail(email) > 0;
	}

	@Override
	public boolean isPhoneDuplicate(String phone) {
		System.out.println("isPhoneDuplicate : " + commonMapper.countByPhone(phone));
		return commonMapper.countByPhone(phone) > 0;
	}

}
