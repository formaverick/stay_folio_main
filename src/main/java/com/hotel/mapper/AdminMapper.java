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
import com.hotel.domain.AdminReservationListDTO;
import com.hotel.domain.AdminReservationCriteria;

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
	RecommendCategoryVO getCategory(int rcId);

	// categoryDetail, keywordDetail 숙소 리스트
	List<StayVO> getRecommendStayList(int rcId);

	List<StayVO> getUnrecommendedStays(int rcId);

	// categoryUpdate
	void updateCategory(RecommendCategoryVO category);

	// category, keyword 숙소 추가, 삭제
	void deleteCategoryStay(@Param("rcId") int rcId, @Param("siId") int siId);

	void insertCategoryStay(@Param("rcId") int rcId, @Param("siId") int siId);

	// keywordDetail
	RecommendCategoryVO getKeyWord(int rcId);
	
	// keywordUpdate
	void updateKeyword(RecommendCategoryVO keyword);

	// Reservation List (Admin)
	List<AdminReservationListDTO> selectReservationList(AdminReservationCriteria cri);
	int countReservationList(AdminReservationCriteria cri);

}
