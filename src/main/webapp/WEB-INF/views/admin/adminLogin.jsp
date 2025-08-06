<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
            <div class="admin-login-header">
                <h1>STAY FOLIO</h1>
                <h2>관리자 로그인</h2>
            </div>
            
            <form class="admin-login-form" id="adminLoginForm">
                <div class="input-group">
                    <label for="adminId">관리자 ID</label>
                    <input type="text" id="adminId" name="adminId" placeholder="관리자 ID를 입력하세요" required>
                    <span class="error-message" id="adminIdError"></span>
                </div>
                
                <div class="input-group">
                    <label for="adminPassword">비밀번호</label>
                    <input type="password" id="adminPassword" name="adminPassword" placeholder="비밀번호를 입력하세요" required>
                    <span class="error-message" id="adminPasswordError"></span>
                </div>
                
                <button type="submit" class="admin-login-btn">관리자 로그인</button>
            </form>
            
            <div class="back-to-main">
                <a href="${pageContext.request.contextPath}/home.jsp">← 메인으로 돌아가기</a>
            </div>
        </div>
    </main>
</body>
</html>
