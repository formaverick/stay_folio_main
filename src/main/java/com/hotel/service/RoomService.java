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

	// 객실 상세페이지 - 다른 객실 (선택된 id제외 검색)
	List<RoomVO> getOtherRoomsByStayId(int siId, int riId);

	// 객실 상세페이지 - 이미지
	Map<String, List<RoomPhotoVO>> getRoomPhotosByCategory(int siId, int riId);

	// 객실 상세페이지 - 객실 메인이미지 가져오기
	Map<Integer, RoomPhotoVO> getMainPhotoForRooms(int siId);

	// admin - 객실 등록
	int insertRoom(RoomVO vo, List<Integer> facilities, List<Integer> amenities);

	// 모든 어메니티
	List<AmenityVO> getAllAmenities();

	// 객실 수정 form - 기존 이미지 불러오기
	List<RoomPhotoVO> getAllRoomPhotos(int siId, int riId);

	// 객실 수정(기본정보, 편의시설, 어메니티)
	void updateRoom(RoomVO room);

	void updateRoomFacilities(int siId, int riId, List<Integer> facilityIds);

	void updateRoomAmenities(int siId, int riId, List<Integer> amenityIds);
}
