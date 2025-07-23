package com.hotel.service;


import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.hotel.domain.MemberVO;
import com.hotel.domain.StayVO;
import com.hotel.mapper.RecommendMapper;
import com.hotel.mapper.CommonMapper;

@Service
public class CommonServiceImpl implements CommonService {
	
  @Autowired
  private RecommendMapper recommendMapper;
  
	@Autowired
	private CommonMapper commonMapper;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;
  
  @Override
	public Map<String, Object> getRecommend(int rc_id) {
		String title = recommendMapper.getRecommendTitle(rc_id);
	    List<StayVO> stays = recommendMapper.getRecommend(rc_id);

	    Map<String, Object> map = new HashMap<>();
	    map.put("title", title);
	    map.put("stays", stays);
	    return map;
	}

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
