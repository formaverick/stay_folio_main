package com.hotel.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hotel.domain.FacilityVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.StayService;

@Controller
@RequestMapping("/admin")
public class AdminListController {
	
	@Autowired
	private StayService stayService;
	
	@GetMapping("/stay/staylist")
	public String stayList(Model model) {
		List<StayVO> stayList = stayService.getAllStays();
	    model.addAttribute("stayList", stayList);
	    System.out.println("stayList size: " + stayList.size());
	    return "admin/room/stayList";
	}
	
	@GetMapping("/stay/detail")
	public String stayDetail(@RequestParam("siId") int siId, Model model) {
		StayVO stayInfo = stayService.getStayInfo(siId);
		StayDetailVO stayDetail = stayService.getStayDetail(siId);
		List<FacilityVO> stayFacilities = stayService.getFacilitiesByStayId(siId);
		Map<String, List<PhotoVO>> stayPhotos = stayService.getStayPhotosByCategory(siId);
		
		System.out.println("stayFacilities : " + stayFacilities);
		
		model.addAttribute("stay", stayInfo);
		model.addAttribute("detail", stayDetail);
		model.addAttribute("stayFacilities", stayFacilities);
		model.addAttribute("stayPhotos", stayPhotos);
		
	    return "admin/room/stayDetail";
	}
	
	
}
