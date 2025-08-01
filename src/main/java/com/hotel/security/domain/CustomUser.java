package com.hotel.security.domain;

import java.util.Collection;
import java.util.List;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.hotel.domain.MemberVO;

import lombok.Getter;

@Getter
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;
	private MemberVO member;
	//private AdminVO admin;
	
	public CustomUser() {
	    super("anonymous", "anonymous", List.of(new SimpleGrantedAuthority("ROLE_ANONYMOUS")));
	}

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getMiId(), vo.getMiPw(), List.of(new SimpleGrantedAuthority("ROLE_USER")));
		this.member = vo;
	}
	
//	public CustomUser(AdminVO vo) {
//		super(vo.getAi_id(), vo.getAi_pw(), List.of(new SimpleGrantedAuthority("ROLE_ADMIN")));
//		this.admin = vo;
//	}

}
