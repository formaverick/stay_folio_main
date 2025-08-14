package com.hotel.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hotel.domain.Criteria;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StaySearchResultVO;
import com.hotel.domain.StayVO;

public interface StayService {
	// 숙소 card
	StayVO getStayInfo(int siId);

	// 숙소 상세페이지
	StayDetailVO getStayDetail(int siId);

	// 숙소 상세페이지 - 객실(숙소 id로)
	public List<RoomVO> getRoomsByStayId(int siId);

	// 숙소 상세페이지 - 편의시설
	List<FacilityVO> getFacilitiesByStayId(int siId);

	// 숙소 검색 - 지역별
	List<StayVO> getStayListByLcId(int lcId);

	// 숙소 검색 - 기본(전국) 랜덤 리스트
	List<StayVO> getRandomStayList();

	// 날짜, 인원, 추천 카테고리 포함 필터 검색
	 List<StaySearchResultVO> getStayListFiltered(Map<String, Object> param);
	
	 List<StayVO> getListWithPaging(Criteria cri);
	 
	 int getTotalCount(Criteria cri);

	// admin - 숙소 등록 (지역 리스트)
	List<LocationCategoryVO> getAllLocations();

	// admin - 숙소 등록 (편의시설 리스트)
	List<FacilityVO> getAllFacilities();

	// admin - 숙소 기본 정보 등록
	void insertStayInfo(StayVO stay, StayDetailVO detail, List<Integer> facilityIds, List<Integer> keyword);

	// admin - 숙소 마지막 id 가져오기
	int getLastInsertId();

	// admin - 숙소 상세 정보 등록
	void insertStayDetail(StayDetailVO detail);

	// admin - 숙소 편의시설 등록
	void insertFacilityRel(@Param("siId") int siId, @Param("fiId") int fiId);

	// admin - 모든 숙소 불러오기
	List<StayVO> getAllStays();

	// admin - 숙소 상세 조회 이미지 가져오기 (카테고리 별)
	Map<String, List<PhotoVO>> getStayPhotosByCategory(int siId);

	// 숙소 모든 이미지 리스트
	List<PhotoVO> getAllStayPhotos(int siId);

	// admin - 숙소 기본 정보 수정
	void updateStay(StayVO stay);

	// admin - 숙소 상세 정보 수정
	void updateStayDetail(StayDetailVO detail);

	// admin - 숙소 편의 시설 수정
	void updateStayFacilities(int siId, List<Integer> facilityIds);

	  // admin 숙소 상세페이지 - 키워드
  List<RecommendCategoryVO> getKeywordByStayId(int siId);
  
  // admin - 숙소 id로 키워드 추가, 삭제
  List<RecommendCategoryVO> getAllKeywords();
  List<Integer> getKeywordIdsByStayId(int siId);
  void updateStayKeywords(int siId, List<Integer> keywordIds);

  // 키워드 검색
	List<StayVO> searchStaysByKeyword(String keyword);
	
	// 자동완성용ㄴ
	List<StayVO> searchStaysSuggestions(String keyword);
  
}
