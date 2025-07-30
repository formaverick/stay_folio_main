package com.hotel.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.PhotoVO;
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

	// 숙소 검색 - 지역별
	@Override
	public List<StayVO> getStayListByLcId(int lcId) {
		return stayMapper.selectStayListByLcId(lcId);
	}

	@Override
	public List<StayVO> getRandomStayList() {
		return stayMapper.selectRandomStayList();
	}

//	admin - 숙소 등록

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

		detail.setSiId((long) siId);
		stayMapper.insertStayDetail(detail);

		if (facilityIds != null) {
			for (Integer fiId : facilityIds) {
				stayMapper.insertFacilityRel(siId, fiId);
			}
		}
	}

	@Override
	public int getLastInsertId() {
		return stayMapper.getLastInsertId();
	}

	@Override
	public void insertStayDetail(StayDetailVO detail) {
		stayMapper.insertStayDetail(detail);
	}

	@Override
	public void insertFacilityRel(int siId, int fiId) {
		stayMapper.insertFacilityRel(siId, fiId);
	}

	@Override
	public List<StayVO> getAllStays() {
		return stayMapper.getAllStays();
	}

	@Override
	public Map<String, List<PhotoVO>> getStayPhotosByCategory(int siId) {
		List<PhotoVO> photos = stayMapper.getStayPhotos(siId);

		Map<String, List<PhotoVO>> photoMap = new HashMap<>();

		photoMap.put("main", new ArrayList<>());
		photoMap.put("additional", new ArrayList<>());
		photoMap.put("feature", new ArrayList<>());
		photoMap.put("feat1", new ArrayList<>());
		photoMap.put("feat2", new ArrayList<>());

		for (PhotoVO photo : photos) {
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
	public List<PhotoVO> getAllStayPhotos(int siId) {
		return stayMapper.getStayPhotos(siId);
	}

	@Override
	public void updateStay(StayVO stay) {
		stayMapper.updateStay(stay);
	}

	@Override
	public void updateStayDetail(StayDetailVO detail) {
		stayMapper.updateStayDetail(detail);
	}

	@Override
	public void updateStayFacilities(int siId, List<Integer> facilityIds) {
		// 먼저 기존 데이터 삭제
		stayMapper.deleteFacilitiesByStayId(siId);

		// 다시 insert
		for (Integer fiId : facilityIds) {
			stayMapper.insertFacility(siId, fiId);
		}
	}

}