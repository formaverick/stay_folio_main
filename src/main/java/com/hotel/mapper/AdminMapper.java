package com.hotel.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.hotel.domain.Criteria;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.MemberVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.ReservationStatsDTO;
import com.hotel.domain.StayVO;

public interface AdminMapper {
	
	public int getTotalMemberCount(Criteria cri);

	List<MemberVO> selectMembersWithPaging(Criteria cri);
	
	// DashBoard
	public List<RecommendCategoryVO> getAllCategoryTopDetails();
	
	List<RecommendCategoryVO> getRecommendKeyword();
	
	ReservationStatsDTO getReservationStats();
	
	Map<String, Integer> getMemberVsGuestRatio();
	
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
	void deleteCategoryStay(@Param("rcId") int rcId, @Param("siId") int siId);
	void insertCategoryStay(@Param("rcId") int rcId, @Param("siId") int siId);
	
}

