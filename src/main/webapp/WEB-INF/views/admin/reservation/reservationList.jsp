<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0" />
  <title>예약관리 - Stay Folio Admin</title>

  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common.css" />
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin/member/memberList.css" />
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
</head>
<body>
  <div class="admin-container">
    <!-- 좌측 사이드바 -->
    <aside class="admin-sidebar">
      <div class="admin-logo">
        <h1 class="logo-text">STAY<br/>FOLIO<br/> <span class="admin-text">ADMIN</span></h1>
      </div>

      <nav class="admin-nav">
        <ul>
          <li><a href="/admin/dashboard" class="nav-item">대시보드</a></li>
          <li><a href="/admin/reservation/list" class="nav-item active">예약관리</a></li>
          <li><a href="/admin/stay/staylist" class="nav-item">숙소관리</a></li>
          <li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
          <li><a href="/admin/dashboard#category-section" class="nav-item">페이지관리</a></li>
        </ul>
      </nav>
    </aside>

    <!-- 우측 컨텐츠 -->
    <main class="admin-main">
      <div class="admin-header">
        <div class="header-content">
          <div class="header-left">
            <h2 class="page-title">예약관리</h2>
            <p class="page-subtitle">예약 내역을 조회하고 관리합니다.</p>
          </div>
        </div>
      </div>

      <!-- 필터 영역 -->
      <form method="get" action="/admin/reservation/list" class="search-form-container" id="search-form">
        <div class="search-filter-section">
          <div class="filter-container" style="gap:8px;display:flex;flex-wrap:wrap;align-items:center;">
            <select name="status" class="member-filter">
              <option value="" ${empty cri.status ? 'selected' : ''}>전체</option>
              <option value="a" ${cri.status == 'a' ? 'selected' : ''}>예약확정</option>
              <option value="b" ${cri .status == 'b' ? 'selected' : ''}>체크인</option>
              <option value="c" ${cri.status == 'c' ? 'selected' : ''}>체크아웃</option>
              <option value="d" ${cri.status == 'd' ? 'selected' : ''}>예약취소</option>
            </select>
            <input type="text" name="keyword" value="${cri.keyword}" placeholder="숙소명/회원명/전화번호" class="search-input" />
            <button class="search-btn" id="search-btn">검색</button>
            <button type="button" class="reset-btn" id="reset-btn">초기화</button>
          </div>
        </div>
      </form>

      <div class="admin-content">
        <div class="room-table-container">
          <table class="room-table">
            <thead>
              <tr>
                <th>번호</th>
                <th>예약번호</th>
                <th>숙소명</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>체크인</th>
                <th>체크아웃</th>
                <th>상태</th>
                <th>상세</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach var="r" items="${reservationList}" varStatus="st">
                <tr>
                  <td>${pageMaker.total - ((cri.page - 1) * cri.perPageNum) - st.index}</td>
                  <td>${r.srId}</td>
                  <td>${r.siName}</td>
                  <td>${r.srName}</td>
                  <td>${r.srPhone}</td>
                  <td><fmt:formatDate value="${r.srCheckin}" pattern="yyyy-MM-dd"/></td>
                  <td><fmt:formatDate value="${r.srCheckout}" pattern="yyyy-MM-dd"/></td>
                  <td>
                    <c:choose>
                      <c:when test="${r.srStatus == 'a'}">예약확정</c:when>
                      <c:when test="${r.srStatus == 'b'}">체크인</c:when>
                      <c:when test="${r.srStatus == 'c'}">체크아웃</c:when>
                      <c:when test="${r.srStatus == 'd'}">예약취소</c:when>
                      <c:otherwise>${r.srStatus}</c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <!-- TODO: 상세 페이지 구현 후 링크 연결 -->
                    <span class="btn" style="pointer-events:none;opacity:.6;">보기</span>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>

        <!-- 페이지네이션 -->
        <div class="pagination">
          <c:if test="${not empty pageMaker && pageMaker.prev}">
            <a href="?page=${pageMaker.startPage - 1}&status=${cri.status}&keyword=${cri.keyword}">&laquo;</a>
          </c:if>
          <c:forEach var="i" begin="${pageMaker.startPage}" end="${pageMaker.endPage}">
            <c:choose>
              <c:when test="${i == cri.page}">
                <a class="active" href="?page=${i}&status=${cri.status}&keyword=${cri.keyword}">${i}</a>
              </c:when>
              <c:otherwise>
                <a href="?page=${i}&status=${cri.status}&keyword=${cri.keyword}">${i}</a>
              </c:otherwise>
            </c:choose>
          </c:forEach>
          <c:if test="${pageMaker.next}">
            <a href="?page=${pageMaker.endPage + 1}&status=${cri.status}&keyword=${cri.keyword}">&raquo;</a>
          </c:if>
        </div>
      </div>
    </main>
  </div>

  <script>
    document.getElementById('reset-btn').addEventListener('click', function() {
      const form = document.getElementById('search-form');
      form.querySelector("select[name='status']").value = "";
      form.querySelector("input[name='keyword']").value = "";
      form.submit();
    });
  </script>
</body>
</html>
