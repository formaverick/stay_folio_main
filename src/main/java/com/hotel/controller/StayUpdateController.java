package com.hotel.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.hotel.domain.FacilityVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.S3Uploader;
import com.hotel.service.StayService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/stay")
@RequiredArgsConstructor
public class StayUpdateController {

	private final StayService stayService;

	private final S3Uploader s3Uploader;

	// 숙소 수정 페이지
	@GetMapping("/form")
	public String showUpdateForm(@RequestParam("siId") int siId, Model model) {
		StayVO stay = stayService.getStayInfo(siId);
		StayDetailVO stayDetail = stayService.getStayDetail(siId);
		List<FacilityVO> allFacilities = stayService.getAllFacilities();
		List<FacilityVO> checkedFacilities = stayService.getFacilitiesByStayId(siId); // 선택된 것

		Map<Integer, PhotoVO> photoMap = stayService.getAllStayPhotos(siId).stream()
				.collect(Collectors.toMap(PhotoVO::getSpIdx, photo -> photo, (oldVal, newVal) -> oldVal));

		// 선택된 시설들의 fiId만 추출
		List<Integer> selectedFacilityIds = checkedFacilities.stream().map(FacilityVO::getFiId)
				.collect(Collectors.toList());

		model.addAttribute("stay", stay);
		model.addAttribute("detail", stayDetail);
		model.addAttribute("locationList", stayService.getAllLocations());
		model.addAttribute("allFacilities", allFacilities);
		model.addAttribute("selectedFacilityIds", selectedFacilityIds);
		model.addAttribute("photoMap", photoMap);
		return "admin/room/stayUpdateForm";
	}

	// 숙소 수정
	@PostMapping("/update")
	public String updateStay(@ModelAttribute StayVO stay, @ModelAttribute StayDetailVO detail,
			@RequestParam(value = "facilityIds", required = false) List<Integer> facilityIds,
			@RequestParam Map<String, MultipartFile> fileMap, RedirectAttributes rttr) throws IOException {

		// 기본 숙소 정보
		stayService.updateStay(stay);

		// 상세 정보
		detail.setSiId(stay.getSiId());
		stayService.updateStayDetail(detail);

		// 편의시설
		stayService.updateStayFacilities(stay.getSiId().intValue(), facilityIds);

		// 이미지 파일 처리
		for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
			String key = entry.getKey();
			if (key.startsWith("replaceImage_")) {
				int spIdx = Integer.parseInt(key.replace("replaceImage_", ""));
				MultipartFile file = entry.getValue();
				if (!file.isEmpty()) {
					s3Uploader.updateStayImage(stay.getSiId().intValue(), null, spIdx, file);
				}
			}
		}
		
		// 숙소 id 반환
		rttr.addAttribute("siId", stay.getSiId());
		
		return "redirect:/admin/stay/detail";
	}

}