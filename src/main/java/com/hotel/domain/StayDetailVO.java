package com.hotel.domain;

import lombok.Data;

@Data
public class StayDetailVO {
	// t_stay_info_detail
	private Long si_id;           // 숙소 ID
	private String si_notice; // 공지사항
	private String si_desc1; // 이미지1 설명
	private String si_desc2; // 이미지2 설명
	private String si_feat1; // 특징1 설명
	private String si_feat2; // 특징2 설명
	private String si_address; // 상세주소
	private String si_addrdesc; // 주소 설명
	private String si_phone; // 전화번호
	private String si_email; // 이메일
	private String si_instagram; // 인스타그램
	private String si_bizname; // 상호명
	private String si_biznum; // 사업자번호
	private String si_ceo; // 대표자명
	private String si_pet; // 반려동물 동반 가능여부
	private String si_parking; // 주차 가능 여부
	private String si_food; // 취식 가능 여부
	private String si_checkin; // 체크인
	private String si_checkout; // 체크아웃
	private String si_feat_title1; // 특징1 제목
    private String si_feat_title2; // 특징2 제목
}
