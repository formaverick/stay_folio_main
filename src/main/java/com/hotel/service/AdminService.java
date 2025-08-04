package com.hotel.service;

import java.util.*;
import com.hotel.domain.MemberVO;
import com.hotel.domain.Criteria;

public interface AdminService {
	
	int getTotalMemberCount(Criteria cri);

    List<MemberVO> getMemberList(Criteria cri);
}
