package com.hotel.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.hotel.domain.StayVO;
import com.hotel.mapper.RecommendMapper;

@Service
public class CommonServiceImpl implements CommonService{
	
	@Autowired
    private RecommendMapper recommendMapper;

	@Override
	public Map<String, Object> getRecommend(int rc_id) {
		String title = recommendMapper.getRecommendTitle(rc_id);
	    List<StayVO> stays = recommendMapper.getRecommend(rc_id);

	    Map<String, Object> map = new HashMap<>();
	    map.put("title", title);
	    map.put("stays", stays);
	    return map;
	}
}
