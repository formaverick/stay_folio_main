package com.hotel.service;


import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.RoomPhotoVO;
import com.hotel.domain.RoomVO;

import java.util.List;
import java.util.Map;

public interface RoomService {
	
	// 객실 상세페이지
    RoomVO getRoomById(int siId, int riId);
    // 객실 상세페이지 - 편의시설
    List<FacilityVO> getFacilitiesByRoomId(int siId, int riId);
    // 객실 상세페이지 - 어메니티
    List<AmenityVO> getAmenitiesByRoomId(int siId, int riId);
    // 객실 상세페이지 - 다른 객실
    List<RoomVO> getOtherRoomsByStayId(int siId, int riId);
    // 객실 상세페이지 - 이미지
    Map<String, List<RoomPhotoVO>> getRoomPhotosByCategory(int siId, int riId);
    // 숙소 상세페이지 - 객실 메인이미지 가져오기
    Map<Integer, RoomPhotoVO> getMainPhotoForRooms(int siId);
    
    // admin - 객실 등록
    int insertRoom(RoomVO vo, List<Integer> facilities, List<Integer> amenities);
    List<AmenityVO> getAllAmenities();
}
