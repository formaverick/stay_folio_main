<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>관리자 로그인 - STAY FOLIO</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/adminLogin.css" />
<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Custom JS -->
<script src="${pageContext.request.contextPath}/resources/js/admin/adminLogin.js"></script>
</head>
<body>
	<main class="admin-login-main">
		<div class="admin-login-container">
			<div class="admin-login-content">
				<!-- 로고 -->
				<div class="admin-logo">
					<h1 class="logo-text">
						STAY<br />FOLIO
					</h1>
				</div>

				<!-- 관리자 타이틀 -->
				<div class="admin-title">
					<h2>ADMIN</h2>
					<p class="admin-subtitle">로그인</p>
				</div>

				<!-- 로그인 폼 -->
				<form class="admin-login-form" method="post">
					<div class="form-group">
						<label for="admin-id">아이디</label>
						<input type="text" id="admin-id" name="admin-id" placeholder="아이디를 입력해주세요." />
						<p class="error-message">아이디를 입력해주세요.</p>
					</div>

					<div class="form-group">
						<label for="admin-password">비밀번호</label>
						<input type="password" id="admin-password" name="admin-password" placeholder="비밀번호를 입력해주세요." />
						<p class="error-message">비밀번호를 입력해주세요.</p>
					</div>

					<button type="submit" class="btn-admin-login">LOGIN</button>
				</form>
			</div>
		</div>
	</main>
</body>
</html>
