package com.hotel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BookmarkMapper {

	public int addBookmark(@Param("miId") String miId, @Param("siId") int siId);
	
	public int deleteBookmark(@Param("miId") String miId, @Param("siId") int siId);
	
	// 회원별 북마크 된 숙소번호 리스트
	public List<Integer> getBookmarkList(String miId);
}
