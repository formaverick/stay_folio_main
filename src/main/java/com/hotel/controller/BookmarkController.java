package com.hotel.controller;

import java.security.Principal;

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

	@PostMapping("/add")
	public ResponseEntity<?> addBookmark(@RequestParam int siId, Principal principal) {

		String miId = principal.getName();
		int result = bookmarkService.addBookmark(miId, siId);

		return ResponseEntity.ok(result);
	}
	
	@DeleteMapping("/remove")
	public ResponseEntity<?> removeBookmark(@RequestParam int siId, Principal principal) {

		String miId = principal.getName();
		int result = bookmarkService.deleteBookmark(miId, siId);

		return ResponseEntity.ok(result);
	}

}
