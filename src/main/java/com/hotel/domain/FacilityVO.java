package com.hotel.domain;

import lombok.Data;

@Data
public class FacilityVO {
	// t_facility_info
	private Integer fiId;  // 편의시설 번호
	private Integer siId;   // 숙소 번호 (FK)
	private Integer riId;  // 객실 번호
	private String fiName; // 이름
	private String fiIcon; // icon
}
