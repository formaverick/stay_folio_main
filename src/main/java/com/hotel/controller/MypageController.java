package com.hotel.controller;

import java.security.Principal;
import java.time.LocalDate;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DuplicateKeyException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.MemberVO;
import com.hotel.domain.ReservationCancelCheckVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationListVO;
import com.hotel.domain.StayVO;
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

	// 회원별 예약 리스트
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

	// 예약 상세
	@GetMapping("/reservations/{id}")
	public String getReservationDetail(@PathVariable String id, Principal principal, Model model) {
		String miId = principal.getName();
		int travelCount = mypageService.getCompletedStayCount(miId);
		ReservationDetailVO reserv = mypageService.getReservationDetail(id);

		model.addAttribute("travelCount", travelCount);
		model.addAttribute("reserv", reserv);

		return "mypage/reservationDetail";
	}

	// 예약 취소
	@GetMapping("/reservations/{id}/cancel")
	public String reservationCancelPage(@PathVariable String id, Principal principal, HttpSession session, Model model,
			RedirectAttributes rttr) {
		// 예약 조회
		ReservationCancelCheckVO reserv = reservationService.getReservationById(id);
		if (reserv == null) {
			rttr.addFlashAttribute("error", "예약이 존재하지 않습니다.");
			log.warn("예약이 존재하지 않습니다.");
			log.warn("id : " + id + "reserv : " + reserv);
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
			log.warn("id : " + id + "reserv : " + reserv);
			return "redirect:/";
		}

		// 3. 체크인 날짜가 지났는지 확인
		if (!reserv.getSrCheckin().toLocalDate().isAfter(LocalDate.now())) {
			rttr.addFlashAttribute("reason", "체크인 날짜가 지나 예약을 취소할 수 없습니다.");
			log.warn("체크인 날짜가 지나 예약을 취소할 수 없습니다.");
			log.warn("id : " + id + "reserv : " + reserv);
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
		String miId = principal.getName();
		int travelCount = mypageService.getCompletedStayCount(miId);
		List<StayVO> bookmarkList = mypageService.getBookMarkList(miId);

		model.addAttribute("travelCount", travelCount);
		model.addAttribute("bookmarkList", bookmarkList);

		return "mypage/bookmark";
	}

	// 회원정보 수정 폼
	@GetMapping("/member/edit")
	public String memberEdit(Model model, Principal principal) {
		String miId = principal.getName();
		MemberVO member = mypageService.readMemberById(miId); // CommonMapper.read 재사용
		model.addAttribute("member", member);
		return "mypage/memberEdit"; // /WEB-INF/views/login/memberEdit.jsp
	}

	// 회원정보 수정 저장 (비밀번호 제외)
	@PostMapping("/member/update")
	public String updateMember(MemberVO form, Principal principal, RedirectAttributes rttr) {
		String miId = principal.getName();
		form.setMiId(miId);
		try {
			mypageService.updateMemberProfile(form); // 이름/성별/생일/전화/광고수신만 변경
			rttr.addFlashAttribute("alertMsg", "회원정보가 수정되었습니다.");
		} catch (IllegalArgumentException e) { // 서비스에서 중복 등 사전 검증 실패
			rttr.addFlashAttribute("alertMsg", e.getMessage());
		} catch (DuplicateKeyException e) {
			rttr.addFlashAttribute("alertMsg", "이미 사용 중인 전화번호입니다.");
		} catch (Exception e) {
			rttr.addFlashAttribute("alertMsg", "처리 중 오류가 발생했습니다.");
		}

		return "redirect:/mypage/member/edit";
	}

	@GetMapping("/api/edit/phone")
	@ResponseBody
	public String checkPhone(@RequestParam("phone") String phone, Principal principal) {
		// 1) 하이픈 등 제거
		String digits = phone.replaceAll("\\D", "");

		// 2) 로그인 사용자는 본인 레코드 제외하고 카운트
		String selfId = (principal != null) ? principal.getName() : null;

		int cnt = (selfId == null) ? mypageService.countByPhoneNormalized(digits)
				: mypageService.countByPhoneNormalizedExceptSelf(digits, selfId);

		return (cnt > 0) ? "true" : "false";
	}

	// 비밀번호 변경 폼
	@GetMapping("/member/password")
	public String passwordForm() {
		return "mypage/passwordChange";
	}

	// 비밀번호 변경 처리
	@PostMapping("/member/password")
	public String changePassword(@RequestParam("currentPw") String currentPw, @RequestParam("newPw") String newPw,
			Principal principal, RedirectAttributes rttr) {
		String miId = principal.getName();

		try {
			mypageService.changePassword(miId, currentPw.trim(), newPw.trim());
			// 성공: 알림 띄우고 프로필로
			rttr.addFlashAttribute("alertMsg", "비밀번호가 변경되었습니다.");
			return "redirect:/mypage/member/edit";
		} catch (IllegalArgumentException e) {
			// 실패(불일치/이전 비번 동일 등): 알림 띄우고 다시 비번 변경 화면으로
			rttr.addFlashAttribute("alertMsg", e.getMessage());
			return "redirect:/mypage/member/password";
		} catch (Exception e) {
			rttr.addFlashAttribute("alertMsg", "처리 중 오류가 발생했습니다.");
			return "redirect:/mypage/member/password";
		}
	}
}
