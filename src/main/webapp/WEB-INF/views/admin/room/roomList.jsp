<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실 목록 관리 - STAY FOLIO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/roomList.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/admin/roomList.js"></script>
</head>
<body>
    <div class="admin-container">
        <aside class="admin-sidebar">
            <div class="admin-logo">
                <h1>STAY FOLIO</h1>
                <p>관리자</p>
            </div>
            <nav class="admin-nav">
                <ul>
                    <li><a href="roomList.jsp" class="active">객실 관리</a></li>
                    <li><a href="roomRegister.jsp">객실 등록</a></li>
                    <li><a href="#">예약 관리</a></li>
                    <li><a href="#">회원 관리</a></li>
                </ul>
            </nav>
        </aside>
        
        <main class="admin-main">
            <div class="admin-header">
                <h2>객실 목록 관리</h2>
                <div class="admin-actions">
                    <a href="roomRegister.jsp" class="btn btn-primary">새 객실 등록</a>
                    <a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-secondary">사이트로 이동</a>
                </div>
            </div>
            
            <div class="room-list-container">
                <div class="search-bar">
                    <input type="text" placeholder="객실명으로 검색..." id="searchInput">
                    <button type="button" id="searchBtn">검색</button>
                </div>
                
                <div class="room-table">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>객실명</th>
                                <th>위치</th>
                                <th>가격</th>
                                <th>상태</th>
                                <th>등록일</th>
                                <th>관리</th>
                            </tr>
                        </thead>
                        <tbody id="roomTableBody">
                            <!-- 객실 데이터가 여기에 렌더링됩니다 -->
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
