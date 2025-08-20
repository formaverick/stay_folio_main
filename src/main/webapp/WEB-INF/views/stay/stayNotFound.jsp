<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	href="${pageContext.request.contextPath}/resources/css/stay/stayNotFound.css" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
	<jsp:include page="../includes/header.jsp" />
	
	<div class="not-find">
		<div class="bg">
			<div class="msg">
				"현재 예약을 제공하지 않는 스테이입니다."
				<br>
				"Bookings are currently not available."
			</div>
			<a href="/">홈으로 이동</a>
		</div>
	</div>
	
	<jsp:include page="../includes/footer.jsp" />
</body>
</html>