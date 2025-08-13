package com.hotel.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hotel.domain.AdminReservationCriteria;
import com.hotel.domain.AdminReservationListDTO;
import com.hotel.domain.AmenityVO;
import com.hotel.domain.Criteria;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.PageDTO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.RoomPhotoVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.AdminService;
import com.hotel.service.RoomService;
import com.hotel.service.StayService;
import com.hotel.service.ReservationService;

@Controller
@RequestMapping("/admin")
public class AdminListController {

	@Autowired
	private StayService stayService;

	@Autowired
	private RoomService roomService;

	@Autowired
	private AdminService adminService;

	@Autowired
	private ReservationService reservationService;

	// 숙소 리스트
	@GetMapping("/stay/staylist")
	public String stayList(Criteria cri,Model model) {
		List<StayVO> stayList = stayService.getListWithPaging(cri);
		if (cri.getLcId() != null && cri.getLcId() == 0) {
	        cri.setLcId(null);
	    }
		System.out.println("lcId: " + cri.getLcId());	
		int total = stayService.getTotalCount(cri); // 조건에 맞는 전체 숙소 수
		model.addAttribute("stayList", stayList);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("cri", cri);
		System.out.println("stayList size: " + stayList.size());
		return "admin/room/stayList";
	}

	// 숙소 리스트 -> 숙소 상세
	@GetMapping("/stay/detail")
	public String stayDetail(@RequestParam("siId") int siId, Model model) {
		StayVO stayInfo = stayService.getStayInfo(siId);
		StayDetailVO stayDetail = stayService.getStayDetail(siId);
		List<FacilityVO> stayFacilities = stayService.getFacilitiesByStayId(siId);
		List<RecommendCategoryVO> stayKeywords = stayService.getKeywordByStayId(siId);
		Map<String, List<PhotoVO>> stayPhotos = stayService.getStayPhotosByCategory(siId);

		System.out.println("stayFacilities : " + stayFacilities);

		model.addAttribute("stay", stayInfo);
		model.addAttribute("detail", stayDetail);
		model.addAttribute("locationList", stayService.getAllLocations());
		model.addAttribute("stayFacilities", stayFacilities);
		model.addAttribute("stayKeywords", stayKeywords);
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
		List<RoomPhotoVO> roomPhotos = roomService.getAllRoomPhotos(siId, riId);

		model.addAttribute("siId", siId);
		model.addAttribute("room", room);
		model.addAttribute("roomFacilities", roomFacilities);
		model.addAttribute("roomAmenities", roomAmenities);
		model.addAttribute("roomPhotos", roomPhotos);

		return "admin/room/roomDetail";
	}

	// 예약 리스트
	@GetMapping("/reservation/list")
	public String reservationList(AdminReservationCriteria cri, Model model) {
		List<AdminReservationListDTO> list = adminService.getReservationList(cri);
		int total = adminService.getReservationListCount(cri);
		model.addAttribute("reservationList", list);
		model.addAttribute("pageMaker", new PageDTO(cri, total));
		model.addAttribute("cri", cri);
		return "admin/reservation/reservationList";
	}

	// 예약 상세
	@GetMapping("/reservation/detail")
	public String reservationDetail(@RequestParam("srId") String srId, Model model) {
		ReservationDetailVO reservationDetailVO = reservationService.getReservation(srId);
		model.addAttribute("reservationDetailVO", reservationDetailVO);
		return "admin/reservation/adminReservationDetail";
	}

}
