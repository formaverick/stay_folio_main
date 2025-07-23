package com.hotel.domain;

import lombok.Data;

@Data
public class StayVO {
	// t_stay_info
	private Long si_id;           // 숙소 ID
    private String si_name;         // 숙소 이름
    private String si_desc;         // 짧은 설명
    private String si_loca;         // 지역 텍스트
    private Integer lc_id;          // 지역 코드
    private Integer si_book;        // 북마크 수
    private Integer si_review;      // 후기 수
    private Integer si_minperson;   // 최소 인원
    private Integer si_maxperson;   // 최대 인원
    private Integer si_minprice;    // 최소 가격
    private Integer si_extra;       // 추가 인원 요금
    private Double si_peak;         // 성수기 비율
    private Double si_off;          // 비성수기 비율
    private Double si_discount;     // 할인율
    private String si_show;         // 게시 여부
    private String si_delete;       // 삭제 여부
    private String si_date;         // 등록일자
    
    private Integer discountedPrice; // 할인 적용된 금액
    private Double discount;         // 할인율 (%)

    private String sp_url;			 // 숙소 card 용 1장 가져오기
}
