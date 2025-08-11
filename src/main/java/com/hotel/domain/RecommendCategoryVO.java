package com.hotel.domain;

import lombok.Data;

@Data
public class RecommendCategoryVO {
	private Integer rcId;
	private String rcName;
	private String rcDetailTop;
	private String rcDetailBottom;
	
	private int siNum; // 키워드 별 숙소 개수
}
