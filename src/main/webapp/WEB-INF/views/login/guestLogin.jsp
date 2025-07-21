<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>게스트 로그인 - STAY FOLIO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/guestLogin.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
    <!-- Header Include -->
    <jsp:include page="../includes/header.jsp" />

    <!-- 게스트 로그인 -->
    <main class="guest-login-main">
        <div class="guest-login-container">
            <div class="guest-login-header">
                <h1>게스트로 이용하기</h1>
                <p>회원가입 없이 간편하게 숙소를 둘러보세요</p>
            </div>
            
            <div class="guest-options">
                <button class="guest-btn" onclick="location.href='${pageContext.request.contextPath}/home.jsp'">
                    <i class="ph ph-house"></i>
                    <span>게스트로 둘러보기</span>
                </button>
                
                <div class="divider">또는</div>
                
                <div class="login-options">
                    <a href="login.jsp" class="btn btn-primary">로그인</a>
                    <a href="signup.jsp" class="btn btn-secondary">회원가입</a>
                </div>
            </div>
        </div>
    </main>
</body>
</html>
