package com.hotel.service;

import java.time.LocalDate;

import com.hotel.domain.ReservationCancelDTO;
import com.hotel.domain.ReservationCreateDTO;
import com.hotel.domain.ReservationDTO;
import com.hotel.domain.ReservationPageVO;
import com.hotel.domain.ReservationPriceResultDTO;

public interface ReservationService {
	public ReservationPageVO getReservationPageInfo(int riId, int siId, String miId); //예약페이지
	int reserve(ReservationCreateDTO dto); //예약 등록
	ReservationDTO getReservation(String srId); //예약 상세 조회
	int CancelReservation(ReservationCancelDTO dto); //예약 취소
	int findSiIdByRiId(int riId); 
	ReservationPageVO getReservationPageInfo(int riId, int siId, String miId,
            LocalDate checkin, LocalDate checkout,
            int adult, int child);
	

}

