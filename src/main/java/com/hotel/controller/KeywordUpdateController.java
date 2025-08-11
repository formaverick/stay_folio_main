package com.hotel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.RecommendCategoryVO;
import com.hotel.domain.StayVO;
import com.hotel.service.AdminService;

@Controller
@RequestMapping("/admin")
public class KeywordUpdateController {

	@Autowired
	private AdminService adminService;

	@GetMapping("/keyword/detail")
	public String categoryDetail(@RequestParam("rcId") int rcId, Model model) {
		RecommendCategoryVO keyword = adminService.getKeyWord(rcId);
		List<StayVO> stayList = adminService.getKeyWordStayList(rcId);

		model.addAttribute("keyword", keyword);
		model.addAttribute("stayList", stayList);
		return "admin/keyword/keywordDetail";
	}
	
	@GetMapping("/keyword/form")
	public String keywordUpdateForm(@RequestParam("rcId") int rcId, Model model) {
		RecommendCategoryVO keyword = adminService.getKeyWord(rcId);
		List<StayVO> categoryStay = adminService.getRecommendStayList(rcId);
		List<StayVO> stayList = adminService.getUnrecommendedStays(rcId);

		model.addAttribute("keyword", keyword);
		model.addAttribute("categoryStay", categoryStay);
		model.addAttribute("stayList", stayList);
		return "admin/keyword/keywordUpdateForm";
	}
	
	@PostMapping("/keyword/update")
	public String updateKeyword(@ModelAttribute RecommendCategoryVO keyword, RedirectAttributes redirectAttributes) {

		adminService.updateKeyword(keyword);

		redirectAttributes.addFlashAttribute("message", "키워드 정보가 수정되었습니다.");

		return "redirect:/admin/keyword/form?rcId=" + keyword.getRcId();
	}
	
	@PostMapping("/keyword/delete")
	public String deleteCategoryStay(@RequestParam("rcId") int rcId, @RequestParam("siId") int siId,
			RedirectAttributes rttr) {
		adminService.deleteCategoryStay(rcId, siId);
		rttr.addFlashAttribute("message", "숙소가 제거되었습니다.");
		return "redirect:/admin/keyword/form?rcId=" + rcId;
	}
	
	@PostMapping("/keyword/insert")
	public String insertCategoryStay(@RequestParam("rcId") int rcId, @RequestParam("siId") int siId,
			RedirectAttributes rttr) {
		adminService.insertCategoryStay(rcId, siId);
		rttr.addFlashAttribute("message", "숙소가 추가되었습니다.");
		return "redirect:/admin/keyword/form?rcId=" + rcId;
	}

}
