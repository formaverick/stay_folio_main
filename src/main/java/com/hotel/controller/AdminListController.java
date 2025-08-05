package com.hotel.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RoomPhotoVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.RoomService;
import com.hotel.service.StayService;

@Controller
@RequestMapping("/admin")
public class AdminListController {

	@Autowired
	private StayService stayService;

	@Autowired
	private RoomService roomService;

	// 숙소 리스트
	@GetMapping("/stay/staylist")
	public String stayList(Model model) {
		List<StayVO> stayList = stayService.getAllStays();
		model.addAttribute("stayList", stayList);
		System.out.println("stayList size: " + stayList.size());
		return "admin/room/stayList";
	}

	// 숙소 리스트 -> 숙소 상세
	@GetMapping("/stay/detail")
	public String stayDetail(@RequestParam("siId") int siId, Model model) {
		StayVO stayInfo = stayService.getStayInfo(siId);
		StayDetailVO stayDetail = stayService.getStayDetail(siId);
		List<FacilityVO> stayFacilities = stayService.getFacilitiesByStayId(siId);
		Map<String, List<PhotoVO>> stayPhotos = stayService.getStayPhotosByCategory(siId);

		System.out.println("stayFacilities : " + stayFacilities);

		model.addAttribute("stay", stayInfo);
		model.addAttribute("detail", stayDetail);
		model.addAttribute("locationList", stayService.getAllLocations());
		model.addAttribute("stayFacilities", stayFacilities);
		model.addAttribute("stayPhotos", stayPhotos);

		return "admin/room/stayDetail";
	}

	// 객실 리스트
	@GetMapping("/room/roomlist")
	public String roomList(@RequestParam("siId") int siId, Model model) {
		List<RoomVO> roomList = stayService.getRoomsByStayId(siId);
		model.addAttribute("roomList", roomList);
		model.addAttribute("siId", siId);

		System.out.println("roomList size: " + roomList.size());

		return "admin/room/roomList";
	}

	// 객실 리스트 -> 객실 상세
	@GetMapping("/room/detail")
	public String roomDetail(@RequestParam("siId") int siId, @RequestParam("riId") int riId, Model model) {
		RoomVO room = roomService.getRoomById(siId, riId);
		List<FacilityVO> roomFacilities = roomService.getFacilitiesByRoomId(siId, riId);
		List<AmenityVO> roomAmenities = roomService.getAmenitiesByRoomId(siId, riId);
		Map<String, List<RoomPhotoVO>> roomPhotos = roomService.getRoomPhotosByCategory(siId, riId);

		model.addAttribute("siId", siId);
		model.addAttribute("room", room);
		model.addAttribute("roomFacilities", roomFacilities);
		model.addAttribute("roomAmenities", roomAmenities);
		model.addAttribute("roomPhotos", roomPhotos);

		return "admin/room/roomDetail";
	}

}
