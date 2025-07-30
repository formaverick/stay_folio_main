package com.hotel.domain;

import lombok.Data;

@Data
public class ReservationPageVO {
	private int riId;
    private String riName;
    private int riPerson;
    private int riMaxperson;
    private String riBed;
    private int riBedcnt;
    private int riBedroom;
    private int riBathroom;
    private String riType;
    // 숙소 정보
    private int siId;
    private String siName;
    private double siPeak;
    private double siOff;
    private double siDiscount;
    private String siCheckin;
	private String siCheckout;
	
    // 회원 정보
    private String miId;
    private String miName;
    private String miPhone;
    
    private int srRoomPrice; 	 // 숙박기본가격*성수기/비성수기*박
    private int srAddpersonFee;  // 추가인원 요금
    private int srtotalPrice;	 // 총금액	
	private int riPrice;         // 1박 요금
	private long nights;         // 숙박일수
	private int srDiscount;		 // 할인금액
	private String spUrl;		//숙소 이미지
	
	
	public String getRiType() {	//형태 변환 넣어주기
	    if (riType == null) return "";	

	    switch (riType) {
	        case "a": return "기본형";
	        case "b": return "독채형";
	        case "c": return "원룸형";
	        case "d": return "도미토리";
	        case "e": return "복층형";
	        default: return "기타";
	    }
	}

}
