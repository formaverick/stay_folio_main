package com.hotel.security;

import lombok.extern.log4j.Log4j;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;         // 401
import org.springframework.security.web.access.AccessDeniedHandler;   // 403
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.savedrequest.HttpSessionRequestCache;
import org.springframework.security.web.savedrequest.SavedRequest;

import javax.servlet.http.*;
import javax.servlet.ServletException;
import java.io.IOException;
import java.util.stream.Collectors;

@Log4j
public class SecurityAuditHandler implements
        AuthenticationSuccessHandler, AuthenticationFailureHandler,
        AuthenticationEntryPoint, AccessDeniedHandler {

	@Override
	public void onAuthenticationSuccess(HttpServletRequest req, HttpServletResponse res,
	                                    Authentication auth) throws IOException, ServletException {
	    String roles = auth.getAuthorities().stream()
	            .map(a -> a.getAuthority()).collect(Collectors.joining(","));
	    log.info(String.format("[LOGIN SUCCESS] user=%s ip=%s roles=[%s] ua=%s",
	            auth.getName(), clientIp(req), roles, req.getHeader("User-Agent")));

	    // 보호된 URL에서 튕겨온 경우: SavedRequest 우선
	    SavedRequest saved = new HttpSessionRequestCache().getRequest(req, res);
	    if (saved != null) {
	        res.sendRedirect(saved.getRedirectUrl());
	        return;
	    }

	    // 공개 페이지에서 온 경우: prevPage 사용(일회성)
	    HttpSession session = req.getSession(false);
	    String prev = (session != null) ? (String) session.getAttribute("prevPage") : null;
	    if (session != null) session.removeAttribute("prevPage");

	    String target = safeInternalUrl(prev, req);
	    if (target == null) {
	        target = req.getContextPath() + "/"; // 최종 fallback
	    }
	    res.sendRedirect(target);
	}

    @Override // 로그인 실패
    public void onAuthenticationFailure(HttpServletRequest req, HttpServletResponse res,
                                        AuthenticationException ex) throws IOException, ServletException {
        String username = req.getParameter("username");
        log.warn(String.format("[LOGIN FAIL] user=%s ip=%s reason=%s",
                username, clientIp(req), ex.getMessage()));
        res.sendRedirect(req.getContextPath() + "/login?error");
    }

    @Override // 401 (미인증)
    public void commence(HttpServletRequest req, HttpServletResponse res,
                         AuthenticationException ex) throws IOException {
        log.warn(String.format("[401] anonymous ip=%s %s %s : %s",
                clientIp(req), req.getMethod(), req.getRequestURI(), ex.getMessage()));
        res.sendRedirect(req.getContextPath() + "/login?needAuth");
    }

    @Override // 403 (권한 없음)
    public void handle(HttpServletRequest req, HttpServletResponse res,
                       org.springframework.security.access.AccessDeniedException ex) throws IOException {
        String user = (req.getUserPrincipal() != null) ? req.getUserPrincipal().getName() : "anonymous";
        log.warn(String.format("[403] user=%s ip=%s %s %s%s : %s",
                user, clientIp(req), req.getMethod(), req.getRequestURI(),
                req.getQueryString() != null ? "?" + req.getQueryString() : "", ex.getMessage()));
        res.sendRedirect(req.getContextPath() + "/");	// 메인페이지로 이동
    }

    private String clientIp(HttpServletRequest req) {
        String h = req.getHeader("X-Forwarded-For");
        return (h != null && !h.isEmpty()) ? h.split(",")[0].trim() : req.getRemoteAddr();
    }
    
    /** 외부 도메인 차단 + 동일 호스트의 내부 경로만 허용 */
    private String safeInternalUrl(String url, HttpServletRequest req) {
        if (url == null || url.isEmpty()) return null;
        try {
            java.net.URI uri = java.net.URI.create(url);

            // 절대 URL이면 동일 스킴/호스트/포트만 허용
            if (uri.isAbsolute()) {
                boolean sameScheme = uri.getScheme().equalsIgnoreCase(req.getScheme());
                boolean sameHost = uri.getHost() != null && uri.getHost().equalsIgnoreCase(req.getServerName());
                int port = (uri.getPort() == -1) ? ("https".equalsIgnoreCase(uri.getScheme()) ? 443 : 80) : uri.getPort();
                if (!(sameScheme && sameHost && port == req.getServerPort())) return null;

                String pathAndQuery = uri.getRawPath()
                        + (uri.getRawQuery() != null ? "?" + uri.getRawQuery() : "");
                return pathAndQuery; // 컨텍스트패스 포함되어 있으면 그대로
            }
            // 상대 경로면 OK
            return url;
        } catch (Exception e) {
            return null;
        }
    }
}
