<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>비회원 로그인 - STAY FOLIO</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/common.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/header.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/login/login.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  </head>
  <body>
    <!-- Header Include -->
    <jsp:include page="../includes/header.jsp" />
    <div class="login-page">
      <h2 class="login-title">LOGIN</h2>
      <p class="login-subtitle">비회원 로그인</p>

      <form class="login-form">
        <div class="form-group">
          <label for="username">예약자 성명</label>
          <input
            type="text"
            id="username"
            placeholder="예약자 성명을 입력해주세요."
          />
          <p class="error-message" style="display: none">
            예약자 성명을 입력해주세요.
          </p>
        </div>

        <div class="form-group">
          <label for="password">예약 번호</label>
          <input
            type="password"
            id="password"
            placeholder="예약 번호를 입력해주세요."
          />
        </div>

        <button type="submit" class="btn-login">예약 조회</button>
        <button type="button" class="btn-join">로그인</button>
        <button type="button" class="btn-join">신규 회원 가입</button>
      </form>
      <div class="modal-overlay" id="commonModal">
        <div class="modal-content">
          <p class="modal-message">
            올바른 예약자 성명과<br />
            예약 번호를 입력해주세요.
          </p>
          <div class="modal-buttons">
            <button class="btn btn-confirm" onclick="closeModal()">확인</button>
          </div>
        </div>
      </div>
    </div>
  </body>
</html>

<script>
  function guestCheck(event) {
    event.preventDefault();

    const userName = $("#username").val().trim();
    const password = $("#password").val().trim();

    if (!userName || !password) {
      openModal();
    }
  }
  function openModal() {
    document.getElementById("commonModal").style.display = "flex";
  }

  function closeModal() {
    document.getElementById("commonModal").style.display = "none";
  }
  $(document).ready(function () {
    $(".login-form").on("submit", guestCheck);
  });
</script>
