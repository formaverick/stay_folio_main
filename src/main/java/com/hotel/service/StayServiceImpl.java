package com.hotel.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hotel.domain.Criteria;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StaySearchResultVO;
import com.hotel.domain.StayVO;
import com.hotel.mapper.AdminMapper;
import com.hotel.mapper.StayMapper;

@Service
public class StayServiceImpl implements StayService {

	@Autowired
	private StayMapper stayMapper;

	@Autowired
	private AdminMapper adminMapper;

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

	// 숙소 검색 - 전국 랜덤
	@Override
	public List<StayVO> getRandomStayList() {
		return stayMapper.selectRandomStayList();
	}

	// 지역 리스트
	@Override
	public List<LocationCategoryVO> getAllLocations() {
		return stayMapper.getAllLocations();
	}

	// 검색 리스트(지역,카테고리,체크인,체크아웃,총 인원)
	@Override
	public List<StaySearchResultVO> getStayListFiltered(Map<String, Object> param) {
		return stayMapper.selectStayListFiltered(param);
	}

	// 편의시설 리스트
	@Override
	public List<FacilityVO> getAllFacilities() {
		return stayMapper.getAllFacilities();
	}

	// admin - 숙소 등록
	@Override
	public void insertStayInfo(StayVO stay, StayDetailVO detail, List<Integer> facilityIds, List<Integer> keyword) {
		// 숙소 기본 정보
		stayMapper.insertStayInfo(stay);

		// 등록된 숙소 id
		int siId = stayMapper.getLastInsertId();

		// 상세 정보 id에 등록된 숙소 id 설정
		detail.setSiId(siId);
		// 숙소 상세 정보 등록
		stayMapper.insertStayDetail(detail);

		// 선택된 편의시설 등록
		if (facilityIds != null) {
			for (Integer fiId : facilityIds) {
				stayMapper.insertFacilityRel(siId, fiId);
			}
		}

		// 선택된 키워드 등록
		if (keyword != null) {
			for (Integer rcId : keyword) {
				adminMapper.insertCategoryStay(rcId, siId);
			}
		}
	}

	// 숙소 마지막 id 조회
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

	// admin - 숙소 전체
	@Override
	public List<StayVO> getListWithPaging(Criteria cri) {
		return stayMapper.getListWithPaging(cri);
	}

	@Override
	public List<StayVO> getAllStays() {
		return stayMapper.getAllStays(); // ← 이렇게 반드시 구현해야 에러가 사라짐
	}

	@Override
	public int getTotalCount(Criteria cri) {
		return stayMapper.getTotalCount(cri);
	}

	// admin - 숙소 사진 map
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

	// admin - 숙소 기본 정보 수정
	@Override
	public void updateStay(StayVO stay) {
		stayMapper.updateStay(stay);
	}

	// admin - 숙소 상세 정보 수정
	@Override
	public void updateStayDetail(StayDetailVO detail) {
		stayMapper.updateStayDetail(detail);
	}

	// admin - 숙소 편의 시설 수정
	@Override
	public void updateStayFacilities(int siId, List<Integer> facilityIds) {
		// null이면 skip, 선택 전부 해지했을 경우
		if (facilityIds == null || facilityIds.isEmpty()) {
			System.out.println("❗ 시설 선택 없음");
			stayMapper.deleteFacilitiesByStayId(siId); // 기존 것만 삭제
			return;
		}

		// 먼저 기존 데이터 삭제
		stayMapper.deleteFacilitiesByStayId(siId);

		// 다시 insert
		for (Integer fiId : facilityIds) {
			stayMapper.insertFacilityRel(siId, fiId);
		}
	}

	// admin 숙소 상세페이지 - 키워드
	@Override
	public List<RecommendCategoryVO> getKeywordByStayId(int siId) {
		return stayMapper.getKeywordByStayId(siId);
	}

	// admin - 숙소 id로 키워드 추가, 삭제
	@Override
	public List<RecommendCategoryVO> getAllKeywords() {
		return stayMapper.getAllKeywords();
	}

	@Override
	public List<Integer> getKeywordIdsByStayId(int siId) {
		return stayMapper.getKeywordIdsByStayId(siId);
	}

	@Override
	@Transactional
	public void updateStayKeywords(int siId, List<Integer> keywordIds) {
		// 아무것도 체크 안 한 경우: 전부 해제
		if (keywordIds == null || keywordIds.isEmpty()) {
			stayMapper.deleteKeywordsByStayId(siId);
			return;
		}
		stayMapper.deleteKeywordsByStayId(siId);
		for (Integer rcId : keywordIds) {
			stayMapper.insertKeywordForStay(rcId, siId);
		}
	}

	// 키워드 검색 (숙소명/지역명)
	@Override
	public List<StayVO> searchStaysByKeyword(String keyword) {
		if (keyword == null || keyword.trim().isEmpty()) {
			return new ArrayList<>();
		}
		return stayMapper.searchStaysByKeyword(keyword.trim());
	}

	// 키워드 추천 검색 (자동완성용, 최대 5개)
	@Override
	public List<StayVO> searchStaysSuggestions(String keyword) {
		if (keyword == null || keyword.trim().isEmpty()) {
			return new ArrayList<>();
		}
		return stayMapper.searchStaysSuggestions(keyword.trim());
	}

}