package com.hotel.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.hotel.domain.PhotoVO;
import com.hotel.mapper.photoMapper;

@RestController
public class UploadController {
	@Autowired
	private photoMapper photoMapper;

	@PostMapping("/uploadPhoto")
	@ResponseBody
	public ResponseEntity<String> uploadPhoto(HttpServletRequest request,
			@RequestParam("uploadFile") MultipartFile[] uploadFiles, @RequestParam("siId") int siId,
			@RequestParam(value = "riId") int riId, @RequestParam("spIdx") int spIdx) {

		String uploadFolder = request.getServletContext().getRealPath("/resources/upload");
		String uploadFolderPath = getFolder();
		File uploadPath = new File(uploadFolder, uploadFolderPath);

		if (!uploadPath.exists())
			uploadPath.mkdirs();

		for (MultipartFile file : uploadFiles) {
			String originalName = file.getOriginalFilename();
			String uuid = UUID.randomUUID().toString();
			String saveName = uuid + "_" + originalName;
			File saveFile = new File(uploadPath, saveName);

			try {
				file.transferTo(saveFile);
				String spUrl = "/resources/upload/" + uploadFolderPath + "/" + saveName;

				PhotoVO vo = new PhotoVO();
				vo.setSiId(siId);
				vo.setRiId(riId == 0 ? null : riId);
				vo.setSpIdx(spIdx);
				vo.setSpUrl(spUrl);
				photoMapper.insert(vo);

			} catch (Exception e) {
				e.printStackTrace();
				return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
			}
		}

		return new ResponseEntity<>("success", HttpStatus.OK);
	}

	private String getFolder() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy/MM/dd");
		Date date = new Date();
		return sdf.format(date); // "2025/07/22"
	}

}
