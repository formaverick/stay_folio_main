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

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RoomPhotoVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.RoomService;
import com.hotel.service.S3Uploader;
import com.hotel.service.StayService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/admin/rooms")
@RequiredArgsConstructor
public class RoomUpdateController {
	private final StayService stayService;

	private final RoomService roomService;

	private final S3Uploader s3Uploader;

	// 객실 수정 페이지
	@GetMapping("/form")
	public String showUpdateForm(@RequestParam("siId") int siId, @RequestParam("riId") int riId, Model model) {
		RoomVO room = roomService.getRoomById(siId, riId);
		List<FacilityVO> allFacilities = stayService.getAllFacilities();
		List<AmenityVO> allAmenities = roomService.getAllAmenities();
		List<FacilityVO> roomFacilities = roomService.getFacilitiesByRoomId(siId, riId);
		List<AmenityVO> roomAmenities = roomService.getAmenitiesByRoomId(siId, riId);
		
		// 사진 목록을 map으로 변환
		Map<Integer, RoomPhotoVO> photoMap = roomService.getAllRoomPhotos(siId, riId).stream()
				.collect(Collectors.toMap(RoomPhotoVO::getSpIdx, photo -> photo, (oldVal, newVal) -> oldVal));

		// 선택된 시설들의 fiId, aiIdx만 추출
		List<Integer> selectedFacilityIds = roomFacilities.stream().map(FacilityVO::getFiId)
				.collect(Collectors.toList());
		List<Integer> selectedAmenityIds = roomAmenities.stream().map(AmenityVO::getAiIdx)
				.collect(Collectors.toList());

		model.addAttribute("siId", siId);
		model.addAttribute("room", room);
		model.addAttribute("allFacilities", allFacilities);
		model.addAttribute("allAmenities", allAmenities);
		model.addAttribute("selectedFacilityIds", selectedFacilityIds);
		model.addAttribute("selectedAmenityIds", selectedAmenityIds);
		model.addAttribute("photoMap", photoMap);
		
		return "admin/room/roomUpdateForm";
	}
	
	// 객실 수정
	@PostMapping("/update")
	public String updateStay(@ModelAttribute RoomVO room,
			@RequestParam(value = "facilityIds", required = false) List<Integer> facilityIds,
			@RequestParam(value = "amenityIds", required = false) List<Integer> amenityIds,
			@RequestParam Map<String, MultipartFile> fileMap, RedirectAttributes rttr) throws IOException {

		// 기본 객실 정보
		roomService.updateRoom(room);

		// 편의시설
		roomService.updateRoomFacilities(room.getSiId().intValue(), room.getRiId().intValue(), facilityIds);
		
		// 어메니티
		roomService.updateRoomAmenities(room.getSiId().intValue(), room.getRiId().intValue(), amenityIds);

		// 이미지 파일 처리
		for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
			String key = entry.getKey();
			if (key.startsWith("replaceImage_")) {
				int spIdx = Integer.parseInt(key.replace("replaceImage_", ""));
				MultipartFile file = entry.getValue();
				if (!file.isEmpty()) {
					s3Uploader.updateRoomImage(room.getSiId().intValue(), room.getRiId().intValue(), spIdx, file);
				}
			}
		}

		// 숙소, 객실 id 반환
		rttr.addAttribute("siId", room.getSiId());
		rttr.addAttribute("riId", room.getRiId());
		
		return "redirect:/admin/room/detail";

	}
}
