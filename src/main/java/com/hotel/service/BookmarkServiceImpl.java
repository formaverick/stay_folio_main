package com.hotel.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hotel.mapper.BookmarkMapper;
import com.hotel.mapper.StayMapper;

@Service
public class BookmarkServiceImpl implements BookmarkService {

	@Autowired
	private BookmarkMapper bookmarkMapper;
	
	@Autowired
	private StayMapper stayMapper;
	
	@Override
    @Transactional(rollbackFor = Exception.class)
    public int addBookmark(String miId, int siId) {
        int inserted = bookmarkMapper.addBookmark(miId, siId);
        if (inserted == 1) { // 새로 추가된 경우에만 카운트 +1
            stayMapper.incBookmarkCount(siId);
        }
        return inserted;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public int deleteBookmark(String miId, int siId) {
        int deleted = bookmarkMapper.deleteBookmark(miId, siId);
        if (deleted == 1) { // 실제 삭제된 경우에만 -1
            stayMapper.decBookmarkCount(siId);
        }
        return deleted;
    }

	@Override
	public List<Integer> getBookmarkList(String miId) {
		return bookmarkMapper.getBookmarkList(miId);
	}

}
