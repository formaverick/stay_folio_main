package com.hotel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;

@Mapper
public interface StayMapper {
	// 숙소 card
	StayVO selectStayInfo(int siId);

	// 숙소 상세페이지
	StayDetailVO selectStayDetail(int siId);

	// 숙소 상세페이지 - 객실 정보
	List<RoomVO> getRoomsByStayId(int siId);

	// 숙소 상세페이지 - 편의시설
	List<FacilityVO> getFacilitiesByStayId(int siId);
	
	
	// 숙소 검색 - 지역별
	List<StayVO> selectStayListByLcId(int lcId);
	List<StayVO> selectRandomStayList();

	
	// admin - 숙소 등록
	// 목록 조회
	List<LocationCategoryVO> getAllLocations();

	List<FacilityVO> getAllFacilities();

	// 등록
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
	
	
	// admin update
	void updateStay(StayVO stay);
	void updateStayDetail(StayDetailVO detail);
	void deleteFacilitiesByStayId(int siId);
	void insertFacility(@Param("siId") int siId, @Param("fiId") int fiId);
	boolean existsStayPhoto(PhotoVO photo);
	void updateStayPhoto(PhotoVO photo);

}
