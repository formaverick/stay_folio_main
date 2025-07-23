package com.hotel.domain;

import lombok.Data;

@Data
public class RoomVO {
	// t_room_info
    private Integer ri_id;          // 객실 번호
    private Integer si_id;           // 숙소 번호 (FK)
    private String ri_type;         // 객실 형태
    private String ri_name;         // 객실 이름
    private String ri_desc;         // 객실 설명
    private Integer ri_person;      // 기준 인원
    private Integer ri_maxperson;   // 최대 인원
    private Double ri_area;         // 면적
    private String ri_bed;          // 침대 정보
    private Integer ri_bedcnt;      // 침대 개수
    private Integer ri_price;       // 기본 가격
    private String ri_show;         // 게시 여부
    private String ri_delete;       // 삭제 여부
    private String ri_date;         // 등록일자
    private Integer ri_bedroom;
    private Integer ri_bathroom;
}
