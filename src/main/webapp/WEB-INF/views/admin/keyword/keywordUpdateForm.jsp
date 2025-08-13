<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>키워드 수정- STAY FOLIO ADMIN</title>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/common.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/room/roomRegister.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
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
              <a href="/admin/stay/staylist" class="nav-item">숙소관리</a>
            </li>
            <li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
            <li>
              <a
                href="/admin/dashboard#category-section"
                class="nav-item active"
                >페이지관리</a
              >
            </li>
          </ul>
        </nav>
      </aside>

      <main class="admin-main">
        <div class="admin-header">
          <div class="header-content">
            <div class="header-left">
              <h1 class="page-title">카테고리 수정</h1>
              <p class="page-subtitle">등록된 카테고리 정보를 수정합니다.</p>
            </div>
            <div class="header-right">
              <div style="display: inline-block">
                <a
                  href="${pageContext.request.contextPath}/admin/keyword/detail?rcId=${keyword.rcId}"
                  class="btn-save"
                  >저장하기</a
                >
              </div>
            </div>
          </div>
        </div>

        <div class="register-form-container">
          <div class="register-form">
            <section class="form-section">
              <c:if test="${not empty message}">
                <script>
                  alert("${message}");
                </script>
              </c:if>
              <form
                action="/admin/keyword/update"
                method="post"
                enctype="multipart/form-data"
              >
                <div class="form-field-group">
                  <label class="form-label">검색 키워드</label>
                  <input
                    type="text"
                    name="rcName"
                    value="${keyword.rcName}"
                    id="rcName"
                    required
                    class="form-input"
                  />
                </div>

                <input type="hidden" name="rcId" value="${keyword.rcId}" />

                <div class="form-actions" style="margin-top: 20px">
                  <button type="submit" id="stay-submit-btn" class="btn-save">
                    수정하기
                  </button>
                </div>
              </form>
            </section>

            <section class="form-section">
              <div class="room-table-container">
                <table class="room-table">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>숙소명</th>
                      <th>지역</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach
                      var="stay"
                      items="${categoryStay}"
                      varStatus="loop"
                    >
                      <tr>
                        <td>${stay.siId}</td>
                        <td>${stay.siName}</td>
                        <td>${stay.siLoca}</td>
                        <td>
                          <form
                            action="/admin/keyword/delete"
                            method="post"
                            style="display: inline-block; margin-right: 1rem"
                          >
                            <input
                              type="hidden"
                              name="rcId"
                              value="${keyword.rcId}"
                            />
                            <input
                              type="hidden"
                              name="siId"
                              value="${stay.siId}"
                            />
                            <button type="submit" class="btn-edit">삭제</button>
                          </form>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </section>

            <section class="form-section">
              <div class="room-table-container">
                <table class="room-table">
                  <thead>
                    <tr>
                      <th>번호</th>
                      <th>숙소명</th>
                      <th>지역</th>
                      <th></th>
                    </tr>
                  </thead>
                  <tbody>
                    <c:forEach var="stay" items="${stayList}" varStatus="loop">
                      <tr>
                        <td>${stay.siId}</td>
                        <td>${stay.siName}</td>
                        <td>${stay.siLoca}</td>
                        <td>
                          <form
                            action="/admin/keyword/insert"
                            method="post"
                            style="display: inline-block; margin-right: 1rem"
                          >
                            <input
                              type="hidden"
                              name="rcId"
                              value="${keyword.rcId}"
                            />
                            <input
                              type="hidden"
                              name="siId"
                              value="${stay.siId}"
                            />
                            <button type="submit" class="btn-edit">
                              + 추가
                            </button>
                          </form>
                        </td>
                      </tr>
                    </c:forEach>
                  </tbody>
                </table>
              </div>
            </section>
          </div>
        </div>
      </main>
    </div>
  </body>
</html>
