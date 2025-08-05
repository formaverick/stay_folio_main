package com.hotel.security;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.hotel.domain.AdminVO;
import com.hotel.domain.MemberVO;
import com.hotel.mapper.AdminMapper;
import com.hotel.mapper.CommonMapper;
import com.hotel.security.domain.CustomUser;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomUserDetailsService implements UserDetailsService {

	@Autowired
	private CommonMapper commonMapper;
	
	@Autowired
	private AdminMapper adminMapper;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		HttpServletRequest request = 
			    ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();
		
		String uri = request.getRequestURI();
		
		if (uri.startsWith("/admin")) {	// /admin/login에서 로그인 시도 시
			AdminVO vo = adminMapper.getAdminInfo(username);
			
			if (vo == null) {
				log.warn("User not found : " + username);
				throw new UsernameNotFoundException("User not found: " + username);
			}
			
			return new CustomUser(vo);
		}

		log.warn("Load User By UserID : " + username);

		MemberVO vo = commonMapper.read(username);

		if (vo == null) {
			log.warn("User not found : " + username);
	        throw new UsernameNotFoundException("User not found: " + username);
	    }

		return new CustomUser(vo);
	}
}
