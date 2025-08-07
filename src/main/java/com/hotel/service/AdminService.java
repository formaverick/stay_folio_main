package com.hotel.service;

import java.util.List;
import java.util.Map;

import com.hotel.domain.Criteria;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.MemberVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.ReservationStatsDTO;
import com.hotel.domain.StayVO;

public interface AdminService {
	
	int getTotalMemberCount(Criteria cri);

    List<MemberVO> getMemberList(Criteria cri);
    
    // DashBoard
    List<RecommendCategoryVO> getAllCategoryTopDetails();
    
    List<RecommendCategoryVO> getRecommendKeyword();
    
    ReservationStatsDTO getReservationStats();
    
    public Map<String, Integer> getMemberVsGuestRatio();
    
    double getReservationCancelRate();
    
    List<LocationCategoryVO> getStayCountByRegion();
    
    List<StayVO> getTopReservedStays();
    
    List<StayVO> getTopBookmarkedStays();
    
    
    // categoryDetail
    RecommendCategoryVO getAllCategory(int rcId);
    
    List<StayVO> getRecommendStayList(int rcId);
    
    List<StayVO> getUnrecommendedStays(int rcId);
    
    // categoryUpdate
    void updateCategory(RecommendCategoryVO category);
    void deleteCategoryStay(int rcId, int siId);
    void insertCategoryStay(int rcId, int siId);
}
