<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>회원가입 완료 - STAY FOLIO</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/signupSuccess.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
	<!-- Header Include -->
	<jsp:include page="../includes/header.jsp" />

	<!-- 회원가입 완료 -->
	<main class="signup-success-main">
		<div class="signup-success-container">
			<div class="success-icon">
				<i class="ph ph-check-circle"></i>
			</div>
			<h2>회원가입이 완료되었습니다!</h2>
			<p class="welcome-message">
				STAY FOLIO의 회원이 되신 것을 환영합니다.<br /> 다양한 서비스와 혜택을 만나보세요.
			</p>

			<div class="next-steps">
				<a href="${pageContext.request.contextPath}/login" class="btn-login">로그인 하기</a>
				<a href="${pageContext.request.contextPath}/" class="btn-main">메인으로 가기</a>
			</div>
		</div>
	</main>
</body>
</html>
