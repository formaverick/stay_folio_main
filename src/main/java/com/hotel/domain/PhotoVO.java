package com.hotel.domain;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class PhotoVO {
	// t_stay_photo
	private Integer si_id;      // 숙소 번호
    private Integer ri_id;      // 객실 번호 (null허용)
    private Integer sp_idx;     // 이미지 번호
    private String sp_url;      // 이미지 주소
}
