package com.hotel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.StayService;

@Controller
@RequestMapping("/stay")
public class RoomController {

	@Autowired
	private StayService stayService;

	@GetMapping("/{siId}")
	public String StayDetail(@PathVariable("siId") Integer siId, Model model) {
		StayVO stayInfo = stayService.getStayInfo(siId);
		StayDetailVO stayDetail = stayService.getStayDetail(siId);
		List<RoomVO> rooms = stayService.getRoomsByStayId(siId);
		List<FacilityVO> stayFacilities = stayService.getFacilitiesByStayId(siId);
		
		double discount = stayInfo.getSiDiscount();
	    for (RoomVO room : rooms) {
	        if (discount > 0) {
	            int discountedPrice = (int) Math.floor(room.getRiPrice() * (1 - discount / 100));
	            room.setDiscountedPrice(discountedPrice);
	        } else {
	            room.setDiscountedPrice(room.getRiPrice());
	        }
	    }

		model.addAttribute("stay", stayInfo);
		model.addAttribute("detail", stayDetail);
		model.addAttribute("rooms", rooms);
		model.addAttribute("stayFacilities", stayFacilities);
		return "stay/stay";
	}

	@GetMapping("/{siId}/{riId}")
	public String getRoomDetail(@PathVariable("siId") int siId, @PathVariable("riId") int riId, Model model) {

		StayVO stay = stayService.getStayInfo(siId);
		StayDetailVO stayDetail = stayService.getStayDetail(siId);
		RoomVO room = stayService.getRoomById(siId, riId);
		List<FacilityVO> roomFacilities = stayService.getFacilitiesByRoomId(siId, riId);
		List<AmenityVO> roomAmenities = stayService.getAmenitiesByRoomId(siId, riId);
		List<RoomVO> otherRooms = stayService.getOtherRoomsByStayId(siId, riId);

		model.addAttribute("stay", stay);
		model.addAttribute("detail", stayDetail);
		model.addAttribute("room", room);
		model.addAttribute("roomFacilities", roomFacilities);
		model.addAttribute("roomAmenities", roomAmenities);
		model.addAttribute("otherRooms", otherRooms);

		return "stay/stayDetail";
	}

}
