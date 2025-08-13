package com.hotel.controller;

import static org.junit.Assert.assertEquals;
import static org.junit.Assert.assertNotNull;
import static org.springframework.test.web.servlet.result.MockMvcResultHandlers.log;

import java.time.LocalDate;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Commit;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.context.WebApplicationContext;

import com.hotel.domain.ReservationCreateDTO;
import com.hotel.mapper.ReservationMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({
	"file:src/main/webapp/WEB-INF/spring/root-context.xml",
	"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"
})
@WebAppConfiguration
@Log4j
@Transactional
@Commit

public class ReservationControllerTest {
	@Autowired
	private WebApplicationContext ctx;

	private MockMvc mockMvc;
	@Autowired
    private ReservationMapper mapper;
	@Before
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}	
	
	
	@Test
	public void testInsertReservation() {
	    ReservationCreateDTO dto = new ReservationCreateDTO();
	    dto.setRiId(1);
	    dto.setSiId(1);
	    dto.setMiId(null);
	    dto.setSrEmail("test@example.com");
	    dto.setSrRequest("꺠끗하게 청소 부탁드립니다");
	    dto.setSrName("테스트유저");
	    dto.setSrPhone("010-1234-5678");
	    dto.setSrCheckin(LocalDate.of(2025, 8, 10));
	    dto.setSrCheckout(LocalDate.of(2025, 8, 12));
	    dto.setSrAdult(2);
	    dto.setSrChild(0);
	    dto.setSrPayment("국민카드");
	    dto.setSrStatus("a");

	    // 요금 계산 로직을 여기에 추가하거나, 미리 계산한 값을 하드코딩해도 됨
	    dto.setSrRoomprice(250000);
	    dto.setSrDiscount(10000);
	    dto.setSrAddpersonFee(0);
	    dto.setSrTotalprice(240000);
	    dto.setNights(2);

	    int result = mapper.insertReservation(dto);
	    System.out.println("✅ 예약 삽입 결과: " + result);
	    System.out.println("✅ 생성된 예약 번호: " + dto.getSrId());
	}
	
	@Test
	public void testInsertReservationWithNullRequestAndAutoEmail() {
	    ReservationCreateDTO dto = new ReservationCreateDTO();

	    dto.setSiId(1);
	    dto.setRiId(1);

	    // 로그인한 사용자라고 가정
	    dto.setMiId("testuser@example.com"); // 자동으로 srEmail에 들어가야 함

	    dto.setSrName("자동메일");
	    dto.setSrPhone("010-5678-1234");

	    // srRequest intentionally null
	    dto.setSrRequest(null);

	    dto.setSrAdult(2);
	    dto.setSrChild(1);
	 

	    dto.setSrCheckin(LocalDate.of(2025, 8, 15));
	    dto.setSrCheckout(LocalDate.of(2025, 8, 17));

	    dto.setSrRoomprice(200000);
	    dto.setSrDiscount(5000);
	    dto.setSrAddpersonFee(10000);
	    dto.setSrTotalprice(205000);

	    dto.setSrPayment("카카오페이");
	    dto.setSrStatus("a");

	    int result = mapper.insertReservation(dto);

	    log.info("예약 insert 결과: " + result);
	    log.info("생성된 예약번호(srId): " + dto.getSrId());
	    log.info("자동 채워진 srEmail: " + dto.getSrEmail());

	    assertEquals(1, result);
	    assertNotNull(dto.getSrId());
	    assertEquals(dto.getMiId(), dto.getSrEmail()); 
	}

}
