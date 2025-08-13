<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>회원가입 - STAY FOLIO</title>
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
      href="${pageContext.request.contextPath}/resources/css/login/signup.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Custom JS -->
    <script src="${pageContext.request.contextPath}/resources/js/login/signup.js"></script>
  </head>
  <body>
    <!-- Header Include -->
    <jsp:include page="../includes/header.jsp" />

    <!-- 회원가입 -->
    <main class="signup-main">
      <div class="signup-page">
        <h2 class="signup-title">JOIN</h2>
        <p class="signup-subtitle">회원가입</p>

        <!-- 회원가입 통합 폼 -->
        <div class="signup-section active" id="combined-section">
          <form
            class="signup-form"
            id="combined-form"
            method="post"
            action="${pageContext.request.contextPath}/register"
          >
            <div class="form-group">
              <label for="email">이메일</label>
              <input
                type="email"
                id="email"
                name="miId"
                placeholder="이메일을 입력해주세요."
                required
              />
              <p class="error-message"></p>
            </div>

            <div class="form-group">
              <label for="password">비밀번호</label>
              <input
                type="password"
                id="password"
                name="miPw"
                placeholder="비밀번호를 입력해주세요."
                required
              />
              <p class="error-message"></p>
            </div>

            <div class="form-group">
              <label for="passwordConfirm">비밀번호 확인</label>
              <input
                type="password"
                id="passwordConfirm"
                placeholder="비밀번호를 다시 입력해주세요."
                required
              />
              <p class="error-message"></p>
            </div>

            <div class="form-group">
              <label for="name">이름</label>
              <input
                type="text"
                id="name"
                name="miName"
                placeholder="이름을 입력해주세요."
                required
              />
              <p class="error-message"></p>
            </div>

            <div class="form-group">
              <label for="phone">전화번호</label>
              <input
                type="tel"
                id="phone"
                name="miPhone"
                placeholder="전화번호를 입력해주세요."
                required
              />
              <p class="error-message"></p>
            </div>

            <hr class="hr" />
            <div class="checkbox-group">
              <label
                ><input type="checkbox" id="agreeAll" /> 사용자 약관 전체
                동의</label
              >
            </div>
            <hr />
            <div class="checkbox-group toggle-box required">
              <div class="toggle-header">
                <input type="checkbox" id="terms1" />
                <label for="terms1">(필수) 서비스 이용 약관 동의</label>
                <span class="toggle-icon">〉</span>
              </div>
              <div class="terms-box">
                <div class="terms-content">
                  <p>
                    <strong>최종 갱신일: 2023. 7. 19.</strong>
                  </p>
                  <p>
                    본 약관은 스테이폴리오에서 제공하는 모든 서비스 이용에
                    적용됩니다.
                  </p>
                  <p>
                    <strong>제1조 (목적)</strong><br />이 약관은 회사가 제공하는
                    서비스 이용자의 권리·의무 및 책임사항을 규정합니다.
                  </p>
                  <p>
                    <strong>제2조 (정의)</strong><br />"플랫폼"이란 회사가
                    운영하는 온라인 서비스 일체를 말합니다.
                  </p>
                </div>
              </div>
            </div>

            <div class="checkbox-group toggle-box required">
              <div class="toggle-header">
                <input type="checkbox" id="terms2" />
                <label for="terms2">(필수) 개인정보 수집/이용 동의</label>
                <span class="toggle-icon">〉</span>
              </div>
              <div class="terms-box">
                <div class="terms-content">
                  <p>
                    <strong>개인정보 수집 및 이용 안내</strong>
                  </p>
                  <p>
                    1. 수집항목: 성명, 연락처, 이메일, 생년월일, 성별, 결제정보
                  </p>
                  <p>
                    2. 수집목적: 회원관리, 서비스 제공, 고객상담, 마케팅 및 광고
                    활용
                  </p>
                  <p>3. 보유기간: 회원 탈퇴 시 또는 동의 철회 시까지</p>
                  <p>4. 동의 거부 시 서비스 이용이 제한될 수 있습니다.</p>
                </div>
              </div>
            </div>

            <div class="checkbox-group toggle-box required">
              <div class="toggle-header">
                <input type="checkbox" id="terms3" />
                <label for="terms3">(필수) 만 14세 이상 확인</label>
                <span class="toggle-icon">〉</span>
              </div>
              <div class="terms-box">
                <div class="terms-content">
                  <p>
                    본 서비스는 만 14세 미만의 아동에게는 제공되지 않습니다.
                  </p>
                  <p>
                    만 14세 미만 아동의 개인정보 수집 시 법정대리인의 동의가
                    필요합니다.
                  </p>
                  <p>
                    만 14세 미만 아동이 본 서비스를 이용하기 위해서는
                    법정대리인의 동의가 필요합니다.
                  </p>
                </div>
              </div>
            </div>

            <div class="checkbox-group toggle-box">
              <div class="toggle-header">
                <input type="checkbox" id="terms4" name="miIsad" value="1" />
                <label for="terms4"
                  >(선택) 쿠폰, 이벤트 등 혜택 알림 동의</label
                >
                <span class="toggle-icon">〉</span>
              </div>
              <div class="terms-box">
                <div class="terms-content">
                  <p>1. 수집항목: 이메일, 휴대전화번호</p>
                  <p>
                    2. 수집목적: 신규 서비스(제품) 개발 및 마케팅, 이벤트 및
                    광고성 정보 제공, 인구통계학적 특성에 따른 서비스 제공
                  </p>
                  <p>3. 보유기간: 회원 탈퇴 시 또는 동의 철회 시까지</p>
                  <p>4. 동의 거부 시에도 서비스 이용에는 제한이 없습니다.</p>
                </div>
              </div>
            </div>

            <div class="button-group">
              <button type="submit" class="btn-signup" id="signup-submit-btn">
                회원가입
              </button>
              <button
                type="button"
                class="btn-login"
                onclick="location.href='login.html'"
              >
                이미 계정이 있으신가요? 로그인
              </button>
            </div>
          </form>
        </div>
      </div>

      <!-- 모달 시작 -->
      <div class="modal-overlay" id="commonModal">
        <div class="modal-content">
          <p class="modal-message">필수 약관에 모두 동의해주세요.</p>
          <div class="modal-buttons">
            <button class="btn btn-cancel">확인</button>
          </div>
        </div>
      </div>
      <!-- 모달 끝 -->
    </main>
  </body>
</html>
