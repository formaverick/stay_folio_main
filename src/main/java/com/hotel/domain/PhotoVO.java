package com.hotel.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PhotoVO {
	// t_stay_photo
	private Integer siId;      // 숙소 번호
    private Integer riId;      // 객실 번호 (null허용)
    private Integer spIdx;     // 이미지 번호
    private String spUrl;      // 이미지 주소
}
