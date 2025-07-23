package com.hotel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;

@Mapper
public interface StayMapper {
	// 숙소 card
	StayVO selectStayInfo(int si_id);

	// 숙소 상세페이지
	StayDetailVO selectStayDetail(int si_id);

	// 숙소 상세페이지 - 객실 정보
	List<RoomVO> getRoomsByStayId(int si_id);
	
	// 숙소 상세페이지 - 편의시설
	List<FacilityVO> getFacilitiesByStayId(int si_id);
	
	
	// admin insert 시작
	// 목록 조회
	List<LocationCategoryVO> getAllLocations();

	List<FacilityVO> getAllFacilities();

	// 등록
	void insertStayInfo(StayVO stay);

	int getLastInsertId();

	void insertStayDetail(StayDetailVO detail);

	void insertFacilityRel(@Param("si_id") int si_id, @Param("fi_id") int fi_id);
	// admin insert 끝
	
	
	// 객실 상세페이지 - 편의시설
	List<FacilityVO> getFacilitiesByRoomId(int ri_id);
}
