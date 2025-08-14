<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
	href="${pageContext.request.contextPath}/resources/css/stay/stay.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/stay/stayCarousel.css" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<!-- kakao api -->
<script type="text/javascript"
	src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=23c99c1ca832c53450f37e55c5731901&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Carousel JS -->
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayCarousel.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stayNavigation.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/stay/stay.js"></script>
<script
	src="${pageContext.request.contextPath}/resources/js/bookmark/bookmark.js"></script>
</head>

<body>
	<!-- 헤더 인클루드 -->
	<jsp:include page="../includes/header.jsp" />

	<!-- 숙소 캐러셀 시작 -->
	<section class="carousel-container">
		<!-- 뒤로가기 버튼 -->
		<a href="javascript:history.back()" class="back-button"> <i
			class="ph ph-arrow-left"></i>
		</a>
		<div class="carousel">
			<div class="carousel-track">
				<c:forEach var="photo" items="${stayPhotos.main}" varStatus="status">
					<div class="carousel-slide ${status.first ? 'active' : ''}">
						<img class="preview" src="${s3BaseUrl}${photo.spUrl}" alt="대표 이미지" />
					</div>
				</c:forEach>
				<c:forEach var="photo" items="${stayPhotos.additional}">
					<div class="carousel-slide">
						<img class="preview" src="${s3BaseUrl}${photo.spUrl}" alt="추가 이미지" />
					</div>
				</c:forEach>
				<c:forEach var="photo" items="${stayPhotos.feature}">
					<div class="carousel-slide">
						<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
							alt="주요 특징 이미지" />
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
				<c:forEach var="photo" items="${stayPhotos.main}" varStatus="status">
					<button class="indicator ${status.first ? 'active' : ''}"
						data-slide="${status.index}"></button>
				</c:forEach>
				<c:forEach var="photo" items="${stayPhotos.additional}"
					varStatus="status">
					<button class="indicator"
						data-slide="${status.index + stayPhotos.main.size()}"></button>
				</c:forEach>
				<c:forEach var="photo" items="${stayPhotos.feature}"
					varStatus="status">
					<button class="indicator"
						data-slide="${status.index + stayPhotos.main.size() + stayPhotos.additional.size()}"></button>
				</c:forEach>
			</div>

		</div>
	</section>
	<!-- 숙소 캐러셀 끝 -->

	<!-- 숙소 정보 시작 -->
	<section class="stay-info-container">
		<div class="stay-info">
			<div class="stay-header">
				<div class="title-row">
					<h1>${stay.siName}</h1>
					<button class="heart-btn stay-wishlist"
						data-wishlist="${stay.bookmarked }">
						<i class="ph ph-heart"></i>
					</button>
				</div>
				<div class="stay-location">${stay.siLoca}</div>
			</div>
			<div class="stay-stats">
				<span class="views"><i class="ph ph-heart"></i>${stay.siBook}</span>
			</div>

			<c:if test="${not empty stayFacilities}">
				<div class="amenity-title">편의시설</div>
				<div class="stay-amenities">
					<c:forEach var="fac" items="${stayFacilities}">
						<div class="amenity">
							<i class="ph ${fac.fiIcon}"></i> <span>${fac.fiName}</span>
						</div>
					</c:forEach>
				</div>
			</c:if>

			<c:if test="${not empty detail.siNotice}">
				<div class="amenity-title">공지사항</div>
				<div class="stay-amenities">
					<div class="notice">
						<span>${detail.siNotice}</span>
					</div>
				</div>
			</c:if>

			<!-- 미니 네비게이션 -->
			<div class="stay-nav-container" id="stay-nav-container">
				<nav class="stay-nav">
					<ul>
						<li class="active"><a href="#stay-intro">스테이 소개</a></li>
						<li><a href="#room-select">객실 선택</a></li>
						<!-- <li><a href="#reviews">리뷰</a></li> -->
						<li><a href="#location-info">위치 및 정보</a></li>
						<li><a href="#guidelines">안내사항</a></li>
					</ul>
				</nav>
			</div>

			<!-- 스테이 소개 섹션 -->
			<section id="stay-intro" class="stay-section">
				<!-- 1. 타이틀 -->
				<h2 class="section-title">${stay.siDesc}</h2>

				<!-- 2. 대표이미지 1 -->
				<c:forEach var="photo" items="${stayPhotos.additional}"
					varStatus="status">
					<c:if test="${status.index == 0}">
						<div class="stay-main-image">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="대표 이미지 2" class="full-width-image" />
						</div>
					</c:if>
				</c:forEach>

				<!-- 3. 대표이미지 1 설명 -->
				<div class="stay-description-main">
					<p>${detail.siDesc1}</p>
				</div>

				<!-- 4. 대표이미지 2 -->
				<c:forEach var="photo" items="${stayPhotos.additional}"
					varStatus="status">
					<c:if test="${status.index == 1}">
						<div class="stay-main-image">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="대표 이미지 2" class="full-width-image" />
						</div>
					</c:if>
				</c:forEach>

				<!-- 5. 대표이미지 2 설명 -->
				<div class="stay-description-main">
					<p>${detail.siDesc2}</p>
				</div>

				<!-- 6. 주요특징(서브타이틀) -->
				<h3 class="feature-title">주요 특징</h3>

				<!-- 7. 사진 3개 영역 1 -->
				<div class="photo-group">
					<c:forEach var="photo" items="${stayPhotos.feature}">
						<div class="photo-item">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}" />
						</div>
					</c:forEach>
				</div>

				<!-- 8. 설명 1 -->
				<div class="feature-description">
					<h4>${detail.siFeatTitle1}</h4>
					<p>${detail.siFeat1}</p>
				</div>

				<!-- 9. 사진 3개 영역 2 -->
				<div class="photo-group">
					<c:forEach var="photo" items="${stayPhotos.feat1}">
						<div class="photo-item">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}" />
						</div>
					</c:forEach>
				</div>

				<!-- 10. 설명 2 -->
				<div class="feature-description">
					<h4>${detail.siFeatTitle2}</h4>
					<p>${detail.siFeat2}</p>
				</div>

				<!-- 11. 사진 3개 영역 3-->
				<div class="photo-group">
					<c:forEach var="photo" items="${stayPhotos.feat2}">
						<div class="photo-item">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}" />
						</div>
					</c:forEach>
				</div>


				<!-- 12. 설명 3
				<div class="feature-description">
					<h4>DEBLAUX BAR</h4>
					<p>ALTEC LANSING, JBL, OJAS by DEVON TURNBULL 등 하이파이 사운드 시스템으로
						구성된 리스닝 바가 있습니다. 엄선된 메뉴와 무드를 즐겨보세요.</p>
				</div>-->
			</section>

			<!-- 객실 할인율 적용 set -->
			<c:set var="discountPercent" value="${stay.siDiscount * 100}" />

			<!-- 객실 선택 섹션 -->
			<section id="room-select" class="stay-section">
				<h2 class="section-title">객실 선택</h2>
				<div class="room-list">
					<c:forEach var="room" items="${rooms}">
						<div class="room-card">
							<div class="room-image">
								<img src="${s3BaseUrl}${roomMainPhotos[room.riId].spUrl}"
									alt="${room.riName}" />
							</div>
							<div class="room-info">
								<h3>${room.riName}</h3>
								<p class="room-capacity">
									<c:choose>
										<c:when test="${room.riType == 'a'}">기본형</c:when>
										<c:when test="${room.riType == 'b'}">독채형</c:when>
										<c:when test="${room.riType == 'c'}">원룸형</c:when>
										<c:when test="${room.riType == 'd'}">도미토리</c:when>
										<c:when test="${room.riType == 'e'}">복층형</c:when>
										<c:otherwise>기타</c:otherwise>
									</c:choose>
									/ 기준 ${room.riPerson}명 (최대 ${room.riMaxperson}명)
								</p>
								<p class="room-amenity">침실 ${room.riBedroom} | 침대
									${room.riBedcnt} | 욕실 ${room.riBathroom}</p>

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

									<%-- 최소/기본값 정리 (1줄씩) --%>
									<c:set var="childN"
										value="${(empty param.child ? 0 : param.child) + 0}" />
									<c:set var="adultN"
										value="${(empty param.adult ? room.riPerson : param.adult) + 0}" />

									<%-- 방 최소인원 보정 --%>
									<c:if test="${adultN + childN lt room.riPerson}">
										<c:set var="adultN" value="${room.riPerson - childN}" />
									</c:if>

									<%-- URL (체크인/아웃만 있으면 붙임, adult/child는 항상 숫자로) --%>
									<c:url var="roomUrl" value="/stay/${stay.siId}/${room.riId}">
										<c:if test="${not empty param.checkin}">
											<c:param name="checkin" value="${param.checkin}" />
										</c:if>
										<c:if test="${not empty param.checkout}">
											<c:param name="checkout" value="${param.checkout}" />
										</c:if>
										<c:param name="adult" value="${adultN}" />
										<c:param name="child" value="${childN}" />
									</c:url>

									<%-- 버튼 --%>
									<c:choose>
										<c:when test="${adultN + childN le room.riMaxperson}">
											<a class="room-select-btn" href="${roomUrl}">객실 선택</a>
										</c:when>
										<c:otherwise>
											<button class="room-select-btn disabled" disabled>인원
												초과</button>
										</c:otherwise>
									</c:choose>



								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</section>

			<!-- 위치 및 정보 섹션 -->
			<section id="location-info" class="stay-section">
				<h2 class="section-title">위치 및 정보</h2>
				<div class="location-info-container">
					<div class="location-details">
						<p>${stay.siName}의위치는[${detail.siAddress}]입니다.</p>
						<p>${detail.siAddrdesc}</p>
						<div class="contact-info">
							<c:if test="${not empty detail.siPhone}">
								<div class="contact-item">
									<i class="ph ph-phone"></i> <span>${detail.siPhone}</span>
								</div>
							</c:if>

							<c:if test="${not empty detail.siEmail}">
								<div class="contact-item">
									<i class="ph ph-envelope"></i> <span>${detail.siEmail}</span>
								</div>
							</c:if>

							<c:if test="${not empty detail.siInstagram}">
								<div class="contact-item">
									<i class="ph ph-instagram-logo"></i> <span>${detail.siInstagram}</span>
								</div>
							</c:if>
						</div>
					</div>
				</div>

				<!-- 카카오맵 영역 -->
				<div class="location-map">
					<div id="map" style="width: 100%; height: 400px"></div>
				</div>
			</section>

			<!-- 안내사항 섹션 -->
			<section id="guidelines" class="stay-section">
				<h2 class="section-title">안내사항</h2>
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
							<p>반려 동물 동반이 ${detail.siPet ? '가능' : '불가능' }한 숙소입니다.</p>
						</div>
					</div>

					<!-- 이용 안내 아코디언 -->
					<div class="accordion-item">
						<div class="accordion-header">
							<h3>이용 안내</h3>
							<span class="accordion-icon"><i class="ph ph-caret-down"></i></span>
						</div>
						<div class="accordion-content">
							<p>체크인은 ${fn:substring(detail.siCheckin, 0, 2)}시, 체크아웃은 ${fn:substring(detail.siCheckout, 0, 2)}시 입니다.</p>
							<p>미성년자의 경우 보호자(법정대리인)의 동행 없이 투숙이 불가능합니다.</p>
							<p>화재 위험 및 쾌적한 환경 유지를 위해 실내 흡연은 절대 불가합니다.</p>
							<p>침구나 비품의 오염, 파손 및 분실 시 변상비가 청구됩니다.</p>
							<p>귀중품 분실에 대해서는 책임지지 않습니다.</p>
							<p>주차 ${detail.siParking ? '가능' : '불가능'}한 숙소입니다.</p>
							<p>취식이 ${detail.siFood ? '가능' : '불가능'}한 숙소입니다.</p>
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
				</div>
			</section>
		</div>
	</section>
	<!-- 숙소 정보 끝 -->


	<!-- 푸터 인클루드 -->
	<jsp:include page="../includes/footer.jsp" />

	<!-- 카카오맵 API -->
	<script>
		window.onload = function() {
			if (typeof kakao === 'undefined') {
				alert("카카오맵이 아직 로딩되지 않았습니다.");
				return;
			}

			const container = document.getElementById("map");
			const options = {
				center : new kakao.maps.LatLng(33.450701, 126.570667),
				level : 3,
			};
			const map = new kakao.maps.Map(container, options);

			const geocoder = new kakao.maps.services.Geocoder();
			const address = '${detail.siAddress}';

			geocoder
					.addressSearch(
							address,
							function(result, status) {
								if (status === kakao.maps.services.Status.OK) {
									const coords = new kakao.maps.LatLng(
											result[0].y, result[0].x);
									map.setCenter(coords);

									const marker = new kakao.maps.Marker({
										map : map,
										position : coords,
									});

									const infowindow = new kakao.maps.InfoWindow(
											{
												content : `<div style="padding:5px;">${stay.siName}</div>`,
											});
									infowindow.open(map, marker);
								}
							});
		};
	</script>
</body>
</html>
