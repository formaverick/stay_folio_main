package com.hotel.domain;

import lombok.Data;

@Data
public class StayDetailVO {
	// t_stay_info_detail
	private int siId;           // 숙소 ID
	private String siNotice; // 공지사항
	private String siDesc1; // 이미지1 설명
	private String siDesc2; // 이미지2 설명
	private String siFeat1; // 특징1 설명
	private String siFeat2; // 특징2 설명
	private String siAddress; // 상세주소
	private String siAddrdesc; // 주소 설명
	private String siPhone; // 전화번호
	private String siEmail; // 이메일
	private String siInstagram; // 인스타그램
	private String siBizname; // 상호명
	private String siBiznum; // 사업자번호
	private String siCeo; // 대표자명
	private boolean siPet; // 반려동물 동반 가능여부
	private boolean siParking; // 주차 가능 여부
	private boolean siFood; // 취식 가능 여부
	private String siCheckin; // 체크인
	private String siCheckout; // 체크아웃
	private String siFeatTitle1; // 특징1 제목
    private String siFeatTitle2; // 특징2 제목
}
