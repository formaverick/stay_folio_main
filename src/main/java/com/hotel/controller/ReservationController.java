package com.hotel.controller;

import java.security.Principal;
import java.sql.Timestamp;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.ReservationCancelCheckVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationPriceResultDTO;
import com.hotel.service.MypageService;
import com.hotel.service.ReservationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/reservation")
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@RequiredArgsConstructor
public class ReservationController {

	private final ReservationService reservationService;
	
	@Autowired
	private MypageService mypageService;

	// 예약 페이지 (숙소 id에 따라 예약 화면 제공)
	@GetMapping("/{si_id}/{ri_id}")
	public String reservationPage(@PathVariable("si_id") int siId, @PathVariable("ri_id") int riId,
			@RequestParam(required = false) String checkin, @RequestParam(required = false) String checkout,
			@RequestParam(required = false, defaultValue = "1") int adult, // 받아오는 값이없으면 기준인원 1명때문에 1로넣어놓음
			@RequestParam(required = false, defaultValue = "0") int child, Model model, Principal principal,
			HttpServletRequest request, RedirectAttributes rttr) {
		if (checkin == null)
			checkin = LocalDate.now().toString();
		if (checkout == null)
			checkout = LocalDate.now().plusDays(1).toString(); // 체크인 체크아웃 시간 못받아오면 오늘 내일 날짜
		LocalDate checkinDate = LocalDate.parse(checkin);
		LocalDate checkoutDate = LocalDate.parse(checkout);

		String miId = (principal != null) ? principal.getName() : null; // 로그인이 되어있으면 이름 가져오기 아니면 null처리
		try {
			ReservationDetailVO pageInfo = reservationService.getReservationPageInfo(riId, siId, miId,
					LocalDate.parse(checkin), LocalDate.parse(checkout), adult, child);

			ReservationPriceResultDTO priceResult = reservationService.calculateRoomPrice(riId, siId, checkinDate, // 계산
																													// 가져옴
					checkoutDate, adult, child);

			String checkinDateTime = checkin + " " + pageInfo.getSiCheckin() + ":00";
			String checkoutDateTime = checkout + " " + pageInfo.getSiCheckout() + ":00";

			Timestamp srCheckinTimestamp = Timestamp.valueOf(checkinDateTime);
			Timestamp srCheckoutTimestamp = Timestamp.valueOf(checkoutDateTime);

			model.addAttribute("srCheckinTimestamp", srCheckinTimestamp);
			model.addAttribute("srCheckoutTimestamp", srCheckoutTimestamp);

			model.addAttribute("info", pageInfo);
			model.addAttribute("priceResult", priceResult);
			model.addAttribute("checkin", checkin);
			model.addAttribute("checkout", checkout);
			model.addAttribute("srAdult", adult);
			model.addAttribute("srChild", child);
			model.addAttribute("siId", siId);
			model.addAttribute("riId", riId);
			model.addAttribute("miId", miId);
			model.addAttribute("isLogin", principal != null);

			if (pageInfo != null && pageInfo.getMiName() != null) { // 로그인시 가져와서 넣어줌
				model.addAttribute("srName", pageInfo.getMiName());
				model.addAttribute("srEmail", pageInfo.getMiId());
				model.addAttribute("srPhone", pageInfo.getMiPhone());
			}
			return "reservation/reservation";

		} catch (IllegalArgumentException e) {
			String msg = e.getMessage();
			if (msg != null && msg.contains("인원초과"))
				msg = "최대 인원을 초과했습니다.";
			if (msg == null || msg.startsWith("redirect:/"))
				msg = "요청을 처리할 수 없습니다.";
			rttr.addFlashAttribute("error", msg);
			String referer = request.getHeader("Referer");
			return "redirect:" + (referer != null ? referer : "/");
		}

	}

	// 결제전 체크인 체크아웃 체크
	@GetMapping(value = "/check-available", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<Map<String, Object>> checkAvailable(@RequestParam int siId, @RequestParam int riId,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkin,
			@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate checkout) {

		boolean dup = reservationService.isDuplicateReservation(siId, riId, Timestamp.valueOf(checkin.atStartOfDay()),
				Timestamp.valueOf(checkout.atStartOfDay()));
		return ResponseEntity.ok(Map.of("available", !dup));
	}

	// 예약 처리
	@PostMapping("/submit")
	public String submitReservation(ReservationDetailVO dto, RedirectAttributes rttr) {
		log.info("submit 호출됨");
		dto.setSrId(null);

		// 중복 예약 검사
		boolean isDup = reservationService.isDuplicateReservation(dto.getSiId(), dto.getRiId(), dto.getSrCheckin(),
				dto.getSrCheckout());

		if (isDup) {
			rttr.addFlashAttribute("duplicate", true);
			return "redirect:/reservation/" + dto.getSiId() + "/" + dto.getRiId();
		}
		try {
			int r = reservationService.reserve(dto);
			if (r < 0) {
				String msg = (r == -1) ? "이미 예약된 기간입니다."
						: (dto.getMessage() != null ? dto.getMessage() : "결제에 실패했습니다. 다시 시도해주세요.");
				rttr.addFlashAttribute("error", msg);
				return "redirect:/reservation/" + dto.getSiId() + "/" + dto.getRiId();
			}
			return "redirect:/reservation/complete/" + dto.getSrId();
		} catch (Exception e) {
			rttr.addFlashAttribute("error", "예약 실패: " + e.getMessage());
			return "redirect:/reservation/" + dto.getSiId() + "/" + dto.getRiId();
		}
	}

	// 예약 상세 페이지
	@GetMapping("/complete/{sr_id}")
	public String reservationComplete(@PathVariable("sr_id") String reservationId, Model model) {

		ReservationDetailVO reservation = reservationService.getReservation(reservationId); // 해당 예약 ID의 상세 정보
		model.addAttribute("reservation", reservation);
		LocalDate checkin = reservation.getSrCheckin().toInstant() // 날짜 정보 사용 (박 수체크)
				.atZone(ZoneId.systemDefault()).toLocalDate();
		LocalDate checkout = reservation.getSrCheckout().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

		ReservationDetailVO pageInfo = reservationService.getReservationPageInfo( // 가격 계산을 위한 예약 페이지 정보 가져오기
				reservation.getRiId(), reservation.getSiId(), reservation.getMiId(), checkin, checkout,
				reservation.getSrAdult(), reservation.getSrChild());
		model.addAttribute("info", pageInfo);
		return "reservation/complete";
	}
	
	// 비회원 예약 조회 페이지
	@GetMapping("/guest")
	public String guestReservationDetail(@RequestParam String srId, Model model, RedirectAttributes rttr, HttpSession session) {
		ReservationDetailVO vo = mypageService.getReservationDetail(srId);
		
		log.info("🔍 guestEmail in session = " + session.getAttribute("guestEmail"));

		if (vo == null) {
			rttr.addFlashAttribute("error", "예약번호가 다릅니다.");
			return "redirect:/guestLogin";
		}
		model.addAttribute("reservation", vo);

		return "guest/reservationDetail";
	}

	// 비회원 예약 취소
	@GetMapping("/guest/{id}/cancel")
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
	@PostMapping("/{id}/cancel")
	public String cancelReservation(@PathVariable String id, RedirectAttributes rttr) {
		int result = reservationService.cancelReservation(id);

		if (result == 1) {
			rttr.addFlashAttribute("msg", "예약이 취소되었습니다.");
		}
		return "redirect:/";
	}
}
