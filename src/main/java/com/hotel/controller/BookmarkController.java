package com.hotel.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.hotel.service.BookmarkService;

import lombok.extern.log4j.Log4j;

@Log4j
@RestController
@RequestMapping("/api/bookmark")
public class BookmarkController {

	@Autowired
	private BookmarkService bookmarkService;

	@PostMapping(value = "/add", produces = "application/json")
	public ResponseEntity<Map<String, Object>> addBookmark(@RequestParam int siId, Principal principal) {
		
		if (principal == null) {
			return ResponseEntity.badRequest().build();
		}
		
		String miId = principal.getName();
		int result = bookmarkService.addBookmark(miId, siId);

		Map<String, Object> res = new HashMap<>();
	    res.put("success", result > 0);
		return ResponseEntity.ok(res);
	}
	
	@DeleteMapping(value = "/remove", produces = "application/json")
	public ResponseEntity<Map<String, Object>> removeBookmark(@RequestParam int siId, Principal principal) {

		if (principal == null) {
			return ResponseEntity.badRequest().build();
		}
		
		String miId = principal.getName();
		int result = bookmarkService.deleteBookmark(miId, siId);

		Map<String, Object> res = new HashMap<>();
	    res.put("success", result > 0);
		return ResponseEntity.ok(res);
	}

}
