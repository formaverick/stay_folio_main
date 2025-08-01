package com.hotel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.Criteria;
import com.hotel.domain.MemberVO;
import com.hotel.domain.PageDTO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.AdminService;
import com.hotel.service.RoomService;
import com.hotel.service.StayService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	private StayService stayService;

	@Autowired
	private RoomService roomService;
	
	@Autowired
	private AdminService adminService;
	
	@GetMapping("/stay/add")
	public String StayForm(Model model) {
		model.addAttribute("locationList", stayService.getAllLocations());
		model.addAttribute("facilityList", stayService.getAllFacilities());
		return "admin/room/stayRegister";
	}

	@PostMapping("/stay/add")
	public String addStay(StayVO stay, StayDetailVO detail,
			@RequestParam(value = "facilities", required = false) List<Integer> facilities, Model model) {

		// �닕�냼 �젙蹂� insert
		stayService.insertStayInfo(stay, detail, facilities);

		// 理쒓렐 si_id 媛��졇�삤湲�
		int siId = stayService.getLastInsertId();

		model.addAttribute("newSiId", siId);

		return "/admin/room/stayRegister"; // 媛숈� �럹�씠吏�濡� �룎�븘媛��꽌 �씠誘몄� �벑濡� 吏꾪뻾
	}

	@GetMapping("/rooms") // �닕�냼 �벑濡앹뿉�꽌 媛앹떎 �벑濡� �럹�씠吏� �씠�룞
	public String showRoomRegister(@RequestParam("siId") int siId,@RequestParam(value = "riId", required = false) Integer riId, Model model) {
		model.addAttribute("siId", siId);
		model.addAttribute("riId", riId);
		model.addAttribute("facilityList", stayService.getAllFacilities());
		model.addAttribute("amenityList", roomService.getAllAmenities());
		return "admin/room/roomRegister";
	}

	@PostMapping("/stay/rooms/add") // 媛앹떎 �벑濡앺븯湲�
	public String addRoom(RoomVO vo, @RequestParam(value = "facilities", required = false) List<Integer> facilities,
			@RequestParam(value = "amenities", required = false) List<Integer> amenities, RedirectAttributes rttr) {

		int riId = roomService.insertRoom(vo, facilities, amenities);

		System.out.println("==== success ====");

		// �벑濡� �맂 媛앹떎 �닕�냼 �븘�씠�뵒, 留덉�留� id
		rttr.addAttribute("siId", vo.getSiId());
		rttr.addAttribute("riId", riId);
		
		return "redirect:/admin/rooms";
	}

	@GetMapping(value = "/stay/rooms/list", produces = "application/json")
	@ResponseBody
	public List<RoomVO> getRoomList(@RequestParam("siId") int siId) {
		return stayService.getRoomsByStayId(siId);
	}

	@GetMapping("/member/list")
	public String memberList(Criteria cri, Model model) {
	    List<MemberVO> memberList = adminService.getMemberList(cri);
	    int total = adminService.getTotalMemberCount(cri); // 총 회원 수

	    model.addAttribute("memberList", memberList);
	    model.addAttribute("pageMaker", new PageDTO(cri, total));
	    return "admin/member/memberList";
	}

}
