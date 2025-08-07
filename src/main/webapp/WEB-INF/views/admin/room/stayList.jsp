<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>숙소 관리 - STAY FOLIO</title>

<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css" />

<!-- JS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/admin/room/roomList.js"></script>
</head>
<body>
	<div class="admin-container">
		<!-- 사이드바 -->
		<aside class="admin-sidebar">
			<div class="admin-logo">
				<h1 class="logo-text">
					STAY<br />FOLIO<br /> <span class="admin-text">ADMIN</span>
				</h1>
			</div>
			<nav class="admin-nav">
				<ul>
					<li><a href="/admin/dashboard" class="nav-item">대시보드</a></li>
					<li><a href="/admin/reservation" class="nav-item">예약관리</a></li>
					<li><a href="/admin/stay/staylist" class="nav-item active">숙소관리</a></li>
					<li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
					<li><a href="/admin/dashboard#category-section" class="nav-item">페이지관리</a></li>
				</ul>
			</nav>
		</aside>

		<!-- 메인 컨텐츠 -->
		<main class="admin-main">
			<!-- 헤더 -->
			<div class="admin-header">
				<div class="header-content">
					<div class="header-left">
						<h2 class="page-title">숙소관리</h2>
						<p class="page-subtitle">숙박업소의 숙소를 관리하는 페이지입니다.</p>
					</div>
					<div class="header-right">
						<a href="/admin/stay/add" class="btn-register"> <span
							class="btn-icon">+</span> 숙소 등록
						</a>
					</div>
				</div>
			</div>

			<!-- 검색 및 필터 영역 -->
			<div class="search-filter-section">
				<div class="search-container">
					<input type="text" id="member-search" class="search-input"
						placeholder="숙소 이름으로 검색..." />
					<button class="search-btn" id="search-btn">검색</button>
				</div>

				<div class="filter-container">
					<select id="region-filter" class="region-filter">
						<!-- 지역 목록 추가 -->
					</select>
					<button class="reset-btn" id="reset-btn">초기화</button>
				</div>
			</div>

			<!-- 테이블 -->
			<div class="admin-content">
				<div class="room-table-container">
					<table class="room-table">
						<thead>
							<tr>
								<th>숙소 ID</th>
								<th>숙소명</th>
								<th>지역</th>
								<th>등록일자</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stay" items="${stayList}">
								<tr>
									<td>${stay.siId}</td>
									<td>${stay.siName}</td>
									<td>${stay.siLoca}</td>
									<td>${stay.siDate.substring(0, 10)}</td>
									<td><a href="/admin/stay/detail?siId=${stay.siId}"
										class="btn-edit">상세보기</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</main>
	</div>
</body>
</html>
