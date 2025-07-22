package com.hotel.controller;

import java.text.DateFormat;
import java.util.Date;
import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.hotel.domain.MemberVO;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is " + locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}

	@GetMapping("/login")
	public String loginPage(String error, Model model) {
		log.info("CommonController - loginpage");
		if (error != null) {
			model.addAttribute("error", "아이디 혹은 비밀번호가 잘못되었습니다.");
		}
		return "login/login";
	}
	
	@GetMapping("/logout")
	public void logout() {
		
	}
	
	@GetMapping("/register")
	public String registerPage() {
		return "login/signup";
	}
	
	@PostMapping("/register")
	public void handleRegister(MemberVO vo) {
		System.out.println("vo : " + vo);
	}
	
}
