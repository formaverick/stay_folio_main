package com.hotel.controller;

import java.security.Principal;
import java.time.LocalDate;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.ReservationCreateDTO;
import com.hotel.domain.ReservationDetail;
import com.hotel.domain.ReservationPageVO;
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
	// 예약 페이지 (숙소 id에 따라 예약 화면 제공)

	@GetMapping("/{si_id}/{ri_id}")
	public String reservationPage(
	        @PathVariable("si_id") int siId,
	        @PathVariable("ri_id") int riId,
	        @RequestParam(required = false) String checkin,
	        @RequestParam(required = false) String checkout,
	        @RequestParam(required = false, defaultValue = "1") int adult,
	        @RequestParam(required = false, defaultValue = "0") int child,
	        Model model,
	        Principal principal,
	        HttpServletRequest request,
	        RedirectAttributes rttr) {

	    if (checkin == null) checkin = LocalDate.now().toString();
	    if (checkout == null) checkout = LocalDate.now().plusDays(1).toString();

	    String miId = (principal != null) ? principal.getName() : null;

	    try {
	        ReservationPageVO pageInfo = reservationService.getReservationPageInfo(
	            riId, siId, miId,
	            LocalDate.parse(checkin),
	            LocalDate.parse(checkout),
	            adult, child
	        );

	        model.addAttribute("info", pageInfo);
	        model.addAttribute("checkin", checkin);
	        model.addAttribute("checkout", checkout);
	        model.addAttribute("srAdult", adult);
	        model.addAttribute("srChild", child);
	        model.addAttribute("siId", siId);
	        model.addAttribute("riId", riId);
	        model.addAttribute("miId", miId);
	        model.addAttribute("isLogin", principal != null);

	        if (pageInfo != null && pageInfo.getMiName() != null) {
	            model.addAttribute("srName", pageInfo.getMiName());
	            model.addAttribute("srEmail", pageInfo.getMiId());
	            model.addAttribute("srPhone", pageInfo.getMiPhone());
	        }

	        return "reservation/reservation";

	    } catch (IllegalArgumentException e) {
	        rttr.addFlashAttribute("error", e.getMessage());
	        String referer = request.getHeader("Referer");
	        return "redirect:" + (referer != null ? referer : "/");
	    }
	}


	// 예약 처리
	@PostMapping("/submit")
	public String submitReservation(ReservationCreateDTO dto, RedirectAttributes rttr) {
	    log.info("submit 호출됨");
	    dto.setSrId(null);

	    // 중복 예약 검사
	    boolean isDup = reservationService.isDuplicateReservation(
	        dto.getSiId(), dto.getRiId(), dto.getSrCheckin(), dto.getSrCheckout()
	    );

	    if (isDup) {
	        rttr.addFlashAttribute("duplicate", true);
	        return "redirect:/reservation/" + dto.getSiId() + "/" + dto.getRiId();
	    }

	    try {
	        reservationService.reserve(dto);
	        return "redirect:/reservation/complete/" + dto.getSrId();
	    } catch (Exception e) {
	        log.error("예약 실패: " + e.getMessage(), e);
	        rttr.addFlashAttribute("error", "예약 실패: " + e.getMessage());
	        return "redirect:/reservation/" + dto.getSiId() + "/" + dto.getRiId();
	    }
	}
	// 예약 상세 페이지
	@GetMapping("/complete/{sr_id}")
	public String reservationComplete(@PathVariable("sr_id") String reservationId, Model model) {
	    ReservationDetail reservation = reservationService.getReservation(reservationId);
	    model.addAttribute("reservation", reservation);
	    return "reservation/complete";
	}
}
