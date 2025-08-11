package com.hotel.mapper;

import java.sql.Date;
import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.hotel.domain.AmenityVO;
import com.hotel.domain.FacilityVO;
import com.hotel.domain.PhotoVO;
import com.hotel.domain.RoomPhotoVO;
import com.hotel.domain.RoomVO;

@Mapper
public interface RoomMapper {
	// 객실 상세페이지
	RoomVO getRoomById(@Param("siId") int siId, @Param("riId") int riId);

	// 객실 상세페이지 - 편의시설
	List<FacilityVO> getFacilitiesByRoomId(@Param("siId") int siId, @Param("riId") int riId);

	// 객실 상세페이지 - 어메니티
	List<AmenityVO> getAmenitiesByRoomId(@Param("siId") int siId, @Param("riId") int riId);

	// 객실 상세페이지 - 다른 객실
	List<RoomVO> getOtherRoomsByStayId(@Param("siId") int siId, @Param("riId") int riId);

	// 객실 상세페이지 - 사진 리스트
	List<RoomPhotoVO> getRoomPhotos(@Param("siId") int siId, @Param("riId") int riId);

	// 숙소 상세페이지 - 객실 목록 사진
	List<RoomPhotoVO> getMainPhotosForAllRooms(@Param("siId") int siId);

	// 모든 어메니티 목록
	List<AmenityVO> getAllAmenities();

	
	// admin - 객실 등록(기본정보, 편의시설, 어메니티, 사진)
	void insertRoom(RoomVO vo);

	void insertRoomFacility(@Param("siId") int siId, @Param("riId") int riId, @Param("fiId") int fiId);

	void insertRoomAmenity(@Param("siId") int siId, @Param("riId") int riId, @Param("aiIdx") Integer aiIdx);

	void insertRoomPhoto(RoomPhotoVO photo);	
	// admin - 객실 등록 끝
	
	
	// 객실 수정
	void updateRoom(RoomVO room);

	// 객실 편의시설 전체 삭제
	void deleteFacilitiesByRoomId(@Param("siId") int siId, @Param("riId") int riId);

	// 객실 어메니티 전체 삭제
	void deleteAmenitiesByRoomId(@Param("siId") int siId, @Param("riId") int riId);

	// 객실 사진 존재 여부 확인
	boolean existsRoomPhoto(RoomPhotoVO photo);

	// 객실 사진 수정
	void updateRoomPhoto(RoomPhotoVO photo);
	
	// 객실 예약 불가 날짜 리스트
	List<Date> getReservedDates(@Param("siId") int siId, @Param("riId") int riId);
	// 객실 체크아웃만 가능한 날짜 리스트
	List<Date> getCheckinDates(@Param("siId") int siId, @Param("riId") int riId);
}
