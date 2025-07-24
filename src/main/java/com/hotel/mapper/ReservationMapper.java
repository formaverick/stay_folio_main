package com.hotel.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hotel.domain.ReservationCancelDTO;
import com.hotel.domain.ReservationCreateDTO;
import com.hotel.domain.ReservationDTO;
import com.hotel.domain.ReservationPageVO;

@Mapper
public interface ReservationMapper {
	ReservationPageVO getReservationPageInfo(@Param("riId") int riId, @Param("siId") int siId, @Param("miId") String miId); //예약페이지 
	int insertReservation(ReservationCreateDTO dto);	//예약 등록
	int checkDuplicateReservation(ReservationCreateDTO dto);	//중복 예약 체크
	ReservationDTO selectReservationById(String srId);	//예약 상세 조회
	int cancelReservation(ReservationCancelDTO dto);	//예약 취소
	int findSiIdByRiId(int riId);

}
