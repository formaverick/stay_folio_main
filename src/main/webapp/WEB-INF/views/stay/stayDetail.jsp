<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>숙소 상세 - STAY FOLIO</title>
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

    <!-- 숙소 상세 -->
    <main class="stay-detail-main">
        <div class="stay-detail-container">
            <div class="stay-detail-header">
                <h1>숙소 상세정보</h1>
            </div>
            
            <div class="stay-detail-content">
                <!-- 숙소 상세 정보가 여기에 렌더링됩니다 -->
            </div>
        </div>
    </main>
</body>
</html>
