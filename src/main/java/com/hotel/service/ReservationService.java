package com.hotel.service;

import java.time.LocalDate;

import com.hotel.domain.ReservationCancelCheckVO;
import com.hotel.domain.ReservationCreateDTO;
import com.hotel.domain.ReservationDTO;
import com.hotel.domain.ReservationDetail;
import com.hotel.domain.ReservationPageVO;

public interface ReservationService {
	public ReservationPageVO getReservationPageInfo(int riId, int siId, String miId); //예약페이지
	int reserve(ReservationCreateDTO dto); //예약 등록
	ReservationPageVO getReservationPageInfo(int riId, int siId, String miId,LocalDate checkin, LocalDate checkout,int adult, int child); //요금 계산 상세
	ReservationDetail getReservation(String reservationId); //예약 상세조회
	
	// 예약 취소
	public ReservationCancelCheckVO getReservationById(String id);
	int cancelReservation(String id);

}

