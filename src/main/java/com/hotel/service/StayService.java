package com.hotel.service;

import java.util.List;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;

public interface StayService {
	// 숙소 card
	StayVO getStayInfo(int siId);
	
	
	// 숙소 상세페이지
    StayDetailVO getStayDetail(int siId);
    // 숙소 상세페이지 - 객실
    public List<RoomVO> getRoomsByStayId(int siId);
    // 숙소 상세페이지 - 편의시설
    List<FacilityVO> getFacilitiesByStayId(int siId);
    
    
    
    // admin insert
    void insertStayInfo(StayVO stay, StayDetailVO detail, List<Integer> facilityIds);
    List<LocationCategoryVO> getAllLocations();
    List<FacilityVO> getAllFacilities();
    

    // 객실 상세페이지
    RoomVO getRoomById(int siId, int riId);
    // 객실 상세페이지 - 편의시설
    List<FacilityVO> getFacilitiesByRoomId(int siId, int riId);
    // 객실 상세페이지 - 어메니티
    List<AmenityVO> getAmenitiesByRoomId(int siId, int riId);
    // 객실 상세페이지 - 다른 객실
    List<RoomVO> getOtherRoomsByStayId(int siId, int riId);
}
