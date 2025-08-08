package com.hotel.mapper;




import java.util.Date;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hotel.domain.ReservationCancelCheckVO;
import com.hotel.domain.ReservationDetailVO;

@Mapper
public interface ReservationMapper {
	ReservationDetailVO getReservationPageInfo(@Param("riId") int riId, @Param("siId") int siId, @Param("miId") String miId); //예약페이지 
	int insertReservation(ReservationDetailVO dto);	//예약 등록
	int checkDuplicateReservation(@Param("siId") int siId,	//중복예약 
            @Param("riId") int riId,
            @Param("checkin") Date checkin,
            @Param("checkout") Date checkout);
	ReservationDetailVO selectReservationById(String srId);//예약 상세 조회
	
	// 예약 취소
	ReservationCancelCheckVO selectReservationForCancel(String srId);
	public int cancelReservation(String id);
	

}
