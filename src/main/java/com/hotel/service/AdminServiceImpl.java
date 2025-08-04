package com.hotel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.domain.Criteria;
import com.hotel.domain.MemberVO;
import com.hotel.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {
	 
	@Autowired
	private AdminMapper adminMapper;
	
	@Override
	public int getTotalMemberCount(Criteria cri) {
	    return adminMapper.getTotalMemberCount(cri);
	}
	@Override
	public List<MemberVO> getMemberList(Criteria cri) {
	    return adminMapper.selectMembersWithPaging(cri);
	}
}