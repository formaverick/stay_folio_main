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
public class CategoryUpdateController {
	@Autowired
	private AdminService adminService;

	@GetMapping("/category/detail")
	public String categoryDetail(@RequestParam("rcId") int rcId, Model model) {
		RecommendCategoryVO category = adminService.getAllCategory(rcId);
		List<StayVO> stayList = adminService.getRecommendStayList(rcId);

		model.addAttribute("category", category);
		model.addAttribute("stayList", stayList);
		return "admin/category/categoryDetail";
	}

	@GetMapping("/category/form")
	public String categoryUpdateForm(@RequestParam("rcId") int rcId, Model model) {
		RecommendCategoryVO category = adminService.getAllCategory(rcId);
		List<StayVO> categoryStay = adminService.getRecommendStayList(rcId);
		List<StayVO> stayList = adminService.getUnrecommendedStays(rcId);

		model.addAttribute("category", category);
		model.addAttribute("categoryStay", categoryStay);
		model.addAttribute("stayList", stayList);
		return "admin/category/categoryUpdateForm";
	}

	@PostMapping("/category/update")
	public String updateCategory(@ModelAttribute RecommendCategoryVO category, RedirectAttributes redirectAttributes) {

		adminService.updateCategory(category);

		redirectAttributes.addFlashAttribute("message", "카테고리 정보가 수정되었습니다.");

		return "redirect:/admin/category/form?rcId=" + category.getRcId();
	}

	@PostMapping("/category/delete")
	public String deleteCategoryStay(@RequestParam("rcId") int rcId, @RequestParam("siId") int siId,
			RedirectAttributes rttr) {
		adminService.deleteCategoryStay(rcId, siId);
		rttr.addFlashAttribute("message", "숙소가 카테고리에서 제거되었습니다.");
		return "redirect:/admin/category/form?rcId=" + rcId;
	}
	
	@PostMapping("/category/insert")
	public String insertCategoryStay(@RequestParam("rcId") int rcId, @RequestParam("siId") int siId,
			RedirectAttributes rttr) {
		adminService.insertCategoryStay(rcId, siId);
		rttr.addFlashAttribute("message", "숙소가 카테고리에서 추가되었습니다.");
		return "redirect:/admin/category/form?rcId=" + rcId;
	}
}
