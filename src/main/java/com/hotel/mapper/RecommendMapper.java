package com.hotel.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.domain.StayVO;

@Mapper
public interface RecommendMapper {

	String getRecommendTitle(int rc_id);

	List<StayVO> getRecommend(int rc_id);
}