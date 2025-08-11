package com.hotel.controller;

import java.security.Principal;
import java.text.DateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hotel.domain.MemberVO;
import com.hotel.service.BookmarkService;
import com.hotel.service.CommonService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {
	
	@Autowired
	private CommonService commonService;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is " + locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	
	@GetMapping(value ="/recommend/{rc_id}", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getRecommendStays(@PathVariable("rc_id") int rc_id, Principal principal) {
		log.info("rcid : " + rc_id);
		
		// 로그인 ID
	    String miId = (principal != null) ? principal.getName() : null;
	    
		Map<String, Object> map = commonService.getRecommend(rc_id, miId);
		
		log.info(map);
		
		map.put("success", true);
		return map;
	}

	// 로그인 페이지
	@GetMapping("/login")
	public String loginPage(String error, Model model) {
		if (error != null) {
			model.addAttribute("error", "아이디 혹은 비밀번호가 잘못되었습니다.");
		}
		return "login/login";
	}
	
	// 로그아웃 페이지
	@GetMapping("/logout")
	public void logout() {
		// 로그아웃 페이지로 이동 또는 페이지 없이 할건가?
	}
	
	// 회원가입 페이지
	@GetMapping("/register")
	public String registerPage() {
		return "login/signup";
	}
	
	// 회원가입 처리
	@PostMapping("/register")
	public String handleRegister(MemberVO vo) {
		int result = commonService.handleRegister(vo);
		
		if (result == 1) {
			return "login/signupSuccess";
		}
		return "/";
	}
	
	// 이메일 중복 검사
	@GetMapping("/api/check/email")
	@ResponseBody
	public String checkEmail(String email) {
		return commonService.isEmailDuplicate(email) ? "true" : "false";
	}

	// 전화번호 중복 검사
	@GetMapping("/api/check/phone")
	@ResponseBody
	public String checkPhone(String phone) {
		return commonService.isPhoneDuplicate(phone) ? "true" : "false";
	}
	
	// 비회원 예약 조회 페이지
	@GetMapping("/guest/reservation")
	public void guestReservationPage() {
		// 예약자 명, 예약번호 입력 폼
	}
	
	// 비회원 예약 조회
	@PostMapping("/guest/reservation")
	public void handleGuestReservationSearch() {
		// 예약자 명, 예약번호 가지고 reservation detail jsp로 이동
	}
}
