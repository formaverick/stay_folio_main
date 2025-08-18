<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>숙소 관리 - STAY FOLIO ADMIN</title>

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
					<li><a href="/admin/reservation/list" class="nav-item">예약관리</a></li>
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
			<form method="get" class="search-form-container"
				action="/admin/stay/staylist" id="search-form">
				<div class="search-filter-section">
					<div class="search-container">
						<input type="text" id="member-search" name="keyword"
							class="search-input" placeholder="숙소 이름으로 검색..."
							value="${cri.keyword}" />
						<button class="search-btn" id="search-btn">검색</button>

					</div>

					<div class="filter-container">
						<select id="region-filter" class="region-filter" name="lcId">
							<!-- 지역 목록 추가 -->
							<option value="">전국</option>
							<option value="1" ${cri.lcId == 1 ? 'selected' : ''}>서울</option>
							<option value="2" ${cri.lcId == 2 ? 'selected' : ''}>경기도</option>
							<option value="3" ${cri.lcId == 3 ? 'selected' : ''}>강원도</option>
							<option value="4" ${cri.lcId == 4 ? 'selected' : ''}>충청남도</option>
							<option value="5" ${cri.lcId == 5 ? 'selected' : ''}>충청북도</option>
							<option value="6" ${cri.lcId == 6 ? 'selected' : ''}>전라남도</option>
							<option value="7" ${cri.lcId == 7 ? 'selected' : ''}>전라북도</option>
							<option value="8" ${cri.lcId == 8 ? 'selected' : ''}>경상북도</option>
							<option value="9" ${cri.lcId == 9 ? 'selected' : ''}>경상남도</option>
							<option value="10" ${cri.lcId == 10 ? 'selected' : ''}>부산</option>
							<option value="11" ${cri.lcId == 11 ? 'selected' : ''}>제주</option>
							<option value="12" ${cri.lcId == 12 ? 'selected' : ''}>대전</option>
							<option value="13" ${cri.lcId == 13 ? 'selected' : ''}>인천</option>
							<option value="14" ${cri.lcId == 14 ? 'selected' : ''}>대구</option>
							<option value="15" ${cri.lcId == 15 ? 'selected' : ''}>광주</option>
						</select>
						<button class="reset-btn" id="reset-btn" type="button">초기화</button>
					</div>
				</div>
			</form>

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

				<!-- 페이지네이션 -->
				<div class="pagination">
					<c:if test="${pageMaker.prev}">
						<a class="page-btn"
							href="?page=${pageMaker.startPage - 1}&keyword=${cri.keyword}&lcId=${cri.lcId}">&laquo;</a>
					</c:if>
					<c:forEach var="i" begin="${pageMaker.startPage}"
						end="${pageMaker.endPage}">
						<c:choose>
							<c:when test="${i == cri.page}">
								<a class="page-btn active"
									href="?page=${i}&keyword=${cri.keyword}&lcId=${cri.lcId}">${i}</a>
							</c:when>
							<c:otherwise>
								<a class="page-btn"
									href="?page=${i}&keyword=${cri.keyword}&lcId=${cri.lcId}">${i}</a>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					<c:if test="${pageMaker.next}">
						<a class="page-btn"
							href="?page=${pageMaker.endPage + 1}&keyword=${cri.keyword}&lcId=${cri.lcId}">&raquo;</a>
					</c:if>
				</div>


			</div>
		</main>
	</div>
	<!-- 지역 select -->
	<script>
		document.getElementById("region-filter").addEventListener("change", function() {
			document.getElementById("search-form").submit();
		});
	</script>
	<!-- 초기화 버튼 -->
	<script>
		document.getElementById("reset-btn").addEventListener("click", function() {
			// 검색어 input 초기화
			document.getElementById("member-search").value = "";
			// 지역 select 초기화
			document.getElementById("region-filter").value = "";
			// 페이지 번호 초기화 (원한다면 hidden input 초기화도 여기서)
			// form 제출
			document.getElementById("search-form").submit();
		});
	</script>
</body>
</html>
