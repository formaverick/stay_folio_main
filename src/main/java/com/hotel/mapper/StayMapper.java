package com.hotel.mapper;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StaySearchResultVO;
import com.hotel.domain.StayVO;

@Mapper
public interface StayMapper {
	// 숙소 card(추천카테고리별)
	StayVO selectStayInfo(int siId);

	// 숙소 상세페이지
	StayDetailVO selectStayDetail(int siId);

	// 숙소 상세페이지 - 객실 정보
	List<RoomVO> getRoomsByStayId(int siId);

	// 숙소 상세페이지 - 편의시설
	List<FacilityVO> getFacilitiesByStayId(int siId);

	// 숙소 검색 - 지역별
	List<StayVO> selectStayListByLcId(int lcId);

	// 숙소 검색 - 전국 랜덤
	List<StayVO> selectRandomStayList();

	// 지역 목록 조회
	List<LocationCategoryVO> getAllLocations();

	// Mapper 인터페이스
	List<StaySearchResultVO> selectStayListFiltered(Map<String, Object> param);

	List<StayVO> selectRecommendStayListByLcId(@Param("rcId") int rcId, @Param("lcId") int lcId);

	// 편의시설 목록 조회
	List<FacilityVO> getAllFacilities();

	// admin - 숙소 등록(기본 정보, 상세 정보, 편의시설, 사진)
	void insertStayInfo(StayVO stay);

	int getLastInsertId();

	void insertStayDetail(StayDetailVO detail);

	void insertFacilityRel(@Param("siId") int siId, @Param("fiId") int fiId);

	void insertStayPhoto(PhotoVO photo);
	// admin - 숙소 등록 끝

	// 모든 숙소 불러오기
	List<StayVO> getAllStays();

	// 숙소 이미지 불러오기
	List<PhotoVO> getStayPhotos(int siId);

	// admin - 숙소 기본 정보 수정
	void updateStay(StayVO stay);

	// admin - 숙소 상제 정보 수정
	void updateStayDetail(StayDetailVO detail);

	// admin - 숙소 편의 시설 전체 삭제
	void deleteFacilitiesByStayId(int siId);

	// admin - 숙소 편의 시설 등록
	void insertFacility(@Param("siId") int siId, @Param("fiId") int fiId);

	// admin - 숙소 사진 존재 여부 확인
	boolean existsStayPhoto(PhotoVO photo);

	// admin - 숙소 사진 수정
	void updateStayPhoto(PhotoVO photo);

}
