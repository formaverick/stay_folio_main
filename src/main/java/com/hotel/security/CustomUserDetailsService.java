package com.hotel.security;

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

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

		log.warn("Load User By UserID : " + username);

		MemberVO vo = commonMapper.read(username);

		if (vo == null) {
			log.warn("User not found : " + username);
	        throw new UsernameNotFoundException("User not found: " + username);
	    }

		return new CustomUser(vo);
	}
}