package com.hotel.service;

import java.io.IOException;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RoomPhotoVO;
import com.hotel.mapper.RoomMapper;
import com.hotel.mapper.StayMapper;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class S3Uploader {
	
	private final AmazonS3 amazonS3;
	
	@Autowired
	private StayMapper stayMapper;
	private final RoomMapper roomMapper;

	@Value("${cloud.aws.s3.bucket}")
	private String bucket;

	// 숙소 이미지 업로드
	public void uploadStayPhoto(int siId, Integer riId, int spIdx, MultipartFile file) throws IOException {
		String fileName = "stay/" + siId + "/" + UUID.randomUUID();
		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentType(file.getContentType());
		metadata.setContentDisposition("inline");
		metadata.setContentLength(file.getSize());

		PutObjectRequest request = new PutObjectRequest(bucket, fileName, file.getInputStream(), metadata);
        amazonS3.putObject(request);

		PhotoVO photo = new PhotoVO();
		photo.setSiId(siId);
		photo.setRiId(riId);
		photo.setSpIdx(spIdx);
		photo.setSpUrl(fileName);

		stayMapper.insertStayPhoto(photo);
	}
	
	// 객실 이미지 업로드
	public void uploadRoomPhoto(int siId, int riId, int spIdx, MultipartFile file) throws IOException {
		String fileName = "stay/" + siId + "/" + riId + "/" + UUID.randomUUID();
		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentType(file.getContentType());
		metadata.setContentDisposition("inline");
		metadata.setContentLength(file.getSize());

		PutObjectRequest request = new PutObjectRequest(bucket, fileName, file.getInputStream(), metadata);
		amazonS3.putObject(request);

		RoomPhotoVO photo = new RoomPhotoVO();
		photo.setSiId(siId);
		photo.setRiId(riId);
		photo.setSpIdx(spIdx);
		photo.setSpUrl(fileName);

		roomMapper.insertRoomPhoto(photo);
	}
	
	// update
	public void updateStayImage(int siId, Integer riId, int spIdx, MultipartFile file) throws IOException{
		String fileName = "stay/" + siId + "/" + UUID.randomUUID();
		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentType(file.getContentType());
		metadata.setContentDisposition("inline");
		metadata.setContentLength(file.getSize());

		PutObjectRequest request = new PutObjectRequest(bucket, fileName, file.getInputStream(), metadata);
		amazonS3.putObject(request);

		PhotoVO photo = new PhotoVO();
		photo.setSiId(siId);
		photo.setRiId(riId);
		photo.setSpIdx(spIdx);
		photo.setSpUrl(fileName);
		
		System.out.println("PhotoVO riId: " + photo.getRiId());
		
		boolean exists = stayMapper.existsStayPhoto(photo);
		
		System.out.println("이미지 존재 여부: " + stayMapper.existsStayPhoto(photo));

	    if (exists) {
	        stayMapper.updateStayPhoto(photo); // UPDATE 문 필요
	    } else {
	        stayMapper.insertStayPhoto(photo); // INSERT
	    }
	}

}
