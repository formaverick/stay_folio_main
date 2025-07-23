package com.hotel.service;

import java.util.List;

import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;

public interface StayService {
	// 숙소 상세페이지
	StayVO getStayInfo(int si_id);
    StayDetailVO getStayDetail(int si_id);
    
    // admin insert
    void insertStayInfo(StayVO stay, StayDetailVO detail, List<Integer> facilityIds);
    List<LocationCategoryVO> getAllLocations();
    List<FacilityVO> getAllFacilities();
    
    // 숙소 상세페이지 - 객실
    public List<RoomVO> getRoomsByStayId(int si_id);
    // 숙소 상세페이지 - 편의시설
    List<FacilityVO> getFacilitiesByStayId(int si_id);
    
    // 객실 상세페이지 - 편의시설
    List<FacilityVO> getFacilitiesByRoomId(int ri_id);
}
