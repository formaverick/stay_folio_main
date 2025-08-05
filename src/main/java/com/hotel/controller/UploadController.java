package com.hotel.controller;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.hotel.service.S3Uploader;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
@RequestMapping("/admin")
public class UploadController {

	private final S3Uploader s3Uploader;

	// 숙소 이미지 업로드
	@PostMapping("/stay/imageUpload")
	@ResponseBody
	public String uploadStayImages(@RequestParam("siId") int siId,
			@RequestParam(value = "riId", required = false) Integer riId,
			@RequestParam("imageFiles") List<MultipartFile> imageFiles, @RequestParam("spIdxes") List<Integer> spIdxes)
			throws IOException {

		for (int i = 0; i < imageFiles.size(); i++) {
			MultipartFile file = imageFiles.get(i);
			int spIdx = spIdxes.get(i);

			if (!file.isEmpty()) {
				s3Uploader.uploadStayPhoto(siId, riId, spIdx, file);
			}
		}

		return "success";
	}

	// 객실 이미지 업로드
	@PostMapping("/room/imageUpload")
	@ResponseBody
	public String uploadRoomImages(@RequestParam("siId") int siId,
			@RequestParam(value = "riId", required = false) Integer riId,
			@RequestParam("imageFiles") List<MultipartFile> imageFiles, @RequestParam("spIdxes") List<Integer> spIdxes)
			throws IOException {

		for (int i = 0; i < imageFiles.size(); i++) {
			MultipartFile file = imageFiles.get(i);
			int spIdx = spIdxes.get(i);

			if (!file.isEmpty()) {
				s3Uploader.uploadRoomPhoto(siId, riId, spIdx, file);
			}
		}

		return "success";
	}

}
