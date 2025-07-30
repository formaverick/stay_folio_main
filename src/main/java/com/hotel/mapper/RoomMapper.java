package com.hotel.mapper;

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
	
	List<RoomPhotoVO> getRoomPhotos(@Param("siId") int siId, @Param("riId") int riId);
	
	List<RoomPhotoVO> getMainPhotosForAllRooms(@Param("siId") int siId);

	// admin - 객실 등록
	List<AmenityVO> getAllAmenities();

	void insertRoom(RoomVO vo);

	void insertRoomFacility(@Param("siId") int siId, @Param("riId") int riId, @Param("fiId") int fiId);

	void insertRoomAmenity(@Param("siId") int siId, @Param("riId") int riId, @Param("aiIdx") Integer aiIdx);

	void insertRoomPhoto(RoomPhotoVO photo);
}
