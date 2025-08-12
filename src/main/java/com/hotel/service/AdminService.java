package com.hotel.service;

import java.util.List;
import java.util.Map;

import com.hotel.domain.Criteria;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.MemberVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.ReservationStatsDTO;
import com.hotel.domain.StayVO;
import com.hotel.domain.AdminReservationCriteria;
import com.hotel.domain.AdminReservationListDTO;

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
    RecommendCategoryVO getCategory(int rcId);
    List<StayVO> getRecommendStayList(int rcId);
    
    // categoryUpdate
    List<StayVO> getUnrecommendedStays(int rcId);
    void updateCategory(RecommendCategoryVO category);
    
    // category/keyword stay Update
    void deleteCategoryStay(int rcId, int siId);
    void insertCategoryStay(int rcId, int siId);
    
	// keywordDetail
    RecommendCategoryVO getKeyWord(int rcId);
    List<StayVO> getKeyWordStayList(int rcId);
    
    // keywordUpdate
    void updateKeyword(RecommendCategoryVO keyword);

    // Reservation List (Admin)
    List<AdminReservationListDTO> getReservationList(AdminReservationCriteria cri);
    int getReservationListCount(AdminReservationCriteria cri);
}
