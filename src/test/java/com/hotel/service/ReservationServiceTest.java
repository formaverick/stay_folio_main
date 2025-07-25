package com.hotel.service;

import java.time.LocalDate;

import javax.inject.Inject;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.transaction.annotation.Transactional;

import com.hotel.domain.ReservationCreateDTO;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml" })
@Log4j
public class ReservationServiceTest {
	
    @Inject
    private ReservationServiceImpl reservationService;

    @Test
    public void testReserve() {
		ReservationCreateDTO dto = new ReservationCreateDTO();

		dto.setSiId(1); // 숙소 번호
		dto.setRiId(1); // 객실 번호

		dto.setSrCheckin(LocalDate.of(2025, 8, 10));
		dto.setSrCheckout(LocalDate.of(2025, 8, 12));

		dto.setSrAdult(2);
		dto.setSrChild(1);
		

		dto.setSrName("test");
		dto.setSrEmail("test@gmail.com");
		dto.setSrPhone("010-1111-2222");
		dto.setSrRequest("조용한 방 부탁해요");
		dto.setSrPayment("CARD");

		try {
			int result = reservationService.reserve(dto);
			log.info("✅ 예약 성공! 결과: " + result);
		} catch (Exception e) {
			log.error("❌ 예약 실패: " + e.getMessage(), e);
		}
	}
}
