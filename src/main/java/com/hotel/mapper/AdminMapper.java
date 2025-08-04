package com.hotel.mapper;

import java.util.List;

import com.hotel.domain.Criteria;
import com.hotel.domain.MemberVO;

public interface AdminMapper {
	
	public int getTotalMemberCount(Criteria cri);

	List<MemberVO> selectMembersWithPaging(Criteria cri);
	
}

