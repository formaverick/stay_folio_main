package com.hotel.domain;

import java.util.Date;

import lombok.Data;

@Data
public class AdminReservationListDTO {
    private String srId;        // 예약번호
    private String siName;      // 숙소이름
    private String srName;      // 예약자 이름
    private String srPhone;     // 예약자 전화번호
    private Date srCheckin;     // 체크인
    private Date srCheckout;    // 체크아웃
    private String srStatus;    // 예약상태
}
