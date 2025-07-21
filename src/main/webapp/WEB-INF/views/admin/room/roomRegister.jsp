<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>객실 등록 - STAY FOLIO</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/roomRegister.css" />
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/admin/roomRegister.js"></script>
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
                    <li><a href="roomList.jsp">객실 관리</a></li>
                    <li><a href="roomRegister.jsp" class="active">객실 등록</a></li>
                    <li><a href="#">예약 관리</a></li>
                    <li><a href="#">회원 관리</a></li>
                </ul>
            </nav>
        </aside>
        
        <main class="admin-main">
            <div class="admin-header">
                <h2>새 객실 등록</h2>
                <div class="admin-actions">
                    <a href="roomList.jsp" class="btn btn-secondary">목록으로 돌아가기</a>
                </div>
            </div>
            
            <div class="room-register-container">
                <form class="room-register-form" id="roomRegisterForm">
                    <div class="form-section">
                        <h3>기본 정보</h3>
                        <div class="form-row">
                            <div class="input-group">
                                <label for="roomName">객실명</label>
                                <input type="text" id="roomName" name="roomName" placeholder="객실명을 입력하세요" required>
                                <span class="error-message" id="roomNameError"></span>
                            </div>
                            <div class="input-group">
                                <label for="location">위치</label>
                                <input type="text" id="location" name="location" placeholder="위치를 입력하세요" required>
                                <span class="error-message" id="locationError"></span>
                            </div>
                        </div>
                        
                        <div class="form-row">
                            <div class="input-group">
                                <label for="price">가격 (원)</label>
                                <input type="number" id="price" name="price" placeholder="가격을 입력하세요" required>
                                <span class="error-message" id="priceError"></span>
                            </div>
                            <div class="input-group">
                                <label for="maxGuests">최대 인원</label>
                                <input type="number" id="maxGuests" name="maxGuests" placeholder="최대 인원을 입력하세요" required>
                                <span class="error-message" id="maxGuestsError"></span>
                            </div>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3>상세 정보</h3>
                        <div class="input-group">
                            <label for="description">객실 설명</label>
                            <textarea id="description" name="description" rows="5" placeholder="객실에 대한 상세 설명을 입력하세요"></textarea>
                        </div>
                        
                        <div class="input-group">
                            <label for="amenities">편의시설</label>
                            <textarea id="amenities" name="amenities" rows="3" placeholder="편의시설을 입력하세요 (예: WiFi, 에어컨, 주차장 등)"></textarea>
                        </div>
                    </div>
                    
                    <div class="form-section">
                        <h3>이미지 업로드</h3>
                        <div class="input-group">
                            <label for="images">객실 이미지</label>
                            <input type="file" id="images" name="images" multiple accept="image/*">
                            <div class="image-preview" id="imagePreview"></div>
                        </div>
                    </div>
                    
                    <div class="form-actions">
                        <button type="button" class="btn btn-secondary" onclick="history.back()">취소</button>
                        <button type="submit" class="btn btn-primary">객실 등록</button>
                    </div>
                </form>
            </div>
        </main>
    </div>
</body>
</html>
