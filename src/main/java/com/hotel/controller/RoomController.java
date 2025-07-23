package com.hotel.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.hotel.domain.FacilityVO;
import com.hotel.domain.RoomVO;
import com.hotel.domain.StayDetailVO;
import com.hotel.domain.StayVO;
import com.hotel.service.StayService;

@Controller
@RequestMapping("/stay")
public class RoomController {

	@Autowired
    private StayService stayService;

    @GetMapping("/{si_id}")
    public String StayDetail(@PathVariable("si_id") Integer si_id, Model model) {
        StayVO stayInfo = stayService.getStayInfo(si_id);
        StayDetailVO stayDetail = stayService.getStayDetail(si_id);
        List<RoomVO> rooms = stayService.getRoomsByStayId(si_id);
        List<FacilityVO> stayFacilities = stayService.getFacilitiesByStayId(si_id);

        model.addAttribute("stay", stayInfo);
        model.addAttribute("detail", stayDetail);
        model.addAttribute("rooms", rooms);
        model.addAttribute("stayFacilities", stayFacilities);
        return "stay/stayDetail"; // 숙소 상세페이지 이동
    }
}
