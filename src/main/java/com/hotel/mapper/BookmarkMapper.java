package com.hotel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BookmarkMapper {

	// 회원, 숙소번호로 북마크 추가
	public int addBookmark(@Param("miId") String miId, @Param("siId") int siId);
	
	// 회원, 숙소번호로 북마크 삭제
	public int deleteBookmark(@Param("miId") String miId, @Param("siId") int siId);
	
	// 회원별 북마크 된 숙소번호 리스트
	public List<Long> getBookmarkList(String miId);
}
