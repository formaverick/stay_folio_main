package com.hotel.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class ReservationCancelCheckVO {
	private String srId;         // 예약 번호
    private String miId;       // 회원 ID (null이면 비회원)
    private String srEmail;    // 비회원 이메일
    private String srTel;      // 비회원 전화번호
    private Date srCheckin;    // 체크인 날짜
    private String srStatus;   // 예약 상태
    private String siName;     // 숙소 이름 (출력용)
}