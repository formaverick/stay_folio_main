package com.hotel.controller;

import java.util.Collections;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hotel.domain.StayVO;
import com.hotel.service.StayService;

import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class SearchController {

    @Autowired
    private StayService stayService;

    // 키워드 검색
    @GetMapping(value = "/search/keyword", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<StayVO> searchByKeyword(@RequestParam(name = "keyword", required = false) String keyword) {
        String q = (keyword == null) ? "" : keyword.trim();
        if (q.isEmpty()) {
            return Collections.emptyList();
        }
        List<StayVO> results = stayService.searchStaysByKeyword(q);
        if (log.isDebugEnabled()) {
            log.debug("Keyword search q='" + q + "' -> results=" + (results == null ? 0 : results.size()));
        }
        return results;
    }

    // 자동완성용 
    @GetMapping(value = "/search/suggestions", produces = "application/json; charset=UTF-8")
    @ResponseBody
    public List<StayVO> getSuggestions(@RequestParam(name = "keyword", required = false) String keyword) {
        String q = (keyword == null) ? "" : keyword.trim();
        if (q.isEmpty() || q.length() < 1) {
            return Collections.emptyList();
        }
        List<StayVO> results = stayService.searchStaysSuggestions(q);
        if (log.isDebugEnabled()) {
            log.debug("Keyword suggestions q='" + q + "' -> results=" + (results == null ? 0 : results.size()));
        }
        return results;
    }
}
