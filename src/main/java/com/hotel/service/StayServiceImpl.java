package com.hotel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.mapper.StayMapper;

@Service
public class StayServiceImpl implements StayService {

	@Autowired
	private StayMapper stayMapper;

//	숙소 card
	@Override
	public StayVO getStayInfo(int siId) {
		return stayMapper.selectStayInfo(siId);
	}
	
	
// 	숙소 상세페이지
	@Override
	public StayDetailVO getStayDetail(int siId) {
		return stayMapper.selectStayDetail(siId);
	}
	
	// 숙소 상세페이지 - 객실 출력
	@Override
	public List<RoomVO> getRoomsByStayId(int siId) {
		return stayMapper.getRoomsByStayId(siId);
	}


	// 숙소 상세페이지 - 편의시설
	@Override
	public List<FacilityVO> getFacilitiesByStayId(int siId) {
		return stayMapper.getFacilitiesByStayId(siId);
	}

	

//	admin insert

	@Override
	public List<LocationCategoryVO> getAllLocations() {
		return stayMapper.getAllLocations();
	}

	@Override
	public List<FacilityVO> getAllFacilities() {
		return stayMapper.getAllFacilities();
	}
	
	@Override
	public void insertStayInfo(StayVO stay, StayDetailVO detail, List<Integer> facilityIds) {
		stayMapper.insertStayInfo(stay);
		
		int siId = stayMapper.getLastInsertId();

		detail.setSiId((long)siId);
		stayMapper.insertStayDetail(detail);

		for (Integer fiId : facilityIds) {
			stayMapper.insertFacilityRel(siId, fiId);
		}
	}

	
	
	// 객실 상세페이지
	@Override
	public RoomVO getRoomById(int siId, int riId) {
	    return stayMapper.getRoomById(siId, riId);
	}
	
	// 객실 상세페이지 - 편의시설
	@Override
	public List<FacilityVO> getFacilitiesByRoomId(int siId, int riId) {
		return stayMapper.getFacilitiesByRoomId(siId, riId);
	}
	
	// 객실 상세페이지 - 어메니티
	@Override
	public List<AmenityVO> getAmenitiesByRoomId(int siId, int riId) {
	    return stayMapper.getAmenitiesByRoomId(siId, riId);
	}

	// 객실 상세페이지 - 다른 객실
	@Override
	public List<RoomVO> getOtherRoomsByStayId(int siId, int riId) {
	    return stayMapper.getOtherRoomsByStayId(siId, riId);
	}


}