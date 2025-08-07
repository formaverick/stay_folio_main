package com.hotel.domain;

import lombok.Data;

@Data
public class ReservationStatsDTO {
	// admin 대시보드 - 예약 현황
    private int totalCount;
    private int inProgressCount;
    private int completedCount;
    private int canceledCount;
}
