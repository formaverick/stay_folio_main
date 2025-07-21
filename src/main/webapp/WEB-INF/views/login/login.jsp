<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>로그인 - STAY FOLIO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/login/login.js"></script>
</head>
<body>
    <!-- Header Include -->
    <jsp:include page="../includes/header.jsp" />

    <!-- 로그인 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/login.css" />
    
    <main class="login-main">
        <div class="login-container">
            <div class="login-header">
                <h1>로그인</h1>
                <p>스테이폴리오에 오신 것을 환영합니다</p>
            </div>
            
            <form class="login-form" id="loginForm">
                <div class="input-group">
                    <label for="email">이메일</label>
                    <input type="email" id="email" name="email" placeholder="이메일을 입력하세요" required>
                    <span class="error-message" id="emailError"></span>
                </div>
                
                <div class="input-group">
                    <label for="password">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
                    <span class="error-message" id="passwordError"></span>
                </div>
                
                <div class="login-options">
                    <label class="checkbox-container">
                        <input type="checkbox" id="rememberMe">
                        <span class="checkmark"></span>
                        로그인 상태 유지
                    </label>
                    <a href="#" class="forgot-password">비밀번호를 잊으셨나요?</a>
                </div>
                
                <button type="submit" class="login-btn">로그인</button>
            </form>
            
            <div class="signup-link">
                <p>아직 계정이 없으신가요? <a href="signup.jsp">회원가입</a></p>
            </div>
        </div>
    </main>
</body>
</html>
