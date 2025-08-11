package com.hotel.domain;

import lombok.Data;

@Data
public class Criteria {
	private int page;
	private int perPageNum;
	private String keyword;
	
	private Integer lcId;	//지역 필터
	private Integer enabled; // 회원 여부
	
	public Criteria() {
		this.page = 1;
		this.perPageNum = 10;
	}

	public int getPageStart() {
		return (this.page - 1) * perPageNum;
	}

	public int getPageEnd() {
		return this.page * perPageNum;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
}
