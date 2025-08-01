package com.hotel.mapper;

import java.util.List;

import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationListVO;
import com.hotel.domain.StayVO;

public interface MypageMapper {
	public int getCompletedStayCount(String id);
	
	public List<ReservationListVO> getUpcomingReservationByMember(String id);
	
	public List<ReservationListVO> getCompletedReservationsByMember(String id);
	
	public ReservationDetailVO getReservationDetail(String id);
	
	public List<StayVO> getBookMarkList(String id);
}
