package com.hotel.mapper;

import java.util.List;

import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationListVO;
import com.hotel.domain.StayVO;

public interface MypageMapper {
	// 회원별 체크아웃까지 완료된 예약 개수
	public int getCompletedStayCount(String id);
	
	// 회원별 다가오는 예약 리스트
	public List<ReservationListVO> getUpcomingReservationByMember(String id);
	
	// 회원별 체크인 완료 및 취소 예약 리스트
	public List<ReservationListVO> getCompletedReservationsByMember(String id);
	
	// 예약번호로 예약 상세 불러오기
	public ReservationDetailVO getReservationDetail(String id);
	
	// 회원별 북마크 리스트 불러오기
	public List<StayVO> getBookMarkList(String id);
}
