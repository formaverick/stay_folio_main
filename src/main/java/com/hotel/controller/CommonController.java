package com.hotel.controller;

import java.net.URI;
import java.security.Principal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.MemberVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.service.CommonService;
import com.hotel.service.MypageService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {

	@Autowired
	private CommonService commonService;
	
	@Autowired
	private MypageService mypageService;

	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		log.info("Welcome home! The client locale is " + locale);

		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);

		String formattedDate = dateFormat.format(date);

		model.addAttribute("serverTime", formattedDate);

		return "home";
	}

	// main 페이지 숙소 카드(recomendSection.js)
	@GetMapping(value = "/recommend/{rc_id}", produces = "application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, Object> getRecommendStays(@PathVariable("rc_id") int rc_id, Principal principal) {
		log.info("rcid : " + rc_id);

		// 로그인 ID
		String miId = (principal != null) ? principal.getName() : null;

		Map<String, Object> map = commonService.getRecommend(rc_id, miId);

		map.put("success", true);

		return map;
	}

	// 로그인 페이지
	@GetMapping("/login")
	public String loginPage(String error, HttpServletRequest request, Model model) {
		if (error != null) {
			model.addAttribute("error", "아이디 혹은 비밀번호가 잘못되었습니다.");
		}
		
		String referer = request.getHeader("Referer");
		if (referer != null) {
	        try {
	            URI u = URI.create(referer);

	            // 같은 호스트에서 온 요청만 허용 (외부 차단)
	            boolean sameHost = (u.getHost() == null) || u.getHost().equalsIgnoreCase(request.getServerName());
	            String path = (u.getPath() != null) ? u.getPath() : "";

	            // 로그인/로그아웃/회원가입 등은 prevPage로 저장하지 않음
	            boolean blockSelf =
	                path.startsWith(request.getContextPath() + "/login") ||
	                path.startsWith(request.getContextPath() + "/logout") ||
	                path.startsWith(request.getContextPath() + "/register");

	            if (sameHost && !blockSelf) {
	                request.getSession().setAttribute("prevPage", referer);
	            }
	        } catch (IllegalArgumentException ignore) {
	            // 잘못된 Referer 형식이면 무시
	        }
	    }
		
		return "login/login";
	}

	// 게스트 로그인 페이지
	@GetMapping("/guestLogin")
	public String guestLoginForm() {
		return "login/guestLogin";
	}

	

	// 예약자 json으로 넘겨줘서 검증
	@PostMapping(value = "/guest/reservation/find.json", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> findGuestReservationJson(@RequestParam String srId, @RequestParam String srName, HttpSession session) {
		Map<String, Object> res = new HashMap<>();
		ReservationDetailVO vo = mypageService.getReservationDetail(srId);
		if (vo == null) {
			res.put("code", "NOT_FOUND");
			res.put("msg", "예약번호가 다릅니다.");
			return res;
		}
		String db = (vo.getSrName() == null ? "" : vo.getSrName()).replaceAll("\\s+", "");
		String in = (srName == null ? "" : srName).replaceAll("\\s+", "");
		if (!db.equalsIgnoreCase(in)) {
			res.put("code", "NAME_MISMATCH");
			res.put("msg", "예약자 성명이 다릅니다.");
			return res;
		}
		
		// 세션에 저장
	    session.setAttribute("guestEmail", vo.getSrEmail());
	    // 필요하면 예약번호도 저장
	    session.setAttribute("guestSrId", srId);
	    
		res.put("code", "OK");
		res.put("redirect", "reservation/guest/?srId=" + srId);
		return res;
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



	
	

}
