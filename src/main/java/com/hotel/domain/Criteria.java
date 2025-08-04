package com.hotel.domain;

import lombok.Data;

@Data
public class Criteria {
	private int page;
	private int perPageNum;
	
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
}
