package com.hotel.service;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RoomPhotoVO;
import com.hotel.domain.RoomVO;
import com.hotel.mapper.RoomMapper;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class RoomServiceImpl implements RoomService {
	@Autowired
	private RoomMapper roomMapper;
	
	// 객실 상세페이지
	@Override
	public RoomVO getRoomById(int siId, int riId) {
	    return roomMapper.getRoomById(siId, riId);
	}
	
	// 객실 상세페이지 - 편의시설
	@Override
	public List<FacilityVO> getFacilitiesByRoomId(int siId, int riId) {
		return roomMapper.getFacilitiesByRoomId(siId, riId);
	}
	
	// 객실 상세페이지 - 어메니티
	@Override
	public List<AmenityVO> getAmenitiesByRoomId(int siId, int riId) {
	    return roomMapper.getAmenitiesByRoomId(siId, riId);
	}

	// 객실 상세페이지 - 다른 객실
	@Override
	public List<RoomVO> getOtherRoomsByStayId(int siId, int riId) {
	    return roomMapper.getOtherRoomsByStayId(siId, riId);
	}
	
	@Override
	public Map<String, List<RoomPhotoVO>> getRoomPhotosByCategory(int siId, int riId) {
		List<RoomPhotoVO> photos = roomMapper.getRoomPhotos(siId, riId);

		Map<String, List<RoomPhotoVO>> photoMap = new HashMap<>();

		photoMap.put("main", new ArrayList<>());
		photoMap.put("additional", new ArrayList<>());
		photoMap.put("feature", new ArrayList<>());
		photoMap.put("feat1", new ArrayList<>());
		photoMap.put("feat2", new ArrayList<>());

		for (RoomPhotoVO photo : photos) {
			int idx = photo.getSpIdx();
			if (idx == 0)
				photoMap.get("main").add(photo);
			else if (idx <= 2)
				photoMap.get("additional").add(photo);
			else if (idx <= 5)
				photoMap.get("feature").add(photo);
			else if (idx <= 8)
				photoMap.get("feat1").add(photo);
			else
				photoMap.get("feat2").add(photo);
		}

		return photoMap;
	}
	
	@Override
	public Map<Integer, RoomPhotoVO> getMainPhotoForRooms(int siId) {
	    List<RoomPhotoVO> photos = roomMapper.getMainPhotosForAllRooms(siId);
	    Map<Integer, RoomPhotoVO> map = new HashMap<>();

	    for (RoomPhotoVO photo : photos) {
	        map.put(photo.getRiId(), photo);  // 각 객실 번호의 대표 이미지 1장만
	    }

	    return map;
	}

	
	// admin - 객실 등록
	@Override
	public List<AmenityVO> getAllAmenities() {
		return roomMapper.getAllAmenities();
	}
	
	@Override
	public int insertRoom(RoomVO vo, List<Integer> facilities, List<Integer> amenities) {
		roomMapper.insertRoom(vo);
		
		int riId = vo.getRiId();
		int siId = vo.getSiId();
		
		// 객실 편의시설 insert
		if (facilities != null) {
			for (Integer fiId : facilities) {
				roomMapper.insertRoomFacility(siId, riId, fiId);
			}
		}

		// 객실 어메니티 insert
		if (amenities != null) {
			for (Integer aiIdx : amenities) {
				roomMapper.insertRoomAmenity(siId, riId, aiIdx);
			}
		}
		
		return riId;
	}
}
