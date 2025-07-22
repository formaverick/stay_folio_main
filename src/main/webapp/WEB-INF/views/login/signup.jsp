<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입 - STAY FOLIO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/login/signup.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/login/signup.js"></script>
</head>
<body>
    <!-- Header Include -->
    <jsp:include page="../includes/header.jsp" />

    <!-- 회원가입 -->
    <main class="signup-main">
        <div class="signup-container">
            <div class="signup-header">
                <h1>회원가입</h1>
                <p>스테이폴리오와 함께 특별한 여행을 시작하세요</p>
            </div>
            
            <form class="signup-form" id="signupForm" >
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
                
                <div class="input-group">
                    <label for="confirmPassword">비밀번호 확인</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" placeholder="비밀번호를 다시 입력하세요" required>
                    <span class="error-message" id="confirmPasswordError"></span>
                </div>
                
                <div class="input-group">
                    <label for="name">이름</label>
                    <input type="text" id="name" name="name" placeholder="이름을 입력하세요" required>
                    <span class="error-message" id="nameError"></span>
                </div>
                
                <div class="input-group">
                    <label for="phone">전화번호</label>
                    <input type="tel" id="phone" name="phone" placeholder="전화번호를 입력하세요" required>
                    <span class="error-message" id="phoneError"></span>
                </div>
                
                <div class="terms-section">
                    <label class="checkbox-container">
                        <input type="checkbox" id="agreeAll">
                        <span class="checkmark"></span>
                        전체 동의
                    </label>
                    
                    <div class="terms-list">
                        <label class="checkbox-container">
                            <input type="checkbox" id="agreeTerms" required>
                            <span class="checkmark"></span>
                            [필수] 이용약관 동의
                        </label>
                        
                        <label class="checkbox-container">
                            <input type="checkbox" id="agreePrivacy" required>
                            <span class="checkmark"></span>
                            [필수] 개인정보 처리방침 동의
                        </label>
                        
                        <label class="checkbox-container">
                            <input type="checkbox" id="agreeMarketing">
                            <span class="checkmark"></span>
                            [선택] 마케팅 정보 수신 동의
                        </label>
                    </div>
                </div>
                
                <button type="submit" class="signup-btn">회원가입</button>
            </form>
            
            <div class="login-link">
                <p>이미 계정이 있으신가요? <a href="login.jsp">로그인</a></p>
            </div>
        </div>
    </main>
</body>
</html>
