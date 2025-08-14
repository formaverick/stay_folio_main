<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page contentType="text/html; charset=UTF-8"%>
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
<title>숙소 조회 - STAY FOLIO</title>
<!-- CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/search/searchFilter.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/search/search.css" />
<!-- 폰트 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />

    <!-- 아이콘 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.4/css/all.min.css" crossorigin="anonymous" referrerpolicy="no-referrer" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"
    />
  </head>
  <body>
	<jsp:include page="../includes/header.jsp" />
	<!-- 검색 필터 시작 -->
	<section class="search-filter-container">
		<div class="keyword-filter">
			<div class="keyword-content">
				<div class="keyword-option">
					<i class="ph ph-magnifying-glass"></i>
					<input type="text" id="keyword" name="keyword" placeholder="지역, 숙소명을 검색해보세요." autocomplete="off" data-api="${pageContext.request.contextPath}/search/keyword" data-context="${pageContext.request.contextPath}" />
				</div>
			</div>
		</div>
		<div class="search-filter-inner">
			<form id="searchForm" method="POST" action="/search/results">
				<!-- 숨겨진 입력 필드들 -->
				<input type="hidden" id="regionInput" name="region" value="all" />
				<input type="hidden" id="startDateInput" name="startDate" value="" />
				<input type="hidden" id="endDateInput" name="endDate" value="" /> <input
					type="hidden" id="adultsInput" name="adult" value="2" /> <input
					type="hidden" id="childrenInput" name="children" value="0" />

				<div class="pill-filter">
					<!-- 지역 선택 -->
					<div class="filter-item region-filter">
						<div class="filter-content" id="regionSelect">
							<div class="selected-option">
								<i class="ph ph-magnifying-glass"></i> <span>전국</span>
							</div>
							<div class="dropdown-container">
								<ul class="dropdown-options">
									<li class="option" data-value="all">전국</li>
									<li class="option" data-value="seoul" data-lc-id="1">서울</li>
									<li class="option" data-value="gyeonggi" data-lc-id="2">경기도</li>
									<li class="option" data-value="incheon" data-lc-id="13">인천</li>
									<li class="option" data-value="gangwon" data-lc-id="3">강원도</li>
									<li class="option" data-value="chungcheong" data-lc-id="4">충청남도</li>
									<li class="option" data-value="chungcheong" data-lc-id="5">충청북도</li>
									<li class="option" data-value="jeolla" data-lc-id="6">전라남도</li>
									<li class="option" data-value="jeolla" data-lc-id="7">전라북도</li>
									<li class="option" data-value="gyeongsang" data-lc-id="9">경상남도</li>
									<li class="option" data-value="chungcheong" data-lc-id="8">경상북도</li>
									<li class="option" data-value="chungcheong" data-lc-id="10">부산</li>
									<li class="option" data-value="jeju" data-lc-id="11">제주</li>
									<li class="option" data-value="chungcheong" data-lc-id="12">대전</li>
									<li class="option" data-value="chungcheong" data-lc-id="14">대구</li>
									<li class="option" data-value="chungcheong" data-lc-id="15">광주</li>
								</ul>
							</div>
						</div>
					</div>


					<!-- 일정 선택 -->
					<div class="filter-item date-filter">
						<div class="filter-content" id="dateSelect">
							<div class="selected-option">
								<i class="ph ph-calendar"></i> <span id="dateDisplay"><span
									id="startDate"></span> - <span id="endDate"></span></span>
							</div>
							<div class="date-picker-container">
								<div id="datePicker"></div>
								<div class="date-picker-error" id="dateError"></div>
								<div class="date-picker-footer">
									<div class="date-picker-buttons">
										<button type="button"
											class="date-picker-button date-picker-cancel" id="dateCancel">
											취소</button>
										<button type="button"
											class="date-picker-button date-picker-apply" id="dateApply">
											적용</button>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="filter-divider"></div>

					<!-- 인원 선택 -->
					<div class="filter-item people-filter">
						<div class="filter-content" id="peopleSelect">
							<div class="selected-option">
								<i class="ph ph-user"></i> <span id="peopleDisplay">성인 2명</span>
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
									<div class="people-selector-buttons">
										<button type="button"
											class="people-selector-button people-selector-cancel" id="peopleCancel">
											취소</button>
										<button type="button"
											class="people-selector-button people-selector-apply" id="peopleApply">
											적용</button>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- 키워드 검색 -->
				<div class="filter-divider"></div>

				

				</div>
			</form>
		</div>
	</section>
	<!-- 검색 필터 끝 -->
	<!-- 카테고리 섹션 시작 -->
	<section class="category-section">
		<div class="category-container">
			<div class="category-list">
				<button class="category-item active" data-category="all"
					data-rc-id="0">
					<div class="category-icon">
						<i class="fas fa-home"></i>
					</div>
					<span class="category-text">모두</span>
				</button>
				<button class="category-item" data-category="new" data-rc-id="6">
					<div class="category-icon">
						<i class="fas fa-star"></i>
					</div>
					<span class="category-text">신규오픈</span>
				</button>
				<button class="category-item" data-category="exclusive"
					data-rc-id="7">
					<div class="category-icon">
						<i class="fas fa-crown"></i>
					</div>
					<span class="category-text">단독소개</span>
				</button>
				<button class="category-item" data-category="best" data-rc-id="8">
					<div class="category-icon">
						<i class="fas fa-trophy"></i>
					</div>
					<span class="category-text">베스트 스테이</span>
				</button>
				<button class="category-item" data-category="steady" data-rc-id="9">
					<div class="category-icon">
						<i class="fas fa-fire"></i>
					</div>
					<span class="category-text">스테디셀러</span>
				</button>
				<button class="category-item" data-category="emotional"
					data-rc-id="10">
					<div class="category-icon">
						<i class="fas fa-heart"></i>
					</div>
					<span class="category-text">감성 숙소</span>
				</button>
				<button class="category-item" data-category="nature" data-rc-id="11">
					<div class="category-icon">
						<i class="fas fa-tree"></i>
					</div>
					<span class="category-text">자연속에서</span>
				</button>
				<button class="category-item" data-category="ocean" data-rc-id="12">
					<div class="category-icon">
						<i class="fas fa-water"></i>
					</div>
					<span class="category-text">바다와 함께</span>
				</button>
				<button class="category-item" data-category="couple" data-rc-id="13">
					<div class="category-icon">
						<i class="fas fa-kiss-wink-heart"></i>
					</div>
					<span class="category-text">연인과 함께</span>
				</button>
			</div>
		</div>
		<form id="filterForm" action="/stay/search" method="get">
			<input type="hidden" id="lcId" name="lcId" value="${lcId}" /> <input
				type="hidden" name="rcId" id="rcId" value="${param.rcId}" /> <input
				type="hidden" name="checkin" value="${param.checkin}" /> <input
				type="hidden" name="checkout" value="${param.checkout}" /> <input
				type="hidden" name="totalPerson" value="${param.totalPerson}" />
		</form>
	</section>
	<!-- 카테고리 섹션 끝 -->
	<!-- 검색 결과 섹션 시작 -->
	<section class="search-results-section">
		<div class="search-results-container" id="searchResultsSection">
			<!-- 검색 결과 헤더 -->
			<div class="search-results-header">
				<!-- 숙소 카테고리 필터 -->
				<h2 class="search-results-title" id="searchTitle">
					<c:choose>
						<c:when test="${rcId == 0}">전체 숙소</c:when>
						<c:when test="${rcId == 6}">신규오픈 숙소</c:when>
						<c:when test="${rcId == 7}">단독소개 숙소</c:when>
						<c:when test="${rcId == 8}">베스트 스테이</c:when>
						<c:when test="${rcId == 9}">스테디셀러</c:when>
						<c:when test="${rcId == 10}">감성 숙소</c:when>
						<c:when test="${rcId == 11}">자연속 숙소</c:when>
						<c:when test="${rcId == 12}">바다뷰 숙소</c:when>
						<c:when test="${rcId == 13}">커플 추천 숙소</c:when>
						<c:otherwise>검색 결과</c:otherwise>
					</c:choose>
				</h2>

				<p class="search-results-count">
					총 <span id="resultsCount">${fn:length(stayList)}</span>개의 숙소
				</p>
			</div>

			<div class="search-results-grid" id="searchResultsGrid">
				<c:if test="${not empty stayList}">
					<c:set var="bannerCount" value="0" />
					<c:forEach var="stay" items="${stayList}" varStatus="loop">

						<%-- 9개마다 그룹 시작 --%>
						<c:if test="${loop.index % 9 == 0}">
							<div class="results-group">
						</c:if>
						<!-- 숙소 카드 -->
							<a href="/stay/${stay.siId}?checkin=${checkin}&checkout=${checkout}&adult=${adult}&child=${child}">
							<div class="search-stay-item stay-item"
								data-stay-id="${stay.siId }">
								<div class="search-stay-image">
									<img src="${s3BaseUrl}${stay.spUrl}" alt="${stay.siName}" />
									<button class="search-stay-wishlist stay-wishlist"
										data-wishlist="${stay.bookmarked }" data-stay-id="${stay.siId }">
										<i class="ph ph-heart"></i>
									</button>
									<c:if test="${stay.siDiscount > 0}">
										<div class="search-stay-promotion">프로모션</div>
									</c:if>
								</div>
								<div class="search-stay-content">
									<h3 class="search-stay-name">${stay.siName}</h3>
									<div class="search-stay-location">
										<i class="ph ph-map-pin"></i> ${stay.siLoca}
									</div>
									<div class="search-stay-price">
										<c:choose>
											<c:when test="${stay.siDiscount > 0}">
												<span class="search-stay-price-original"> ₩<fmt:formatNumber
														value="${stay.siMinprice}" type="number"
														groupingUsed="true" />
												</span>
												<div class="search-stay-price-main">
													<span class="search-stay-price-discount"> <fmt:formatNumber
															value="${stay.siDiscount * 100}" maxFractionDigits="0" />%
													</span> <span class="search-stay-price-current"> ₩<fmt:formatNumber
															value="${stay.siMinprice * (1 - stay.siDiscount)}"
															type="number" groupingUsed="true" />~
													</span>
													
												</div>
												
											</c:when>
											<c:otherwise>
												<div class="search-stay-price-main">
													<span class="search-stay-price-current"> ₩<fmt:formatNumber
															value="${stay.siMinprice}" type="number"
															groupingUsed="true" />~
													</span>
												</div>
											</c:otherwise>
										</c:choose>
									</div>
								</div>
							</div></a> <%-- 9개마다 그룹 끝 --%> <c:if
								test="${(loop.index + 1) % 9 == 0 or loop.last}">
			</div>
			<%-- .results-group 끝 --%>

			<%-- 배너 출력: 최대 3개까지 --%>
			<c:if test="${bannerCount lt 3}">
				<c:set var="bannerCount" value="${bannerCount + 1}" />
				<div class="search-banner">
					<div class="banner-background">
						<img
							src="${pageContext.request.contextPath}/resources/img/stay/ad${bannerCount}.png"
							alt="배너${bannerCount}" />
						<div class="banner-overlay"></div>
					</div>
					<div class="banner-ad-label">AD</div>
					<div class="banner-content">
						<c:choose>
							<c:when test="${bannerCount == 1}">
								<h3>제주 신규 스테이, 20% 할인</h3>
								<p>오픈 기념, 모든 일자 할인 중이에요!</p>
							</c:when>
							<c:when test="${bannerCount == 2}">
								<h3>프리미엄 숙소 추천</h3>
								<p>럭셔리한 휴식을 경험해보세요</p>
							</c:when>
							<c:when test="${bannerCount == 3}">
								<h3>지금 예약 시 무료 조식</h3>
								<p>조식 포함 상품, 한정 수량!</p>
							</c:when>
						</c:choose>
					</div>
				</div>
			</c:if>
			</c:if>

			</c:forEach>
			</c:if>
		</div>
		</div>
	</section>

	<!-- 검색 결과 섹션 끝 -->
	<!-- 모달 시작 -->
	<div class="modal-overlay" id="commonModal">
		<div class="modal-content">
			<p class="modal-message">
				로그인 후 사용 가능합니다.<br />로그인 하시겠습니까?
			</p>
			<div class="modal-buttons">
				<button class="btn btn-cancel" onclick="closeModal()">취소</button>
				<button class="btn btn-confirm"
					onclick="location.href='${pageContext.request.contextPath}/login'">확인</button>
			</div>
		</div>
	</div>

	<form id="searchForm" action="/stay/search" method="get">
		<!-- 체크인 날짜 -->
		<input type="hidden" name="checkin" id="checkin" value="">
		<!-- 체크아웃 날짜 -->
		<input type="hidden" name="checkout" id="checkout" value="">
		<!-- 성인 수 -->
		<input type="hidden" name="adult" id="adult" value="2">
		<!-- 아동 수 -->
		<input type="hidden" name="child" id="child" value="0">
	</form>

	<!-- 모달 끝 -->
	<script>
		function openModal() {
			document.getElementById("commonModal").style.display = "flex";
		}

		function closeModal() {
			document.getElementById("commonModal").style.display = "none";
		}
	</script>

	<script
		src="${pageContext.request.contextPath}/resources/js/bookmark/bookmark.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/search/searchFilter.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/search/search.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/search/keyword.js"></script>
	<script
		src="${pageContext.request.contextPath}/resources/js/search/searchCategory.js"></script>
	<script>
	  // 임시: 키워드 입력창 추천 패널 토글
	  (function(){
	    const input = document.getElementById('keyword');
	    const panel = document.getElementById('keywordSuggestions');
	    const content = document.querySelector('.keyword-content');
	    if(!input || !panel || !content) return;

	    function show(){ panel.style.display = 'block'; }
	    function hide(){ panel.style.display = 'none'; }

	    // 기본: 포커스/입력 시 표시 (임시이므로 입력 여부와 무관하게 표시)
	    input.addEventListener('focus', show);
	    input.addEventListener('input', show);

	    // ESC로 닫기
	    input.addEventListener('keydown', function(e){ if(e.key === 'Escape'){ hide(); } });

	    // 외부 클릭 시 닫기
	    document.addEventListener('click', function(e){
	      if(!content.contains(e.target)) hide();
	    });
	  })();
	</script>
	<%@ include file="../includes/footer.jsp"%>
</body>

<script>
  // 예: 추천 카테고리 버튼 클릭 시
  document.querySelectorAll(".rc-button").forEach(btn => {
    btn.addEventListener("click", function () {
      document.getElementById("rcId").value = this.dataset.rcid;
      document.getElementById("filterForm").submit();
    });
  });
</script>

</body>
</html>
