package com.hotel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface BookmarkMapper {

	public int addBookmark(@Param("miId") String miId, @Param("siId") int siId);
	
	public int deleteBookmark(@Param("miId") String miId, @Param("siId") int siId);
	
	public List<Long> getBookmarkList(String miId);
}
