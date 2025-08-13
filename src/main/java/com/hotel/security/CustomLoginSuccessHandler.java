package com.hotel.security;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.RequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import lombok.extern.log4j.Log4j;

@Log4j
public class CustomLoginSuccessHandler implements AuthenticationSuccessHandler {

	private RequestCache requestCache = new HttpSessionRequestCache();
	
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		log.warn("Login Success................");
		List<String> roleNames = new ArrayList<String>();

		// authentication.getAuthorities() 메서드를 사용해서 사용자의 권한을 확인
		authentication.getAuthorities().forEach(authority -> {
			roleNames.add(authority.getAuthority());
		});
		
		log.warn("Username : " + authentication.getName());
		log.warn("ROLE NAMES : " + roleNames);
		
		SavedRequest savedRequest = requestCache.getRequest(request, response);

        if (savedRequest != null) {
            // 이전 요청 URL 가져오기
            String targetUrl = savedRequest.getRedirectUrl();
            log.warn("Redirect to : " + targetUrl);
            response.sendRedirect(targetUrl);
        } else {
            // 이전 요청이 없으면 기본 페이지로 이동 (예: 메인)
            response.sendRedirect(request.getContextPath() + "/");
        }
	}
}
