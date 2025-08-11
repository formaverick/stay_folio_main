package com.hotel.domain;

import lombok.Data;
import lombok.EqualsAndHashCode;

@Data
@EqualsAndHashCode(callSuper = true)
public class AdminReservationCriteria extends Criteria {
    // 예약 상태 필터: a(예약완료), c(취소), d(진행중/입금대기 등 프로젝트 정의)
    private String status;
    // 통합 검색어: 숙소명/회원명/예약자명/전화번호를 한 번에 검색
    private String keyword;
    // 검색어: 숙소명, 회원명, 전화번호 개별 입력
    private String siName;  // 숙소명
    private String miName;  // 회원명(또는 예약자명과 함께 검색)
    private String phone;   // 전화번호 (예약자/회원 전화 모두 대상)
}
