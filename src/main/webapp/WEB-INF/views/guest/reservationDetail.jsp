<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>STAY FOLIO</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/mypageCommon.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/mypage/reservationDetail.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<!-- Font Awesome -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="../includes/header.jsp" />

	<main class="mypage-main">
		<div class="mypage-header">
			<h2 class="mypage-title">비회원 예약 조회</h2>
			<p class="mypage-subtitle">예약번호: #${reservation.srId}</p>
		</div>


		<div class="mypage-page">
			<div class="mypage-main">
				<c:choose>
					<c:when test="${empty reservation}">
						<div style="padding: 24px">예약 정보를 찾을 수 없습니다. 처음부터 다시 시도해주세요.</div>
					</c:when>

					<c:otherwise>
						<div class="reserv-title">
							<h2>${reservation.siName}(#${reservation.srId})</h2>
						</div>

						<div class="reserv-box">
							<div class="reserv-info">
								<div class="info-title">
									<h3>${reservation.siName}</h3>
								</div>
								<div class="info-detail">
									<p>${reservation.siAddress}</p>
									<p>${reservation.siPhone}</p>
									<p>${reservation.siEmail}</p>
								</div>
							</div>
							<div class="reserv-image">
								<img src="${s3BaseUrl}${reservation.spUrl}"
									alt="${reservation.siName}" />
							</div>
						</div>

						<div class="reservation-detail-section">
							<h3>예약 안내</h3>
							<table class="reservation-info-table">
								<tr>
									<td class="reservation-info-title">01. 예약 번호</td>
									<td class="reservation-info-content">${reservation.srId}(
										<c:choose>
											<c:when test="${reservation.srStatus eq 'a'}">예약 완료</c:when>
											<c:when test="${reservation.srStatus eq 'b'}">취소 대기</c:when>
											<c:when test="${reservation.srStatus eq 'c'}">취소 완료</c:when>
											<c:when test="${reservation.srStatus eq 'd'}">예약 대기</c:when>
										</c:choose> : <c:choose>
											<c:when test="${reservation.srStatus eq 'c'}">
												<fmt:formatDate value="${reservation.srCancledate}"
													pattern="yyyy.MM.dd HH:mm" />
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${reservation.srDate}"
													pattern="yyyy.MM.dd HH:mm" />
											</c:otherwise>
										</c:choose> )
									</td>
								</tr>
								<tr>
									<td class="reservation-info-title">02. 스테이 및 객실</td>
									<td class="reservation-info-content">${reservation.siName}
										/ ${reservation.riName}</td>
								</tr>
								<tr>
									<td class="reservation-info-title">03. 숙박 인원</td>
									<td class="reservation-info-content">총
										${reservation.srAdult + reservation.srChild}명 (성인:
										${reservation.srAdult}명 / 아동: ${reservation.srChild}명)</td>
								</tr>
								<tr>
									<td class="reservation-info-title">04. 체크인</td>
									<td class="reservation-info-content"><fmt:formatDate
											value="${reservation.srCheckin}" pattern="yyyy.MM.dd HH:mm" />
									</td>
								</tr>
								<tr>
									<td class="reservation-info-title">05. 체크아웃</td>
									<td class="reservation-info-content"><fmt:formatDate
											value="${reservation.srCheckout}" pattern="yyyy.MM.dd HH:mm" />
									</td>
								</tr>
								<tr>
									<td class="reservation-info-title">06. 요청사항</td>
									<td class="reservation-info-content">${empty reservation.srRequest ? '없음' : reservation.srRequest}
									</td>
								</tr>
								<tr>
									<td class="reservation-info-title">07. 예약자 정보</td>
									<td class="reservation-info-content">예약자 이름 : ${empty reservation.srName ? '정보 없음' : reservation.srName}<br />
										예약자 이메일 : ${empty reservation.srEmail ? '정보 없음' : reservation.srEmail}<br />
										예약자 전화번호 : ${empty reservation.srPhone ? '정보 없음' : reservation.srPhone}
									</td>
								</tr>
							</table>
						</div>

						<div class="reservation-detail-section">
							<h3>결제 정보</h3>
							<table class="payment-info-table">
								<tr>
									<td class="reservation-info-title">01. 결제 금액</td>
									<td class="reservation-info-content">객실 요금: <fmt:formatNumber
											value="${reservation.srRoomprice}" type="currency" /><br />
										요금 할인: <fmt:formatNumber value="-${reservation.srDiscount}"
											type="currency" /><br /> 인원 추가: <fmt:formatNumber
											value="+${reservation.srAddpersonFee}" type="currency" />
										<div class="payment-summary">
											총 결제 금액 <span><fmt:formatNumber
													value="${reservation.srTotalprice}" type="currency" /></span>
										</div>
									</td>
								</tr>
								<tr>
									<td class="reservation-info-title">02. 결제 방법</td>
									<td class="reservation-info-content">
										${reservation.srPayment} ( <c:choose>
											<c:when test="${reservation.srPaymentstatus eq 'a'}">결제 대기</c:when>
											<c:when test="${reservation.srPaymentstatus eq 'b'}">결제 완료</c:when>
											<c:when test="${reservation.srPaymentstatus eq 'c'}">결제 취소</c:when>
										</c:choose> : <c:choose>
											<c:when test="${reservation.srPaymentstatus eq 'c'}">
												<fmt:formatDate value="${reservation.srCancledate}"
													pattern="yyyy.MM.dd HH:mm" />
											</c:when>
											<c:otherwise>
												<fmt:formatDate value="${reservation.srPaydate}"
													pattern="yyyy.MM.dd HH:mm" />
											</c:otherwise>
										</c:choose> )
									</td>
								</tr>
							</table>
						</div>

						<jsp:useBean id="now" class="java.util.Date" />
						<fmt:formatDate value="${reservation.srCheckin}"
							pattern="yyyyMMdd" var="checkin" timeZone="Asia/Seoul" />
						<fmt:formatDate value="${now}" pattern="yyyyMMdd" var="today"
							timeZone="Asia/Seoul" />

						<div class="reservation-detail-section">
							<div class="detail-bottom-buttons">
								<button type="button"
									onclick="location.href='${pageContext.request.contextPath}/'">
									예약 홈으로</button>
								<button type="button"
									onclick="location.href='${pageContext.request.contextPath}/guestLogin'">
									다른 예약 조회</button>
								<c:if
									test="${fn:toLowerCase(reservation.srStatus) eq 'a' and checkin gt today}">
									<button
										onclick="location.href='${pageContext.request.contextPath}/guest/reservations/${reservation.srId}/cancel'">
										예약 취소</button>
								</c:if>
							</div>
						</div>

					</c:otherwise>
				</c:choose>
			</div>
		</div>
	</main>

	<jsp:include page="../includes/footer.jsp" />
</body>
</html>
