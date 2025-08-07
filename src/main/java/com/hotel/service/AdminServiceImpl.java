package com.hotel.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.domain.Criteria;
import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.MemberVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.ReservationStatsDTO;
import com.hotel.domain.StayVO;
import com.hotel.mapper.AdminMapper;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminMapper adminMapper;

	@Override
	public int getTotalMemberCount(Criteria cri) {
		return adminMapper.getTotalMemberCount(cri);
	}

	@Override
	public List<MemberVO> getMemberList(Criteria cri) {
		return adminMapper.selectMembersWithPaging(cri);
	}

	// DashBoard
	@Override
	public List<RecommendCategoryVO> getAllCategoryTopDetails() {
		return adminMapper.getAllCategoryTopDetails();
	}

	@Override
	public List<RecommendCategoryVO> getRecommendKeyword() {
		return adminMapper.getRecommendKeyword();
	}

	@Override
	public ReservationStatsDTO getReservationStats() {
		return adminMapper.getReservationStats();
	}
	
	@Override
	public Map<String, Integer> getMemberVsGuestRatio() {
		Map<String, Integer> result = adminMapper.getMemberVsGuestRatio();
		return result;
	}

	@Override
	public double getReservationCancelRate() {
		return adminMapper.getReservationCancelRate();
	}

	@Override
	public List<LocationCategoryVO> getStayCountByRegion() {
		return adminMapper.getStayCountByRegion();
	}
	
	@Override
	public List<StayVO> getTopReservedStays() {
	    return adminMapper.getTopReservedStays();
	}

	@Override
	public List<StayVO> getTopBookmarkedStays() {
		return adminMapper.getTopBookmarkedStays();
	}

	// categoryDetail
	@Override
	public RecommendCategoryVO getCategory(int rcId) {
		return adminMapper.getCategory(rcId);
	}

	@Override
	public List<StayVO> getRecommendStayList(int rcId) {
		return adminMapper.getRecommendStayList(rcId);
	}

	@Override
	public List<StayVO> getUnrecommendedStays(int rcId) {
		return adminMapper.getUnrecommendedStays(rcId);
	}

	// categoryUpdate
	@Override
	public void updateCategory(RecommendCategoryVO category) {
		adminMapper.updateCategory(category);
	}

	@Override
	public void deleteCategoryStay(int rcId, int siId) {
		adminMapper.deleteCategoryStay(rcId, siId);
	}

	@Override
	public void insertCategoryStay(int rcId, int siId) {
		adminMapper.insertCategoryStay(rcId, siId);
	}

	@Override
	public RecommendCategoryVO getKeyWord(int rcId) {
		return adminMapper.getKeyWord(rcId);
	}

	// keywordDetail
	@Override
	public List<StayVO> getKeyWordStayList(int rcId) {
		return adminMapper.getRecommendStayList(rcId);
	}

	@Override
	public void updateKeyword(RecommendCategoryVO keyword) {
		adminMapper.updateKeyword(keyword);
		
	}
	
}