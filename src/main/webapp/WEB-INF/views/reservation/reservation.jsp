<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>예약 확인 및 결제 - STAY FOLIO</title>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/search/searchFilter.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/search/search.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/reservation/reservation.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/reservation/reservation.js"></script>
<script src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<script src="/resources/js/reservation/pay.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
</head>

<body>
	<jsp:include page="../includes/header.jsp" />
	<!-- 중복예약, 최대인원 알람 -->
	<c:if test="${not empty duplicate}">
		<script>
			alert("이미 해당 날짜에 예약된 객실입니다.");
		</script>
	</c:if>
	<c:if test="${not empty error}">
		<script>
			alert("${error}");
		</script>
	</c:if>

	<div class="main-container">
		<div class="content-wrapper">
			<!-- left -->
			<div class="left-section">
				<h2 class="reservation-title">
					<a href="javascript:history.back()" class="back-button"><i
						class="ph ph-caret-left"></i></a> 예약 확인 및 결제
				</h2>

				<form action="/reservation/submit" method="post">
					<div class="left-wrapper-box">

						<div class="reservation-box">
							<div class="section-title">예약 일정</div>
							<div class="reservation-dates">
								<div class="date-item">
									체크인<br /> <strong class="date-text"><fmt:parseDate
											value="${checkin}" var="checkinDate" pattern="yyyy-MM-dd" />
										<fmt:formatDate value="${checkinDate}" pattern="M월 d일 (E)" />
										${info.siCheckin}</strong>
								</div>
								<div class="night">${info.nights}박</div>
								<div class="date-item">
									체크아웃<br /> <strong class="date-text"><fmt:parseDate
											value="${checkout}" var="checkinDate" pattern="yyyy-MM-dd" />
										<fmt:formatDate value="${checkinDate}" pattern="M월 d일 (E)" />
										${info.siCheckout}</strong>
								</div>
							</div>
						</div>
						<c:set var="srCheckinTimestamp"
							value="${checkin} ${info.siCheckin}:00" />
						<c:set var="srCheckoutTimestamp"
							value="${checkout} ${info.siCheckout}:00" />

						<input type="hidden" name="srCheckin"
							value="${srCheckinTimestamp}" /> <input type="hidden"
							name="srCheckout" value="${srCheckoutTimestamp}" />


						<div class="reservation-box">
							<div class="section-title">예약 인원</div>
							<div class="info-item">
								성인 ${srAdult}명
								<c:if test="${srChild > 0}">
									, 아동 ${srChild}명
								</c:if>
							</div>
						</div>


						<div class="reservation-box">
							<div class="section-title">예약자 정보</div>
							<c:choose>
								<c:when test="${isLogin}">
									<input type="hidden" id="isLogin" value="${isLogin}" />
									<div class="info-item">${srName},
										<span>${srEmail}</span>
									</div>
									<div class="info-item">
										+82 <span>${srPhone}</span>
									</div>


									<input type="hidden" name="srName" value="${srName}" />
									<input type="hidden" name="srEmail" value="${srEmail}" />
									<input type="hidden" name="srPhone" value="${srPhone}" />
								</c:when>
								<c:otherwise>
									<input type="text" name="srName" id="srName"
										placeholder="예약자 이름" required />
									<input type="email" name="srEmail" id="srEmail"
										placeholder="이메일" required />
									<input type="text" maxlength="13" name="srPhone" id="srPhone"
										placeholder="전화번호" class="phone-input" required
										pattern="\d{3}-\d{3,4}-\d{4}" />
									<div class="info-item"
										style="color: red; margin-top: 10px; font-size: 12px;">
										비로그인 상태입니다. 예약자 정보를 입력해주세요.</div>
								</c:otherwise>
							</c:choose>
						</div>


						<div class="reservation-box">
							<div class="section-title">요청사항</div>
							<textarea name="srRequest" placeholder="요청사항을 입력해주세요."
								class="request-textarea"></textarea>
						</div>


						<div class="price-detail-box">
							<h3>요금 상세</h3>

							<div class="price-item">
								객실 요금
								<div>
									₩
									<fmt:formatNumber value="${info.srRoomprice}" pattern="#,###" />
								</div>
							</div>
							<c:if test="${not empty priceResult.dailyPrices}">
								<div
									style="margin-top: 10px; font-size: 14px; color: gray; margin-bottom: 10px;">
									<c:forEach var="entry" items="${priceResult.dailyPrices}">
										<div
											style="display: flex; justify-content: space-between; padding: 2px 0;">
											<span> <fmt:parseDate value="${entry.key}" var="day"
													pattern="yyyy-MM-dd" /> <fmt:formatDate value="${day}"
													pattern="yyyy-MM-dd" />
											</span> <span> ₩<fmt:formatNumber value="${entry.value}"
													pattern="#,###" />
											</span>
										</div>
									</c:forEach>
								</div>
							</c:if>

							<div class="price-item">
								인원 추가
								<div>
									+ ₩
									<fmt:formatNumber value="${info.srAddpersonFee}"
										pattern="#,###" />
								</div>
							</div>
							<div class="price-item">
								할인 금액
								<div>
									- ₩
									<fmt:formatNumber value="${info.srDiscount}" pattern="#,###" />
								</div>
							</div>
							<div class="price-item total">
								총 결제 금액
								<div>
									₩
									<fmt:formatNumber value="${info.srTotalprice}" pattern="#,###" />
								</div>
							</div>
						</div>


						<!-- <div class="payment-method-box">
							<div class="payment-option active" data-payment="무통장입금">무통장입금</div>
							<div class="payment-option active" data-payment="카드결제">카드
								결제</div>
							<div class="payment-option" data-payment="현금">현금</div>
							<div class="payment-option" data-payment="카카오페이">카카오페이</div>
							<div class="payment-option" data-payment="토스페이">토스페이</div>
						</div> -->


						<div class="terms-agreement-box">
							<div class="terms-item">
								<label class="terms-checkbox"> <input type="checkbox"
									id="agree-all" /> <span class="checkmark"></span> 사용자 약관 전체 동의
								</label>
							</div>
							<div class="terms-item sub-terms">
								<label class="terms-checkbox"> <input type="checkbox"
									class="sub-checkbox" data-required="true" /> <span
									class="checkmark"></span> (필수) 개인정보 제 3자 제공 동의
								</label> <i class="ph ph-caret-right terms-arrow"></i>
							</div>
							<div class="terms-item sub-terms">
								<label class="terms-checkbox"> <input type="checkbox"
									class="sub-checkbox" data-required="true" /> <span
									class="checkmark"></span> (필수) 미성년자(청소년) 투숙 기준 동의
								</label> <i class="ph ph-caret-right terms-arrow"></i>
							</div>
							<div class="terms-item sub-terms">
								<label class="terms-checkbox"> <input type="checkbox"
									class="sub-checkbox" data-required="true" /> <span
									class="checkmark"></span> (필수) 스테이 환불 규정
								</label> <i class="ph ph-caret-right terms-arrow"></i>
							</div>
							<div class="terms-item sub-terms">
								<label class="terms-checkbox"> <input type="checkbox"
									class="sub-checkbox" data-required="true" /> <span
									class="checkmark"></span> (필수) 스테이 이용규칙
								</label> <i class="ph ph-caret-right terms-arrow"></i>
							</div>
						</div>


						<input type="hidden" name="siId" value="${siId}" /> <input
							type="hidden" name="riId" value="${riId}" /> <input
							type="hidden" name="miId" value="${miId}" /> <input
							type="hidden" name="srAdult" value="${srAdult}" /> <input
							type="hidden" name="srChild" value="${srChild}" />
							
							  <input
							type="hidden" name="srRoomPrice" value="${info.srRoomprice}" />
						<input type="hidden" name="srDiscount" value="${info.srDiscount}" />
						<input type="hidden" name="srAddpersonFee"
							value="${info.srAddpersonFee}" /> <input type="hidden"
							name="srTotalprice" value="${info.srTotalprice}" /> <input
							type="hidden" id="srStatus" name="srStatus" value="" /> <input
							type="hidden" id="srPaymentstatus" name="srPaymentstatus"
							value="" /> <input type="hidden" id="srPayment" name="srPayment"
							value="" />
					</div>
			</div>


			<div class="right-section">
				<div class="payment-summary-box">
					<h3 class="stay-name">${info.siName}</h3>
					<img src="${s3BaseUrl}${info.spUrl}" alt="객실 사진" class="room-image" />
					<div class="room-details">
						<p class="room-name">${info.riName}</p>
						<button class="view-room-button" onclick="location.href='/stay/${siId}/${riId}?checkin=${checkin}&checkout=${checkout}&adult=${adult}&child=${child}'">객실 보기</button>
					</div>
					<div class="room-info">
						<p>
							<c:choose>
								<c:when test="${info.riType == 'a'}">기본형</c:when>
								<c:when test="${info.riType == 'b'}">독채형</c:when>
								<c:when test="${info.riType == 'c'}">원룸형</c:when>
								<c:when test="${info.riType == 'd'}">도미토리</c:when>
								<c:when test="${info.riType == 'e'}">복층형</c:when>
								<c:otherwise>기타</c:otherwise>
							</c:choose>
							/기준${info.riPerson}명(최대${info.riMaxperson}명)
						</p>
						<p>침대${info.riBedcnt} | 침구${info.riBedroom} |
							욕실${info.riBathroom}</p>
					</div>
					<button type="button" class="payment-button">
						<p>
							<span class="payment-price" data-amount="${info.srTotalprice}">
								₩<fmt:formatNumber value="${info.srTotalprice}" pattern="#,###" />
							</span> 결제하기
						</p>
					</button>
					</form>
				</div>
			</div>

		</div>
	</div>
	<!-- 푸터 인클루드 -->
	<jsp:include page="../includes/footer.jsp" />

</body>

<script>
  document.addEventListener("DOMContentLoaded", function () {
    const phoneInputs = document.querySelectorAll(".phone-input");

    phoneInputs.forEach(input => {
      input.addEventListener("input", function (e) {
        let value = e.target.value.replace(/\D/g, ''); // 숫자만 추출
        if (value.length < 4) {
          e.target.value = value;
        } else if (value.length < 8) {
          e.target.value = value.replace(/(\d{3})(\d{1,4})/, '$1-$2');
        } else {
          e.target.value = value.replace(/(\d{3})(\d{4})(\d{0,4})/, '$1-$2-$3');
        }
      });
    });
  });
</script>

</html>
