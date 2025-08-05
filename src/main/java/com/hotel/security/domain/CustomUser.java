package com.hotel.security.domain;

import java.util.Collection;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.hotel.domain.MemberVO;

import lombok.Getter;

@Getter
public class CustomUser extends User {

	private static final long serialVersionUID = 1L;
	private MemberVO member;	// 회원 상세 정보
	
	public CustomUser() {
	    super("anonymous", "anonymous", List.of(new SimpleGrantedAuthority("ROLE_ANONYMOUS")));
	}

	public CustomUser(String username, String password, Collection<? extends GrantedAuthority> authorities) {
		super(username, password, authorities);
	}
	
	public CustomUser(MemberVO vo) {
		super(vo.getMiId(), vo.getMiPw(), vo.getRoles().stream().map(SimpleGrantedAuthority::new).collect(Collectors.toList()));
		this.member = vo;
	}

}
