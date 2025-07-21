<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실 상세 - STAY FOLIO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/roomDetail.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/admin/roomDetail.js"></script>
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
                <h2>객실 상세 정보</h2>
                <div class="admin-actions">
                    <button class="btn btn-primary" id="editBtn">수정</button>
                    <button class="btn btn-danger" id="deleteBtn">삭제</button>
                    <a href="roomList.jsp" class="btn btn-secondary">목록으로 돌아가기</a>
                </div>
            </div>
            
            <div class="room-detail-container">
                <div class="room-images">
                    <div class="main-image">
                        <img src="" alt="객실 이미지" id="mainImage">
                    </div>
                    <div class="thumbnail-images" id="thumbnailImages">
                        <!-- 썸네일 이미지들이 여기에 렌더링됩니다 -->
                    </div>
                </div>
                
                <div class="room-info">
                    <div class="info-section">
                        <h3>기본 정보</h3>
                        <div class="info-grid">
                            <div class="info-item">
                                <label>객실명:</label>
                                <span id="roomName">-</span>
                            </div>
                            <div class="info-item">
                                <label>위치:</label>
                                <span id="location">-</span>
                            </div>
                            <div class="info-item">
                                <label>가격:</label>
                                <span id="price">-</span>
                            </div>
                            <div class="info-item">
                                <label>최대 인원:</label>
                                <span id="maxGuests">-</span>
                            </div>
                            <div class="info-item">
                                <label>등록일:</label>
                                <span id="createdDate">-</span>
                            </div>
                            <div class="info-item">
                                <label>상태:</label>
                                <span id="status">-</span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h3>객실 설명</h3>
                        <div class="description" id="description">
                            <!-- 객실 설명이 여기에 렌더링됩니다 -->
                        </div>
                    </div>
                    
                    <div class="info-section">
                        <h3>편의시설</h3>
                        <div class="amenities" id="amenities">
                            <!-- 편의시설이 여기에 렌더링됩니다 -->
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</body>
</html>
