<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>로그인 - STAY FOLIO</title>
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
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/login/login.js"></script>
  </head>
  <body>
    <!-- Header Include -->
    <jsp:include page="../includes/header.jsp" />

    <main class="login-main">
      <div class="login-page">
        <h2 class="login-title">LOGIN</h2>
        <p class="login-subtitle">로그인</p>

        <form class="login-form" action="/login" method="post">
          <input
            type="hidden"
            name="${_csrf.parameterName}"
            value="${_csrf.token}"
          />
          <div class="form-group">
            <label for="username">아이디</label>
            <input
              type="text"
              id="username"
              name="username"
              value="${not empty param.username
						? param.username
						: (not empty requestScope['SPRING_SECURITY_LAST_USERNAME']
							? requestScope['SPRING_SECURITY_LAST_USERNAME']
							: (not empty sessionScope['SPRING_SECURITY_LAST_USERNAME']
								? sessionScope['SPRING_SECURITY_LAST_USERNAME']
								: ''))}"
              placeholder="아이디를 입력해주세요."
            />
            <p class="error-message" style="display: none">
              아이디 형식이 올바르지 않습니다.<br />이메일 기반이어야 합니다.
            </p>
          </div>

          <div class="form-group">
            <label for="password">비밀번호</label>
            <input
              type="password"
              id="password"
              name="password"
              placeholder="비밀번호를 입력해주세요."
            />
            <p class="error-message" style="display: none">
              8자 이상으로 입력해주세요<br />영문, 숫자, 특수문자를 조합하여
              입력해 주세요.
            </p>
          </div>

          <button type="submit" class="btn-login">LOGIN</button>
          <button type="button" class="btn-kakao">
            카카오로 3초 만에 시작하기
          </button>
          <button
            type="button"
            class="btn-join"
            onclick="location.href='/register'"
          >
            신규 회원 가입
          </button>
        </form>
      </div>
      <!-- 로그인 끝 -->

      <!-- 모달 시작 -->
      <div
        class="modal-overlay"
        id="commonModal"
        style="display:${empty error ? 'none' : 'flex'};"
      >
        <div class="modal-content">
          <p class="modal-message">${error }</p>
          <div class="modal-buttons">
            <button type="button" class="btn btn-cancel" id="modalCloseBtn">
              확인
            </button>
          </div>
        </div>
      </div>
      <!-- 모달 끝 -->
    </main>
  </body>
</html>
