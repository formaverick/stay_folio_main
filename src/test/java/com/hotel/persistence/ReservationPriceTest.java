package com.hotel.persistence;

import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.hotel.domain.ReservationDTO;
import com.hotel.mapper.ReservationPriceMapper;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j
public class ReservationPriceTest {

    @Autowired
    private ReservationPriceMapper mapper;

    @Test
    public void testGetReservationPriceInfo() {
        int riId = 1;
        int siId = 3; // 실제 숙소 ID로 변경

        try {
            log.info("====== 테스트 시작 ======");

            ReservationDTO dto = mapper.getReservationPriceInfo(riId, siId);
            if (dto == null) {
                log.warn("조회된 객실 정보가 없습니다.");
                return;
            }

            log.info("객실 이름: " + dto.getRiName());
            log.info("기본 요금: " + dto.getRiPrice());
            log.info("성수기 계수: " + dto.getSiPeak());
            log.info("비성수기 계수: " + dto.getSiOff());
            log.info("할인율: " + dto.getSiDiscount());

            LocalDate checkin = LocalDate.of(2025, 6, 25);
            LocalDate checkout = LocalDate.of(2025, 6, 27);
            long nights = checkout.toEpochDay() - checkin.toEpochDay();

            int total = 0;
            Map<LocalDate, Integer> dailyPrices = new LinkedHashMap<>();

            for (LocalDate d = checkin; d.isBefore(checkout); d = d.plusDays(1)) {
                double rate = getSeasonRate(d, dto);
                double dayPrice = dto.getRiPrice() * rate;
                double discounted = dayPrice * (1 - dto.getSiDiscount());
                int finalPrice = (int) discounted;

                dailyPrices.put(d, finalPrice);
                total += finalPrice;
            }

            for (Map.Entry<LocalDate, Integer> entry : dailyPrices.entrySet()) {
                log.info(entry.getKey() + " 요금: " + entry.getValue());
            }

            log.info("숙박일 수: " + nights);
            log.info("총 금액: " + total);
            log.info("====== 테스트 종료 ======");

        } catch (Exception e) {
            log.error("❌ 테스트 중 예외 발생: " + e.getMessage(), e);
        }
    }

    private double getSeasonRate(LocalDate date, ReservationDTO dto) {
        switch (date.getMonth()) {
            case JULY: case AUGUST:
            case DECEMBER: case JANUARY: case FEBRUARY:
                return dto.getSiPeak(); // 성수기
            case MARCH: case APRIL: case MAY:
            case SEPTEMBER: case OCTOBER: case NOVEMBER:
                return dto.getSiOff(); // 비성수기
            case JUNE:
                return 1.0; // 기본요금
            default:
                throw new IllegalArgumentException("요율 정의되지 않은 월입니다: " + date.getMonth());
        }
    }
}
