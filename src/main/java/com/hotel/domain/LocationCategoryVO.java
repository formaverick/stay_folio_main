package com.hotel.domain;

import lombok.Data;

@Data
public class LocationCategoryVO {
	private int lcId;
	private String lcName;
	
	private int count; // 지역별 숙소 개수
}
