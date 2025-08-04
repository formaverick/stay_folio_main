package com.hotel.controller;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.ReservationPriceResultDTO;
import com.hotel.domain.RoomPhotoVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.ReservationService;
import com.hotel.service.RoomService;
import com.hotel.service.StayService;

@Controller
@RequestMapping("/stay")
public class RoomController {

	@Autowired
	private StayService stayService;

	@Autowired
	private RoomService roomService;

	// 숙소 상세페이지
	@GetMapping("/{siId}")
	public String StayDetail(@PathVariable("siId") Integer siId, Model model) {
		StayVO stayInfo = stayService.getStayInfo(siId);
		StayDetailVO stayDetail = stayService.getStayDetail(siId);
		List<RoomVO> rooms = stayService.getRoomsByStayId(siId);
		List<FacilityVO> stayFacilities = stayService.getFacilitiesByStayId(siId);
		Map<String, List<PhotoVO>> stayPhotos = stayService.getStayPhotosByCategory(siId);
		Map<Integer, RoomPhotoVO> roomMainPhotos = roomService.getMainPhotoForRooms(siId);

		double discount = stayInfo.getSiDiscount();
		for (RoomVO room : rooms) {
			if (discount > 0) {
				int discountedPrice = (int) Math.floor(room.getRiPrice() * (1 - discount / 100));
				room.setDiscountedPrice(discountedPrice);
			} else {
				room.setDiscountedPrice(room.getRiPrice());
			}
		}

		System.out.println("== stayPhotos ==");
		stayPhotos.forEach((k, v) -> {
			System.out.println(k + " => " + v.size() + "개");
		});

		model.addAttribute("stay", stayInfo);
		model.addAttribute("detail", stayDetail);
		model.addAttribute("rooms", rooms);
		model.addAttribute("stayFacilities", stayFacilities);
		model.addAttribute("stayPhotos", stayPhotos);
		model.addAttribute("roomMainPhotos", roomMainPhotos);

		return "stay/stay";
	}
	@Autowired
	private ReservationService reservationService;
	
	// 객실 상세페이지
	@GetMapping("/{siId}/{riId}")
	public String getRoomDetail(@PathVariable("siId") int siId, @PathVariable("riId") int riId, @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkin,
            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkout,
            @RequestParam(required = false) Integer adult,
            @RequestParam(required = false) Integer child, Model model) {
		
		
		if (checkin == null || checkout == null) {
	        checkin = LocalDate.now();
	        checkout = checkin.plusDays(1);
	    }
		
		RoomVO roomperson = roomService.getRoomById(siId, riId);
	    int basePerson = roomperson.getRiPerson();  // 기준 인원 (예: 1 또는 2)

	    if (adult == null) adult = basePerson < 2 ? 1 : 2;
	    if (child == null) child = 0;
	    
		ReservationPriceResultDTO priceResult = reservationService.calculateRoomPrice(
	            riId, siId, checkin, checkout, adult, child);
		model.addAttribute("roomPrice", priceResult.getSrRoomPrice()); // 기본 가격
		model.addAttribute("addpersonFee", priceResult.getSrAddpersonFee()); // 인원추가 가격
		model.addAttribute("discount", priceResult.getSrtotalPrice() - priceResult.getSrRoomPrice() - priceResult.getSrAddpersonFee()); // 할인율
		model.addAttribute("totalPrice", priceResult.getSrtotalPrice()); // 총 가격
		model.addAttribute("nights", priceResult.getNights()); // 숙박 일 수
		model.addAttribute("discountRate", priceResult.getDiscountRate()); // 할인율 *100
	
		StayVO stay = stayService.getStayInfo(siId);
		StayDetailVO stayDetail = stayService.getStayDetail(siId);
		RoomVO room = roomService.getRoomById(siId, riId);
		List<FacilityVO> roomFacilities = roomService.getFacilitiesByRoomId(siId, riId);
		List<AmenityVO> roomAmenities = roomService.getAmenitiesByRoomId(siId, riId);
		List<RoomVO> otherRooms = roomService.getOtherRoomsByStayId(siId, riId);
		Map<String, List<RoomPhotoVO>> roomPhotos = roomService.getRoomPhotosByCategory(siId, riId);
		Map<Integer, RoomPhotoVO> roomMainPhotos = roomService.getMainPhotoForRooms(siId);

		double discount = stay.getSiDiscount();
		for (RoomVO rooms : otherRooms) {
			if (discount > 0) {
				int discountedPrice = (int) Math.floor(rooms.getRiPrice() * (1 - discount / 100));
				rooms.setDiscountedPrice(discountedPrice);
			} else {
				rooms.setDiscountedPrice(rooms.getRiPrice());
			}
		}
		
		model.addAttribute("stay", stay);
		model.addAttribute("detail", stayDetail);
		model.addAttribute("room", room);
		model.addAttribute("roomFacilities", roomFacilities);
		model.addAttribute("roomAmenities", roomAmenities);
		model.addAttribute("otherRooms", otherRooms);
		model.addAttribute("roomPhotos", roomPhotos);
		model.addAttribute("roomMainPhotos", roomMainPhotos);
		model.addAttribute("checkin", checkin);
		model.addAttribute("checkout", checkout);


		return "stay/stayDetail";
	}

	// 숙소 검색 - 지역별
	@GetMapping("/search")
	public String searchPage(@RequestParam(name = "lcId", required = false, defaultValue = "0") int lcId, Model model) {

		List<StayVO> stayList = (lcId == 0) ? stayService.getRandomStayList() : stayService.getStayListByLcId(lcId);

		model.addAttribute("stayList", stayList);

		return "search/search";
	}

}
