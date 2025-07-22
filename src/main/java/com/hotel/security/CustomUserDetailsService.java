package com.hotel.security;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;

import com.hotel.domain.MemberVO;
import com.hotel.mapper.CommonMapper;
import com.hotel.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private CommonMapper commonMapper;
	
	@Autowired
    private HttpServletRequest request;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		String uri = request.getRequestURI();
		
		if (uri.startsWith("/admin")) {	// /admin/login에서 로그인 시도 시
			
		}

		log.warn("Load User By UserID : " + username);

		MemberVO vo = commonMapper.read(username);

		if (vo == null) {
			log.warn("User not found");
	        throw new UsernameNotFoundException("User not found: " + username);
	    }

		return new CustomUser(vo);
	}

}
