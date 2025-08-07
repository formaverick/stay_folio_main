package com.hotel.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.hotel.domain.PhotoVO;

@Mapper
public interface photoMapper {
	void insert(PhotoVO photo);
}
