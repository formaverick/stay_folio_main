<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="s3BaseUrl" value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 - STAY FOLIO</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypageCommon.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/myReservation.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Custom JS -->
</head>
<body>
	<!-- Header Include -->
	<jsp:include page="../includes/header.jsp" />

	<main class="mypage-main">
		<div class="mypage-header">
			<sec:authentication property="principal" var="pinfo"/>
			<h2 class="mypage-title">${pinfo.member.miName}님 반가워요!</h2>
			<p class="mypage-subtitle">
			<fmt:formatDate value="${pinfo.member.miDate}" pattern="yyyy년 MM월" />부터 ${travelCount}번의 여행을 했어요.</p>
		</div>
		<div class="mypage-page">
			<div class="mypage-submenu">
				<ul>
					<li class="active"><a href="/mypage/reservations">예약 정보</a></li>
					<li><a href="/mypage/bookmarks">북마크</a></li>
					<li><a href="#">회원정보 수정</a></li>
				</ul>
			</div>

			<div class="mypage-main">
				<c:if test="${empty upcomingList and empty completedList }">
					<div class="no-reserv">
						<img src="${pageContext.request.contextPath}/resources/img/img-booking-waiting.png"> <br>
						<p>아직 예약 정보가 없습니다. 새로운 스테이를 찾아 떠나보세요.</p>
					</div>
				</c:if>
				<c:forEach var="reserv" items="${upcomingList }">
					<div class="reserv-box">
						<div class="reserv-info">
							<div>
								<span class="label ready">예약 완료</span>

								<h3>${reserv.siName }</h3>
								<p class="reserv-day">
									<fmt:formatDate value="${reserv.srCheckin}" pattern="yyyy.MM.dd"/>
									~
									<fmt:formatDate value="${reserv.srCheckout}" pattern="yyyy.MM.dd"/>
									(${reserv.nights }박)
								</p>
								<p class="reserv-option">
									${reserv.riName } / 
									<c:if test="${reserv.srAdult ne 0 }">
										성인 ${reserv.srAdult }명 
									</c:if>
									<c:if test="${reserv.srChild ne 0 }">
										아동 ${reserv.srChild }명
									</c:if>
								</p>
							</div>
							<div class="buttom">
								<button class="btn-detail" onclick="location.href='${pageContext.request.contextPath}/mypage/reservations/${reserv.srId}'">예약 상세 확인</button>
								<p class="reserv-price"><fmt:formatNumber value="${reserv.srTotalprice}" type="currency" /></p>
							</div>
						</div>
						<div class="reserv-image">
							<img src="${s3BaseUrl}${reserv.spUrl}" alt="${reserv.siName }" />
						</div>
					</div>
				</c:forEach>
				
				<c:forEach var="reserv" items="${completedList }">
					<div class="reserv-box">
						<div class="reserv-info">
							<div>
								<c:if test="${reserv.srStatus eq 'a'}">
									<span class="label ready">예약 완료</span>
								</c:if>
								<c:if test="${reserv.srStatus eq 'c'}">
									<span class="label ready">예약 취소</span>
								</c:if>
								<h3>${reserv.siName }</h3>
								<p class="reserv-day">
									<fmt:formatDate value="${reserv.srCheckin}" pattern="yyyy.MM.dd"/>
									~
									<fmt:formatDate value="${reserv.srCheckout}" pattern="yyyy.MM.dd"/>
									(${reserv.nights }박)
								</p>
								<p class="reserv-option">
									${reserv.riName } / 
									<c:if test="${reserv.srAdult ne 0 }">
										성인 ${reserv.srAdult }명 
									</c:if>
									<c:if test="${reserv.srChild ne 0 }">
										아동 ${reserv.srChild }명
									</c:if>
								</p>
							</div>
							<div class="buttom">
								<button class="btn-detail" onclick="location.href='${pageContext.request.contextPath}/mypage/reservations/${reserv.srId}'">예약 상세 확인</button>
								<p class="reserv-price"><fmt:formatNumber value="${reserv.srTotalprice}" type="currency" /></p>
							</div>
						</div>
						<div class="reserv-image">
							<img src="${s3BaseUrl}${reserv.spUrl}" alt="${reserv.siName }" />
						</div>
					</div>
				</c:forEach>
			</div>


		</div>
		<!-- 마이페이지 끝 -->
	</main>
</body>
</html>