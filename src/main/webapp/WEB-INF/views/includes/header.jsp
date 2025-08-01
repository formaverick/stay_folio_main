<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>
<script src="https://unpkg.com/@phosphor-icons/web"></script>

<header class="header">
    <div class="header-inner">
        <!-- 로고 -->
        <h1 class="logo">
            <a href="${pageContext.request.contextPath}/">STAY<br />FOLIO</a>
        </h1>

        <!-- 검색창 -->
        <a href="stay/search?lcId=0" class="search-box">
            <span class="search-icon"><i class="ph ph-magnifying-glass"></i></span>
            <span class="search-placeholder">어디로 떠날까요?</span>
        </a>

        <!-- GNB -->
        <nav class="gnb">
            <ul>
                <li><a href="#">FIND STAY</a></li>
                <li><a href="#">PROMOTION</a></li>
                <li><a href="#">JOURNAL</a></li>
                <li><a href="#">PRE-ORDER</a></li>
                <li class="separator">|</li>
				<sec:authorize access="!isAuthenticated()">
					<!-- 로그아웃 상태 -->
	                <li class="login logged-out">
	                    <a href="/login"><i class="ph ph-door"></i> LOGIN</a>
	                </li>
				</sec:authorize>
				<sec:authorize access="isAuthenticated()">
	                <!-- 로그인 상태 -->
	                <li class="login logged-in">
	                    <a href="/mypage/reservations"><i class="ph ph-user"></i> MY</a>
	                </li>
                </sec:authorize>
            </ul>
        </nav>
    </div>
</header>
