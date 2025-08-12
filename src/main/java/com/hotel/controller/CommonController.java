package com.hotel.controller;

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
import com.hotel.domain.ReservationCancelCheckVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.service.CommonService;
import com.hotel.service.MypageService;
import com.hotel.service.ReservationService;

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
	public String loginPage(String error, Model model) {
		if (error != null) {
			model.addAttribute("error", "아이디 혹은 비밀번호가 잘못되었습니다.");
		}
		return "login/login";
	}

	// 게스트 로그인 페이지
	@GetMapping("/guestLogin")
	public String guestLoginForm() {
		return "login/guestLogin";
	}

	@Autowired
	private MypageService mypageService;

	// 예약자 json으로 넘겨줘서 검증
	@PostMapping(value = "/guest/reservation/find.json", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public Map<String, Object> findGuestReservationJson(@RequestParam String srId, @RequestParam String srName) {
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
		res.put("code", "OK");
		res.put("redirect", "/guest/reservation?srId=" + srId);
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

	// 비회원 예약 조회 페이지
	@GetMapping("/guest/reservation")
	public String guestReservationDetail(@RequestParam String srId, Model model, RedirectAttributes rttr) {
		ReservationDetailVO vo = mypageService.getReservationDetail(srId);

		if (vo == null) {
			rttr.addFlashAttribute("error", "예약번호가 다릅니다.");
			return "redirect:/guestLogin";
		}
		model.addAttribute("reservation", vo);

		return "guest/reservationDetail";
	}

	@Autowired
	private ReservationService reservationService;

	// 비회원 예약 취소
	@GetMapping("/guest/reservations/{id}/cancel")
	public String reservationCancelPage(@PathVariable String id, @RequestParam(required = false) String email,
			HttpSession session, Model model, RedirectAttributes rttr) {
		// 1. 예약 조회
		ReservationCancelCheckVO reserv = reservationService.getReservationById(id);
		if (reserv == null) {
			rttr.addFlashAttribute("error", "예약이 존재하지 않습니다.");
			return "redirect:/";
		}
		boolean isValidUser = false;
		// 2. 비회원 본인확인만
		String guestEmail = (String) session.getAttribute("guestEmail");
		if (guestEmail != null && guestEmail.equals(reserv.getSrEmail())) {
			isValidUser = true;
		}
		if (!isValidUser) {
			rttr.addFlashAttribute("error", "예약 정보를 확인할 수 없습니다.");
			log.warn("예약 정보를 확인할 수 없습니다.");
			log.warn("id : " + id + "reserv : " + reserv);
			return "redirect:/";
		}
		
		// 3. 체크인 날짜(당일 제외)
		ZoneId KST = ZoneId.of("Asia/Seoul");
		LocalDate today = LocalDate.now(KST);
		Date raw = reserv.getSrCheckin(); 
		
		LocalDate checkinDate = (raw == null) ? null : new java.sql.Date(raw.getTime()).toLocalDate();
		if (!checkinDate.isAfter(today)) { // 오늘이면 불가
			rttr.addFlashAttribute("reason", "체크인 날짜가 지나 예약을 취소할 수 없습니다.");
			return "redirect:/guest/reservation?srId=" + id;
		}

		// 4. 이미 취소된 예약인지
		if ("b".equalsIgnoreCase(reserv.getSrStatus()) || "c".equalsIgnoreCase(reserv.getSrStatus())) {
			rttr.addFlashAttribute("reason", "이미 취소된 예약입니다.");
			return "redirect:/guest/reservationDetail?srId=" + id;
		}

		// OK: 정상 접근
		model.addAttribute("reservation", reserv);
		return "guest/reservationCancel";
	}

	// POST: 취소 실행(회원/비회원 겸용)
	@PostMapping("/reservations/{id}/cancel")
	public String cancelReservation(@PathVariable String id, RedirectAttributes rttr) {
		int result = reservationService.cancelReservation(id);

		if (result == 1) {
			rttr.addFlashAttribute("msg", "예약이 취소되었습니다.");
		}
		return "redirect:/";
	}

}
