package com.hotel.mapper;


import org.apache.ibatis.annotations.Param;

import com.hotel.domain.ReservationDTO;

public interface ReservationPriceMapper {
	ReservationDTO getReservationPriceInfo(@Param("riId") int riId, @Param("siId") int siId);
}
