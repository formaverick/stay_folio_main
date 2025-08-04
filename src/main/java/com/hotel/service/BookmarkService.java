package com.hotel.service;

import java.util.List;

public interface BookmarkService {
	int addBookmark(String miId, int siId);
	
	int deleteBookmark(String miId, int siId);
	
	List<Long> getBookmarkList(String miId);
}
