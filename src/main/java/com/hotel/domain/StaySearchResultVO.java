package com.hotel.domain;

import java.util.Date;

import lombok.Data;

@Data
public class StaySearchResultVO {
	private int siId;
	private String siName;
	private int rcId;	//추천 번호
	private String siLoca;
	private int siMinprice;
	private int siDiscount;
	private String spUrl;
	private Date siDate; // 등록일자 - 날짜 정렬용
	private String siDesc; // 짧은 설명
	private Integer lcId; // 지역 코드
	private Integer siBook; // 북마크 수
	private Integer siReview; // 후기 수
	private Integer siMinperson; // 최소 인원
	private Integer siMaxperson; // 최대 인원
	private Integer siExtra; // 추가 인원 요금
	private Double siPeak; // 성수기 비율
	private Double siOff; // 비성수기 비율

	private String siShow; // 게시 여부
	private String siDelete; // 삭제 여부

	private Integer discountedPrice; // 할인 적용된 금액
	private Double discount; // 할인율 (%)
	private int totalPerson;

	private boolean bookmarked; // 북마크 정보
}
