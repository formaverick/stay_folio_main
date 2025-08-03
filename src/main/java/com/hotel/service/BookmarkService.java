package com.hotel.service;

public interface BookmarkService {
	int addBookmark(String miId, int siId);
	
	int deleteBookmark(String miId, int siId);
}
