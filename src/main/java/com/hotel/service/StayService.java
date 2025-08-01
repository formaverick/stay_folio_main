package com.hotel.service;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hotel.domain.FacilityVO;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;

public interface StayService {
	// 숙소 card
	StayVO getStayInfo(int siId);
	
	
	// 숙소 상세페이지
    StayDetailVO getStayDetail(int siId);
    // 숙소 상세페이지 - 객실
    public List<RoomVO> getRoomsByStayId(int siId);
    // 숙소 상세페이지 - 편의시설
    List<FacilityVO> getFacilitiesByStayId(int siId);
    
    // 숙소 검색 - 지역별
    List<StayVO> getStayListByLcId(int lcId);
    List<StayVO> getRandomStayList();
    
    
    // admin - 숙소 등록
    List<LocationCategoryVO> getAllLocations();
    List<FacilityVO> getAllFacilities();
    void insertStayInfo(StayVO stay, StayDetailVO detail, List<Integer> facilityIds);
    int getLastInsertId();
    void insertStayDetail(StayDetailVO detail);
    void insertFacilityRel(@Param("siId") int siId, @Param("fiId") int fiId);
    
    // admin List - 모든 숙소 불러오기
    List<StayVO> getAllStays();
   
    // admin 숙소 상세조회 이미지 가져오기
    Map<String, List<PhotoVO>> getStayPhotosByCategory(int siId);
    List<PhotoVO> getAllStayPhotos(int siId);
    
    // admin update
    void updateStay(StayVO stay);
    void updateStayDetail(StayDetailVO detail);
    void updateStayFacilities(int siId, List<Integer> facilityIds);
}
