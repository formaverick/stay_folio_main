package com.hotel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
	public StayVO getStayInfo(int si_id) {
		return stayMapper.selectStayInfo(si_id);
	}
	
	
// 	숙소 상세페이지
	@Override
	public StayDetailVO getStayDetail(int si_id) {
		return stayMapper.selectStayDetail(si_id);
	}
	
	// 숙소 상세페이지 - 객실 출력
	@Override
	public List<RoomVO> getRoomsByStayId(int si_id) {
		return stayMapper.getRoomsByStayId(si_id);
	}


	// 숙소 상세페이지 - 편의시설
	@Override
	public List<FacilityVO> getFacilitiesByStayId(int si_id) {
		return stayMapper.getFacilitiesByStayId(si_id);
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
		
		int si_id = stayMapper.getLastInsertId();

		detail.setSi_id((long)si_id);
		stayMapper.insertStayDetail(detail);

		for (Integer fi_id : facilityIds) {
			stayMapper.insertFacilityRel(si_id, fi_id);
		}
	}

	
	
	// 객실 상세페이지 - 편의시설
	@Override
	public List<FacilityVO> getFacilitiesByRoomId(int ri_id) {
		return stayMapper.getFacilitiesByRoomId(ri_id);
	}

}