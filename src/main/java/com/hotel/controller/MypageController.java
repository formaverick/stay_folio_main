package com.hotel.controller;

import java.security.Principal;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationListVO;
import com.hotel.domain.StayVO;
import com.hotel.service.MypageService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/mypage")
public class MypageController {
    
    @Autowired
    private MypageService mypageService;

    @GetMapping("/reservations")
    public String getMyReservations(Principal principal, Model model) {
        String miId = principal.getName();
        int travelCount = mypageService.getCompletedStayCount(miId);
        List<ReservationListVO> upcomingList = mypageService.getUpcomingReservationByMember(miId);
        List<ReservationListVO> completedList = mypageService.getCompletedReservationsByMember(miId);
        
        model.addAttribute("travelCount", travelCount);
        model.addAttribute("upcomingList", upcomingList);
        model.addAttribute("completedList", completedList);
        
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
    
    @PostMapping("/reservations/{id}/cancel")
    public String cancelReservation(@PathVariable String id, RedirectAttributes rttr) {
        int result = mypageService.cancelReservation(id);
        
        if (result == 1) {
            rttr.addFlashAttribute("msg", "예약이 취소되었습니다.");
        }
        
        return "redirect:/mypage/reservationDetail/" + id;
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
