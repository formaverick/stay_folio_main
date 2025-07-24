package com.hotel.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ReservationCancelDTO {
	private String srId;	// 예약 번호
	private Timestamp srCancledate; // 취소 날짜
	private String srStatus; // 예약 상태 ('C' = 취소, 'Y' = 완료, 'N' = 대기 등)
}

