package com.hotel.domain;

import lombok.Data;

@Data
public class StayVO {
	// t_stay_info
	private Long siId;           // 숙소 ID
    private String siName;         // 숙소 이름
    private String siDesc;         // 짧은 설명
    private String siLoca;         // 지역 텍스트
    private Integer lcId;          // 지역 코드
    private Integer siBook;        // 북마크 수
    private Integer siReview;      // 후기 수
    private Integer siMinperson;   // 최소 인원
    private Integer siMaxperson;   // 최대 인원
    private Integer siMinprice;    // 최소 가격
    private Integer siExtra;       // 추가 인원 요금
    private Double siPeak;         // 성수기 비율
    private Double siOff;          // 비성수기 비율
    private Double siDiscount;     // 할인율
    private String siShow;         // 게시 여부
    private String siDelete;       // 삭제 여부
    private String siDate;         // 등록일자
    
    private Integer discountedPrice; // 할인 적용된 금액
    private Double discount;         // 할인율 (%)

    private String spUrl;			 // 숙소 card 용 1장 가져오기
    
    private boolean bookmarked;	// 북마크 정보
}
