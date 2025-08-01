package com.hotel.service;

import java.util.List;

import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationListVO;
import com.hotel.domain.StayVO;

public interface MypageService {

	int getCompletedStayCount(String id);
	
	List<ReservationListVO> getUpcomingReservationByMember(String id);
	
	List<ReservationListVO> getCompletedReservationsByMember(String id);
	
	ReservationDetailVO getReservationDetail(String id);
	
	int cancelReservation(String id);
	
	List<StayVO> getBookMarkList(String id);
}
