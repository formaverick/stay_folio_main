<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<c:set var="s3BaseUrl" value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>STAY FOLIO</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/mypageCommon.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/mypage/bookmark.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<!-- Font Awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" />
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/bookmark/bookmark.js" ></script>
<script>
	$(document).ready(function() {
		wishEvent();
	});
</script>
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
					<li><a href="/mypage/reservations">예약 정보</a></li>
					<li class="active"><a href="/mypage/bookmarks">북마크</a></li>
					<li><a href="#">회원정보 수정</a></li>
				</ul>
			</div>

			<div class="mypage-main">
				<div class="results-group">
					<c:forEach var="stay" items="${bookmarkList }">
						<div class="stay-item" data-stay-id="${stay.siId }">
							<div class="search-stay-image">
								<img src="${s3BaseUrl}${stay.spUrl}" alt="${stay.siName }" />
								<button class="search-stay-wishlist stay-wishlist" data-wishlist="true" data-stay-id="${stay.siId}">
									<i class="ph ph-heart"></i>
								</button>
							</div>
							<div class="search-stay-content">
								<h3 class="search-stay-name">${stay.siName }</h3>
								<div class="search-stay-location">
									<i class="ph ph-map-pin"></i> ${stay.siLoca }
								</div>
								<div class="search-stay-price">
									<c:choose>
										<c:when test="${stay.discount eq 0 }">
											<div class="search-stay-price-main">
												<span class="search-stay-price-current"><fmt:formatNumber value="${stay.siMinprice}" type="currency" />~</span>
											</div>
										</c:when>
										<c:otherwise>
											<span class="search-stay-price-original">
												<fmt:formatNumber value="${stay.siMinprice}" type="currency" />
											</span>
											<div class="search-stay-price-main">
												<span class="search-stay-price-discount">
													<fmt:formatNumber value="${stay.discount}" maxFractionDigits="0" />%
												</span>
												<span class="search-stay-price-current"><fmt:formatNumber value="${stay.discountedPrice }" type="currency" />~</span>
											</div>
										</c:otherwise>
									</c:choose>
								</div>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
		</div>
	</main>
	
	<jsp:include page="../includes/footer.jsp" />
	
</body>
</html>
