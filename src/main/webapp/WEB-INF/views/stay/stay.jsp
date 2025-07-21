<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>숙소 목록 - STAY FOLIO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
    <!-- Header Include -->
    <jsp:include page="../includes/header.jsp" />

    <!-- 숙소 목록 -->
    <main class="stay-main">
        <div class="stay-container">
            <div class="stay-header">
                <h1>숙소 목록</h1>
                <p>원하는 숙소를 찾아보세요</p>
            </div>
            
            <div class="stay-grid">
                <!-- 숙소 카드들이 여기에 렌더링됩니다 -->
            </div>
        </div>
    </main>
</body>
</html>
