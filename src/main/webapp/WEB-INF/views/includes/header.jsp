<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>

<header class="header">
    <div class="header-inner">
        <!-- 로고 -->
        <h1 class="logo">
            <a href="${pageContext.request.contextPath}/home.jsp">STAY<br />FOLIO</a>
        </h1>

        <!-- 검색창 -->
        <a href="search.jsp" class="search-box">
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
                <!-- 로그아웃 상태 -->
                <li class="login logged-out">
                    <a href="login/login.jsp"><i class="ph ph-door"></i> LOGIN</a>
                </li>
                <!-- 로그인 상태 (처음에는 숨김) -->
                <li class="login logged-in" style="display: none">
                    <a href="#"><i class="ph ph-user"></i> MY</a>
                </li>
            </ul>
        </nav>
    </div>
</header>
