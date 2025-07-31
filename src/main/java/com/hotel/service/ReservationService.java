package com.hotel.service;

import java.time.LocalDate;

import com.hotel.domain.ReservationCreateDTO;
import com.hotel.domain.ReservationDTO;
import com.hotel.domain.ReservationDetail;
import com.hotel.domain.ReservationPageVO;
import com.hotel.domain.ReservationPriceResultDTO;

public interface ReservationService {
	public ReservationPageVO getReservationPageInfo(int riId, int siId, String miId); //예약페이지
	int reserve(ReservationCreateDTO dto); //예약 등록
	ReservationPageVO getReservationPageInfo(int riId, int siId, String miId,LocalDate checkin, LocalDate checkout,int adult, int child); //요금 계산 상세
	ReservationDetail getReservation(String reservationId); //예약 상세조회
	ReservationPriceResultDTO calculateRoomPrice(int riId, int siId,
            LocalDate checkin, LocalDate checkout,
            int adult, int child);// 방마다 가격 조회
	boolean isDuplicateReservation(int siId, int riId, LocalDate checkin, LocalDate checkout); //중복예약 방지
}

