package com.hotel.controller;

import java.security.Principal;
import java.time.LocalDate;

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
import com.hotel.domain.ReservationDTO;
import com.hotel.domain.ReservationDetail;
import com.hotel.domain.ReservationPageVO;
import com.hotel.domain.ReservationPriceResultDTO;
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
	        @RequestParam(required = false, defaultValue = "2") int adult,
	        @RequestParam(required = false, defaultValue = "0") int child,
	        Model model,
	        Principal principal) {

	    // 체크인/체크아웃 기본값 설정
	    if (checkin == null) checkin = LocalDate.now().toString();
	    if (checkout == null) checkout = LocalDate.now().plusDays(1).toString();

	    // 로그인 사용자 ID (이메일)
	    String miId = (principal != null) ? principal.getName() : null;

	    // 예약 정보 + 요금 계산 포함
	    ReservationPageVO pageInfo = reservationService.getReservationPageInfo(
	        riId, siId, miId,
	        LocalDate.parse(checkin),
	        LocalDate.parse(checkout),
	        adult, child
	    );

	    // JSP에 넘길 값들
	    model.addAttribute("info", pageInfo);
	    model.addAttribute("checkin", checkin);
	    model.addAttribute("checkout", checkout);
	    model.addAttribute("srAdult", adult);
	    model.addAttribute("srChild", child);
	    model.addAttribute("siId", siId);
	    model.addAttribute("riId", riId);
	    model.addAttribute("miId", miId);
	    model.addAttribute("isLogin", principal != null); 
	   
	    // 로그인 시 예약자 정보 미리 채우기
	    if (pageInfo != null && pageInfo.getMiName() != null) {
	        model.addAttribute("srName", pageInfo.getMiName());
	        model.addAttribute("srEmail", pageInfo.getMiId());
	        model.addAttribute("srPhone", pageInfo.getMiPhone());
	    }
	    
	    return "reservation/reservation";
	}

	// 예약 처리
	@PostMapping("/submit")
	public String submitReservation(ReservationCreateDTO dto, RedirectAttributes rttr) {
		log.info("submit 호출됨!");
		log.info("srPayment: " + dto.getSrPayment());
		log.info("srPayment: " + dto.getSrStatus());
		log.info("srPayment: " + dto.getSrPaymentstatus());
	    
	    try {
	        reservationService.reserve(dto);
	       
	        return "redirect:/reservation/complete/" + dto.getSrId(); //  완료 페이지로 리다이렉트
	    } catch (Exception e) {
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
