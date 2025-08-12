<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>객실 관리 - STAY FOLIO</title>
    <!-- CSS -->
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/common.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/room/roomRegister.css"
    />
    <!-- JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/admin/room/roomList.js"></script>
  </head>
  <body>
    <div class="admin-container">
      <!-- 사이드바 -->
      <aside class="admin-sidebar">
        <div class="admin-logo">
          <h1 class="logo-text">
            STAY<br />FOLIO<br />
            <span class="admin-text">ADMIN</span>
          </h1>
        </div>
        <nav class="admin-nav">
          <ul>
            <li><a href="/admin/dashboard" class="nav-item">대시보드</a></li>
            <li>
              <a href="/admin/reservation/list" class="nav-item">예약관리</a>
            </li>
            <li>
              <a href="/admin/stay/staylist" class="nav-item active"
                >숙소관리</a
              >
            </li>
            <li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
            <li>
              <a href="/admin/dashboard#category-section" class="nav-item"
                >페이지관리</a
              >
            </li>
          </ul>
        </nav>
      </aside>

      <!-- 메인 컨텐츠 -->
      <main class="admin-main">
        <!-- 헤더 -->
        <div class="admin-header">
          <div class="header-content">
            <div class="header-left">
              <h2 class="page-title">객실 관리</h2>
              <p class="page-subtitle">
                숙박업소의 객실을 관리하는 페이지입니다.
              </p>
            </div>
            <div class="header-right" style="display: flex; gap: 1rem">
              <form
                action="/admin/stay/detail"
                method="get"
                style="display: inline-block; margin-right: 1rem"
              >
                <input type="hidden" name="siId" value="${siId}" />
                <button type="submit" class="btn-save">숙소 상세</button>
              </form>
              <form action="/admin/rooms" method="get" style="display: inline">
                <input type="hidden" name="siId" value="${siId}" />
                <button type="submit" class="btn-save">
                  <span class="btn-icon">+</span> 객실 등록
                </button>
              </form>
            </div>
          </div>
        </div>

        <!-- 테이블 -->
        <div class="admin-content">
          <div class="room-table-container">
            <table class="room-table">
              <thead>
                <tr>
                  <th>객실 ID</th>
                  <th>객실명</th>
                  <th>형태</th>
                  <th>등록일자</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                <c:forEach var="room" items="${roomList}">
                  <tr>
                    <td>${room.riId}</td>
                    <td>${room.riName}</td>
                    <td>${room.riType}</td>
                    <td>${room.riDate.substring(0, 10)}</td>
                    <td>
                      <a
                        href="/admin/room/detail?siId=${room.siId}&riId=${room.riId}"
                        class="btn-edit"
                        >상세보기</a
                      >
                    </td>
                  </tr>
                </c:forEach>
              </tbody>
            </table>
          </div>
        </div>
      </main>
    </div>
  </body>
</html>
