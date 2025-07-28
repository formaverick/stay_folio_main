package com.hotel.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/mypage")
public class MypageController {

	@GetMapping("/reservations")
	public void getMyReservations() {
		
	}
	
	@GetMapping("/reservations/{id}")
	public void getReservationDetail(@PathVariable int id) {
		
	}
	
	@PostMapping("/reservations/{id}/cancel")
	public void cancelReservation(@PathVariable int id) {
		
	}
	
	@GetMapping("/bookmarks")
	public void getMyBookmarks() {
		
	}
}
