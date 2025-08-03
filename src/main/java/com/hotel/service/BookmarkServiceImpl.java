package com.hotel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.mapper.BookmarkMapper;

@Service
public class BookmarkServiceImpl implements BookmarkService {

	@Autowired
	private BookmarkMapper bookmarkMapper;
	
	@Override
	public int addBookmark(String miId, int siId) {
		return bookmarkMapper.addBookmark(miId, siId);
	}

	@Override
	public int deleteBookmark(String miId, int siId) {
		return bookmarkMapper.deleteBookmark(miId, siId);
	}

}
