package com.hotel.service;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.RoomVO;
import com.hotel.mapper.RoomMapper;

import lombok.RequiredArgsConstructor;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

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
