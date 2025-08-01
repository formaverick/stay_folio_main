package com.hotel.service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationListVO;
import com.hotel.domain.StayVO;
import com.hotel.mapper.MypageMapper;

@Service
public class MypageServiceImpl implements MypageService {
	
	@Autowired
	private MypageMapper mypageMapper;

	@Override
	public int getCompletedStayCount(String id) {
		return mypageMapper.getCompletedStayCount(id);
	}

	@Override
	public List<ReservationListVO> getUpcomingReservationByMember(String id) {
		List<ReservationListVO> upcomingList = mypageMapper.getUpcomingReservationByMember(id);
		
		for (ReservationListVO reserv : upcomingList) {
			LocalDate checkin = reserv.getSrCheckin().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		    LocalDate checkout = reserv.getSrCheckout().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		    
		    long diff = ChronoUnit.DAYS.between(checkin, checkout);
			reserv.setNights((int) diff);
		}
		
		return upcomingList;
	}

	@Override
	public List<ReservationListVO> getCompletedReservationsByMember(String id) {
		List<ReservationListVO> completedList = mypageMapper.getCompletedReservationsByMember(id);
		
		for (ReservationListVO reserv : completedList) {
			LocalDate checkin = reserv.getSrCheckin().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		    LocalDate checkout = reserv.getSrCheckout().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
		    
		    long diff = ChronoUnit.DAYS.between(checkin, checkout);
			reserv.setNights((int) diff);
		}
		
		return completedList;
	}

	@Override
	public ReservationDetailVO getReservationDetail(String id) {
		return mypageMapper.getReservationDetail(id);
	}

	@Override
	public List<StayVO> getBookMarkList(String id) {
		return mypageMapper.getBookMarkList(id);
	}

}
