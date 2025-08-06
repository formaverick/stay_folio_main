package com.hotel.controller;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hotel.domain.LocationCategoryVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.ReservationStatsDTO;
import com.hotel.domain.StayVO;
import com.hotel.service.AdminService;
import com.hotel.service.StayService;

@Controller
@RequestMapping("/admin")
public class AdminDashController {
	
	@Autowired
	private StayService stayService;

	@Autowired
	private AdminService adminService;

	// 대시보드 페이지
	@GetMapping("/dashboard")
	public String DashBoard(Model model) {
		List<StayVO> allStayList = stayService.getAllStays();
		// 객실 리스트 5개로 제한
		List<StayVO> stayList = allStayList.stream().limit(5).collect(Collectors.toList());

		// 추천 카테고리 rc_detail_top만 가져오기
		List<RecommendCategoryVO> categoryList = adminService.getAllCategoryTopDetails();

		// 키워드 리스트 (rc_name + si 개수)
		List<RecommendCategoryVO> keywordList = adminService.getRecommendKeyword();

		// 예약 현황 (총 예약 건수, 진행 중, 완료, 취소)
		ReservationStatsDTO stats = adminService.getReservationStats();
		
		// 회원, 비회원 예약 비율
		Map<String, Integer> memberRatio = adminService.getMemberVsGuestRatio();
		
		// 예약 현황 (취소 비율)
		double cancelRate = adminService.getReservationCancelRate();
		
		// 지역 별 숙소 현황
		List<LocationCategoryVO> regionStats = adminService.getStayCountByRegion();
		
		// 예약 많은 숙소 TOP5
		List<StayVO> topReservedStays = adminService.getTopReservedStays();
		
		// 북마크 TOP5
		List<StayVO> topBookmarkedStays = adminService.getTopBookmarkedStays();

		model.addAttribute("stayList", stayList);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("keywordList", keywordList);
		model.addAttribute("stats", stats);
		model.addAttribute("memberCount", memberRatio.get("MEMBERCOUNT"));
		model.addAttribute("guestCount", memberRatio.get("GUESTCOUNT"));
		model.addAttribute("cancelRate", cancelRate);
		model.addAttribute("regionStats", regionStats);
		model.addAttribute("topReservedStays", topReservedStays);
	    model.addAttribute("topBookmarkedStays", topBookmarkedStays);
		
		return "admin/adminDash";
	}
}
