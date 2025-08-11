<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>CATEGORY - STAY FOLIO</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomRegister.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomDetail.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/dashboard/categoryDetail.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
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
					<li><a href="/admin/stay/staylist" class="nav-item">숙소관리</a></li>
					<li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
					<li><a href="/admin/dashboard#category-section" class="nav-item active">페이지관리</a></li>
				</ul>
			</nav>
		</aside>

		<main class="admin-main">
			<div class="admin-header">
				<div class="header-content">
					<div class="header-left">
						<h1 class="page-title">카테고리 상세</h1>
						<p class="page-subtitle">등록된 카테고리 정보를 확인하세요.</p>
					</div>
					<div class="header-right">
						<div style="display: inline-block; margin-right: 1rem;">
							<a href="${pageContext.request.contextPath}/admin/category/form?rcId=${category.rcId}" class="btn-save">수정하기</a>
						</div>

						<div style="display: inline-block;">
							<a href="/admin/dashboard#category-section" class="btn-save">뒤로가기</a>
						</div>
					</div>
				</div>
			</div>

			<div class="register-form-container">
				<div class="register-form">
					<section class="form-section">
						<div class="form-field-group">
							<label class="form-label">제목</label>
							<div class="form-text-readonly">${category.rcDetailTop}</div>
						</div>

						<div class="form-field-group">
							<label class="form-label">부제목</label>
							<div class="form-text-readonly">${category.rcDetailBottom}</div>
						</div>
					</section>

					<section class="form-section">
						<div class="recommend-results-container">
							<div class="recommend-results-header">
								<p class="recommend-results-count">
									총 <span>${fn:length(stayList)}</span>개의 숙소
								</p>
							</div>

							<div class="recommend-grid">
								<c:forEach var="stay" items="${stayList}">
									<div class="recommend-item" data-stay-id="${stay.siId}" onclick="location.href='/admin/stay/detail?siId=${stay.siId}'">
										<div class="recommend-image">
											<img src="${s3BaseUrl}${stay.spUrl}" alt="${stay.siName}" />
										</div>
										<div class="recommend-content">
											<h3 class="recommend-name">${stay.siName}</h3>
											<div class="recommend-location">
												<i class="ph ph-map-pin"></i> ${stay.siLoca}
											</div>
											<div class="recommend-price">
												<c:choose>
													<c:when test="${stay.siDiscount > 0}">
														<span class="recommend-price-original"> ₩<fmt:formatNumber
																value="${stay.siMinprice}" type="number"
																groupingUsed="true" />
														</span>
														<span class="recommend-price-current"> <span
															class="recommend-price-discount"> <fmt:formatNumber
																	value="${stay.siDiscount * 100}" type="number"
																	maxFractionDigits="0" />%
														</span> ₩<fmt:formatNumber
																value="${stay.siMinprice * (1 - stay.siDiscount)}"
																type="number" groupingUsed="true" />~
														</span>
													</c:when>
													<c:otherwise>
														<span class="recommend-price-current"> ₩<fmt:formatNumber
																value="${stay.siMinprice}" type="number"
																groupingUsed="true" />~
														</span>
													</c:otherwise>
												</c:choose>
											</div>
										</div>
									</div>
								</c:forEach>
							</div>
						</div>
					</section>
				</div>
			</div>
		</main>
	</div>
</body>
</html>