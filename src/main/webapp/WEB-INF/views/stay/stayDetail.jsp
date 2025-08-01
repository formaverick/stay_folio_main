<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>숙소 상세 - STAY FOLIO</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/stay/stayCarousel.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/stay/stayDetail.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/stay/stayDetailFillter.css" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css" />
<!-- Carousel JS -->
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayCarousel.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayNavigation.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stay.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayDetailBooking.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayDetail.js"></script>
</head>
<body>
	<!-- 헤더 인클루드 -->
	<jsp:include page="../includes/header.jsp" />
	<div class="booking-modal-overlay" id="bookingModalOverlay"></div>

	<!-- 숙소 캐러셀 시작 -->
	<section class="carousel-container">
		<!-- 뒤로가기 버튼 -->
		<a href="javascript:history.back()" class="back-button"> <i
			class="ph ph-arrow-left"></i>
		</a>
		<div class="carousel">
			<div class="carousel-track">
				<c:forEach var="photo" items="${roomPhotos.main}" varStatus="status">
					<div class="carousel-slide ${status.first ? 'active' : ''}">
						<img class="preview" src="${s3BaseUrl}${photo.spUrl}" alt="대표 이미지" />
					</div>
				</c:forEach>
				<c:forEach var="photo" items="${roomPhotos.additional}">
					<div class="carousel-slide">
						<img class="preview" src="${s3BaseUrl}${photo.spUrl}" alt="추가 이미지" />
					</div>
				</c:forEach>
				<c:forEach var="photo" items="${roomPhotos.feature}">
					<div class="carousel-slide">
						<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
							alt="주요 특징 이미지" />
					</div>
				</c:forEach>
				<c:forEach var="photo" items="${roomPhotos.feat1}">
					<div class="carousel-slide">
						<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
							alt="특징1 이미지" />
					</div>
				</c:forEach>
				<c:forEach var="photo" items="${roomPhotos.feat2}">
					<div class="carousel-slide">
						<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
							alt="특징2 이미지" />
					</div>
				</c:forEach>
			</div>

			<!-- 네비게이션 버튼 -->
			<button class="carousel-btn carousel-btn-prev" type="button">
				<span>‹</span>
			</button>
			<button class="carousel-btn carousel-btn-next" type="button">
				<span>›</span>
			</button>

			<!-- 인디케이터 -->
			<div class="carousel-indicators">
				<c:forEach var="photo" items="${roomPhotos.main}" varStatus="status">
					<button class="indicator ${status.first ? 'active' : ''}"
						data-slide="${status.index}"></button>
				</c:forEach>
				<c:forEach var="photo" items="${roomPhotos.additional}"
					varStatus="status">
					<button class="indicator"
						data-slide="${status.index + roomPhotos.main.size()}"></button>
				</c:forEach>
				<c:forEach var="photo" items="${roomPhotos.feature}"
					varStatus="status">
					<button class="indicator"
						data-slide="${status.index + roomPhotos.main.size() + roomPhotos.additional.size()}"></button>
				</c:forEach>
				<c:forEach var="photo" items="${roomPhotos.feat1}"
					varStatus="status">
					<button class="indicator"
						data-slide="${status.index + roomPhotos.main.size() + roomPhotos.additional.size() + roomPhotos.feature.size()}"></button>
				</c:forEach>
				<c:forEach var="photo" items="${roomPhotos.feat2}"
					varStatus="status">
					<button class="indicator"
						data-slide="${status.index + roomPhotos.main.size() + roomPhotos.additional.size() + roomPhotos.feature.size() + roomPhotos.feat1.size()}"></button>
				</c:forEach>
			</div>

		</div>
	</section>
	<!-- 숙소 캐러셀 끝 -->

	<!-- 객실 상세 영역 시작 -->
	<div class="room-detail-container">
		<div class="room-detail-content">
			<!-- 좌측 영역 (70%) -->
			<div class="room-detail-left">
				<!-- 1. 숙소 제목 -->
				<section class="room-header-section">
					<h1 class="room-title">${room.riName}</h1>
					<p class="room-description">${room.riDesc}</p>
				</section>

				<!-- 2. 객실 규정 -->
				<section class="room-rules-section">
					<div class="amenity-title">객실 규정</div>
					<div class="rules-list">
						<div class="rule-item">
							<span class="rule-text">• 체크인 ${detail.siCheckin} / 체크아웃
								${detail.siCheckout}</span>
						</div>
						<div class="rule-item">
							<span class="rule-text">• 기준 ${room.riPerson} 명 (최대
								${room.riMaxperson} 명)</span>
						</div>
					</div>
				</section>

				<!-- 3. 공간정보 -->
				<section class="space-info-section">
					<div class="amenity-title">공간정보</div>
					<div class="space-info-list">
						<div class="space-info-item">
							<span class="space-label">• 객실면적 59m²</span>
						</div>
						<div class="space-info-item">
							<span class="space-label">• 퀸 침대</span>
						</div>
					</div>
				</section>

				<!-- 4. 편의시설 -->
				<section class="facilities-section">
					<div class="amenity-title">편의시설</div>
					<c:if test="${not empty roomFacilities}">
						<div class="stay-amenities">
							<c:forEach var="fac" items="${roomFacilities}">
								<div class="amenity">
									<i class="ph ${fac.fiIcon}"></i><span>${fac.fiName}</span>
								</div>
							</c:forEach>
						</div>
					</c:if>
				</section>

				<!-- 5. 어메니티 -->
				<section class="amenities-section">
					<div class="amenity-title">어메니티</div>
					<c:if test="${not empty roomAmenities}">
						<div class="amenities-list">
							<c:forEach var="ame" items="${roomAmenities}">
								<div class="amenity-item">• ${ame.raName}</div>
							</c:forEach>
						</div>
					</c:if>
				</section>

				<!-- 6. 객실 선택 -->
				<section id="room-select" class="stay-section">
					<div class="amenity-title1">이 스테이의 다른 객실</div>
					<c:if test="${not empty otherRooms}">
						<div class="room-list">
							<c:forEach var="room" items="${otherRooms}">
								<div class="room-card">
									<div class="room-image">
										<img src="${s3BaseUrl}${roomMainPhotos[room.riId].spUrl}"
											alt="${room.riName}" />
									</div>
									<div class="room-info">
										<h3>${room.riName}</h3>
										<p class="room-capacity">
											형태:
											<c:choose>
												<c:when test="${room.riType == 'a'}">기본형</c:when>
												<c:when test="${room.riType == 'b'}">독채형</c:when>
												<c:when test="${room.riType == 'c'}">원룸형</c:when>
												<c:when test="${room.riType == 'd'}">도미토리</c:when>
												<c:when test="${room.riType == 'e'}">복층형</c:when>
												<c:otherwise>기타</c:otherwise>
											</c:choose>
											/ 기준 ${room.riPerson} (최대 ${room.riMaxperson}명)
										</p>
										<p class="room-amenity">침실 ${room.riBedroom} | 침대
											${room.riBedcnt} | 욕실 ${room.riBathroom}</p>
										<p>
										<div class="room-price-container">
											<div class="price-info">
												<c:choose>
													<c:when test="${stay.siDiscount > 0}">
														<div class="original-price">
															₩
															<fmt:formatNumber value="${room.riPrice}" type="number" />
														</div>
														<div class="discount-price">
															<span class="discount-rate"> <fmt:formatNumber
																	value="${discountPercent}" type="number" />%
															</span> <span class="final-price"> ₩<fmt:formatNumber
																	value="${room.discountedPrice}" type="number" /> ~
															</span> <span class="per-night">/ 박</span>
														</div>
													</c:when>
													<c:otherwise>
														<div class="discount-price">
															<span class="final-price"> ₩<fmt:formatNumber
																	value="${room.riPrice}" type="number" /> ~
															</span> <span class="per-night">/ 박</span>
														</div>
													</c:otherwise>
												</c:choose>
											</div>
											<button class="room-select-btn"
												onclick="location.href='/stay/${stay.siId}/${room.riId}'">객실
												선택</button>
										</div>
									</div>
								</div>
							</c:forEach>
						</div>
					</c:if>
				</section>


				<section id="guidelines" class="stay-section">
					<div class="amenity-title">안내사항</div>
					<div class="guidelines-content">
						<!-- 예약 안내 아코디언 -->
						<div class="accordion-item">
							<div class="accordion-header">
								<h3>예약 안내</h3>
								<span class="accordion-icon"><i class="ph ph-caret-down"></i></span>
							</div>
							<div class="accordion-content">
								<p>기준인원 초과 시 추가 금액이 부과될 수 있습니다.</p>
								<p>기준인원을 초과한 예약에는 추가 침구가 제공됩니다.</p>
								<p>반려 동물 동반이 [가능/불가능] 한 숙소입니다.</p>
							</div>
						</div>

						<!-- 이용 안내 아코디언 -->
						<div class="accordion-item">
							<div class="accordion-header">
								<h3>이용 안내</h3>
								<span class="accordion-icon"><i class="ph ph-caret-down"></i></span>
							</div>
							<div class="accordion-content">
								<p>체크인은 [체크인 시간]시, 체크아웃은 [체크아웃 시간]시 입니다.</p>
								<p>미성년자의 경우 보호자(법정대리인)의 동행 없이 투숙이 불가능합니다.</p>
								<p>화재 위험 및 쾌적한 환경 유지를 위해 실내 흡연은 절대 불가합니다.</p>
								<p>침구나 비품의 오염, 파손 및 분실 시 변상비가 청구됩니다.</p>
								<p>귀중품 분실에 대해서는 책임지지 않습니다.</p>
								<p>주차 [가능/불가능]한 숙소입니다.</p>
								<p>취식이 [가능/불가능]한 숙소입니다.</p>
							</div>
						</div>

						<!-- 환불 안내 아코디언 -->
						<div class="accordion-item">
							<div class="accordion-header">
								<h3>환불 안내</h3>
								<span class="accordion-icon"><i class="ph ph-caret-down"></i></span>
							</div>
							<div class="accordion-content">
								<p>
									<strong>숙박권의 재판매를 비롯하여 양도, 양수, 교환을 금지합니다.</strong>
								</p>
								<p>체크인 7일 전: 100% 환불</p>
								<p>체크인 3일 전: 50% 환불</p>
								<p>체크인 당일: 환불 불가</p>
								<p>천재지변, 기상 악화로 인한 예약 취소: 100% 환불</p>
								<p>숙소 사정으로 인한 예약 취소: 100% 환불 또는 대체 숙소 제공</p>
							</div>
						</div>

						<!-- 판매자 안내 아코디언 -->
						<div class="accordion-item">
							<div class="accordion-header">
								<h3>판매자 안내</h3>
								<span class="accordion-icon"><i class="ph ph-caret-down"></i></span>
							</div>
							<div class="accordion-content">
								<ul>
									<p>
										<strong>상호</strong>
									<p>${detail.siBizname}</p>
									<p>
										<strong>대표자명</strong>
									<p>${detail.siCeo}</p>

									</p>
									<p>
										<strong>주소</strong>
									<p>${detail.siAddress}</p>
									</p>
									<p>
										<strong>전화번호</strong>
									<p>${detail.siPhone}</p>
									</p>
									<p>
										<strong>이메일주소</strong>
									<p>${detail.siEmail}</p>
									</p>
									<p>
										<strong>사업자번호</strong>
									<p>${detail.siBiznum}</p>
									</p>
								</ul>
							</div>
						</div>

					</div>

				</section>
			</div>

			<!-- 우측 영역 (30%) -->
			<div class="room-detail-right">
				<!-- 예약 카드 (필터+요약 통합) -->
				<div class="booking-card">
					<form id="searchForm" method="POST" action="/search/results">
						<!-- 숨겨진 입력 필드들 -->
						<input type="hidden" name="checkin" id="checkinInput"
							value="${checkin}" /> <input type="hidden" name="checkout"
							id="checkoutInput" value="${checkout}" /> <input type="hidden"
							name="adult" id="adultInput" value="${param.adult}" /> <input
							type="hidden" name="child" id="childInput" value="${param.child}" />
						<input type="hidden" id="maxPerson" value="${room.riMaxperson}" />

						<div class="pill-filter">
							<!-- 일정 선택 -->
							<div class="filter-item date-filter">
								<div class="filter-content" id="dateSelect">
									<div class="selected-option">

										<span id="dateDisplay"> <span id="startDate"></span> -
											<span id="endDate"></span>
										</span>
									</div>
									<div class="date-picker-container">
										<div id="datePicker"></div>
										<div class="date-picker-error" id="dateError"></div>
										<div class="date-picker-footer">
											<div class="date-picker-buttons">
												<button type="button"
													class="date-picker-button date-picker-cancel"
													id="dateCancel">취소</button>
												<button type="button"
													class="date-picker-button date-picker-apply" id="dateApply">적용</button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!-- 구분선 -->
							<div class="filter-divider"></div>
							<!-- 인원 선택 -->
							<div class="filter-item people-filter">
								<div class="filter-content" id="peopleSelect">
									<div class="selected-option">
										<i class="ph ph-user"></i> <span id="peopleDisplay">성인
											2명</span>
									</div>
									<div class="people-selector-container">
										<div class="people-selector">
											<div class="people-type">
												<span>성인</span>
												<div class="counter">
													<button type="button" class="counter-btn decrease"
														data-type="adult">-</button>
													<span class="count" id="adultCount">2</span>
													<button type="button" class="counter-btn increase"
														data-type="adult">+</button>
												</div>
											</div>
											<div class="people-type">
												<span>아동</span>
												<div class="counter">
													<button type="button" class="counter-btn decrease"
														data-type="child">-</button>
													<span class="count" id="childCount">0</span>
													<button type="button" class="counter-btn increase"
														data-type="child">+</button>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
					</form>

					<div class="booking-price-info">
						<c:if test="${discountRate > 0}">
							<div class="stay-price-original">₩<fmt:formatNumber value="${roomPrice}" type="number"/></div>
						</c:if>
						<div class="stay-price-main">
							<c:if test="${discountRate > 0}">
								<span class="stay-price-discount"> <fmt:formatNumber
										value="${discountRate * 100}" type="number"
										maxFractionDigits="0" />%
								</span>
							</c:if>

							<span class="stay-price-current"><fmt:formatNumber value="${totalPrice}" type="number"/></span> <span
								class="per-night">/ 박</span>
						</div>
					</div>

					<div class="booking-price-details">
						<div class="price-detail-row">
							<c:set var="perNightPrice" value="${totalPrice / nights}" />
							<span>₩<fmt:formatNumber value="${perNightPrice}"
									type="number" /> * ${nights}</span>
						</div>
						<div class="price-detail-row">
							<span>총액</span> <span>₩<fmt:formatNumber value="${totalPrice}" type="number"/></span>
						</div>
					</div>

					<button 
  class="booking-button"
  data-si-id="${stay.siId}" 
  data-ri-id="${room.riId}">
  예약하기
</button>
				</div>
			</div>
		</div>
	</div>
	</div>

	<!-- 푸터 인클루드 -->
	<jsp:include page="../includes/footer.jsp" />
	
	<script>
  document.addEventListener("DOMContentLoaded", function () {
    const bookingBtn = document.querySelector(".booking-button");
    if (!bookingBtn) return;

    // JSP에서만 작동하는 EL 표현식
    const siId = "${stay.siId}";
    const riId = "${room.riId}";

    bookingBtn.addEventListener("click", function () {
      const checkin = document.getElementById("checkinInput").value;
      const checkout = document.getElementById("checkoutInput").value;
      const adult = document.getElementById("adultInput").value;
      const child = document.getElementById("childInput").value;

      const query = `?checkin=${checkin}&checkout=${checkout}&adult=${adult}&child=${child}`;
      window.location.href = `/reservation/${siId}/${riId}${query}`;
    });
  });
</script>

</body>
</html>
