package com.hotel.domain;

import lombok.Data;

@Data
public class RoomVO {
	// t_room_info
    private Integer riId;          // 객실 번호
    private Integer siId;           // 숙소 번호 (FK)
    private String riType;         // 객실 형태
    private String riName;         // 객실 이름
    private String riDesc;         // 객실 설명
    private Integer riPerson;      // 기준 인원
    private Integer riMaxperson;   // 최대 인원
    private Double riArea;         // 면적
    private String riBed;          // 침대 정보
    private Integer riBedcnt;      // 침대 개수
    private Integer riPrice;       // 기본 가격
    private String riShow;         // 게시 여부
    private String riDelete;       // 삭제 여부
    private String riDate;         // 등록일자
    private String riBedroom;
    private String riBathroom;
    
    private Integer discountedPrice;
}
