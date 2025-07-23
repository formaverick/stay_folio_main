package com.hotel.domain;

import lombok.Data;

@Data
public class FacilityVO {
	// t_facility_info
	private Integer fi_id;  // 편의시설 번호
	private Integer si_id;   // 숙소 번호 (FK)
	private Integer ri_id;  // 객실 번호
	private String fi_name; // 이름
}
