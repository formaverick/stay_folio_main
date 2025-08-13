package com.hotel.service;

import java.util.List;

import com.hotel.domain.MemberVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationListVO;
import com.hotel.domain.StayVO;

public interface MypageService {

	int getCompletedStayCount(String id);

	List<ReservationListVO> getUpcomingReservationByMember(String id);

	List<ReservationListVO> getCompletedReservationsByMember(String id);

	ReservationDetailVO getReservationDetail(String id);

	List<StayVO> getBookMarkList(String id);

	MemberVO readMemberById(String miId);

	void updateMemberProfile(MemberVO vo);

	void changePassword(String miId, String currentPw, String newPw);

	int countByPhoneNormalized(String digits);

	int countByPhoneNormalizedExceptSelf(String digits, String miId);
}
