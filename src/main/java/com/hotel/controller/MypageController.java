package com.hotel.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.ReservationCancelCheckVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationListVO;
import com.hotel.domain.StayVO;
import com.hotel.security.domain.CustomUser;
import com.hotel.service.MypageService;
import com.hotel.service.ReservationService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/mypage")
public class MypageController {
    
    @Autowired
    private MypageService mypageService;
    
    @Autowired
    private ReservationService reservationService;

    @GetMapping("/reservations")
    public String getMyReservations(Principal principal, Model model) {
        String miId = principal.getName();
        int travelCount = mypageService.getCompletedStayCount(miId);
        List<ReservationListVO> upcomingList = mypageService.getUpcomingReservationByMember(miId);
        List<ReservationListVO> completedList = mypageService.getCompletedReservationsByMember(miId);
        
        model.addAttribute("travelCount", travelCount);
        model.addAttribute("upcomingList", upcomingList);
        model.addAttribute("completedList", completedList);
        
        log.info(upcomingList);
        
        return "mypage/myReservation";
    }
    
    @GetMapping("/reservations/{id}")
    public String getReservationDetail(@PathVariable String id, Principal principal, Model model) {
        String miId = principal.getName();
        int travelCount = mypageService.getCompletedStayCount(miId);
        ReservationDetailVO reserv = mypageService.getReservationDetail(id);
        
        model.addAttribute("travelCount", travelCount);
        model.addAttribute("reserv", reserv);
        
        log.info(reserv);
        
        return "mypage/reservationDetail";
    }
    
    @GetMapping("/reservations/{id}/cancel")
    public String reservationCancelPage(@PathVariable String id, Principal principal, HttpSession session, Model model, RedirectAttributes rttr) {
    	// 예약 조회
        ReservationCancelCheckVO reserv = reservationService.getReservationById(id);
        if (reserv == null) {
            rttr.addFlashAttribute("error", "예약이 존재하지 않습니다.");
            log.warn("예약이 존재하지 않습니다.");
            log.warn("id : " + id + "reserv : " +  reserv);
            return "redirect:/";
        }

        // 본인 예약인지 확인 (회원 or 비회원)
        boolean isValidUser = false;

        if (principal != null) {
            // 로그인 사용자일 경우
            log.warn("user : " + principal.getName());
            String loginId = principal.getName();
            if (reserv.getMiId() != null && reserv.getMiId().equals(loginId)) {
                isValidUser = true;
            }
        } else {
            // 비회원인 경우: 세션 정보로 비교
//            String guestEmail = (String) session.getAttribute("guestEmail");
//
//            if (guestEmail != null && guestEmail.equals(reserv.getSrEmail())) {
//                isValidUser = true;
//            }
        }

        if (!isValidUser) {
            rttr.addFlashAttribute("error", "예약 정보를 확인할 수 없습니다.");
            log.warn("예약 정보를 확인할 수 없습니다.");
            log.warn("id : " + id + "reserv : " +  reserv);
            return "redirect:/";
        }

        // 3. 체크인 날짜가 지났는지 확인
        if (!reserv.getSrCheckin().toLocalDate().isAfter(LocalDate.now())) {
        	rttr.addFlashAttribute("reason", "체크인 날짜가 지나 예약을 취소할 수 없습니다.");
            log.warn("체크인 날짜가 지나 예약을 취소할 수 없습니다.");
            log.warn("id : " + id + "reserv : " +  reserv);
            return "redirect:/mypage/reservation/" + id;
        }

        // 4. 이미 취소된 예약인지
        if ("b".equals(reserv.getSrStatus()) || "c".equals(reserv.getSrStatus())) {
            model.addAttribute("reason", "이미 취소된 예약입니다.");
            model.addAttribute("reservation", reserv);
            return "redirect:/mypage/reservations/" + id;
        }

        // OK: 정상 접근
        model.addAttribute("reserv", reserv);
        return "mypage/reservationCancel";
    }
    
    @PostMapping("/reservations/{id}/cancel")
    public String cancelReservation(@PathVariable String id, RedirectAttributes rttr) {
        int result = reservationService.cancelReservation(id);
        
        if (result == 1) {
            rttr.addFlashAttribute("msg", "예약이 취소되었습니다.");
        }
        
        return "redirect:/mypage/reservations/" + id;
    }
    
    
    @GetMapping("/bookmarks")
    public String getMyBookmarks(Principal principal, Model model) {
    	log.info("MypageController - getMyBookmarks");
        String miId = principal.getName();
        log.info("miid : " + miId);
        int travelCount = mypageService.getCompletedStayCount(miId);
        List<StayVO> bookmarkList = mypageService.getBookMarkList(miId);
        log.info(bookmarkList);
        
        model.addAttribute("travelCount", travelCount);
        model.addAttribute("bookmarkList", bookmarkList);
        
        return "mypage/bookmark";
    }
}
