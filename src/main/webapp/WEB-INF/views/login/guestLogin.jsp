<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>	
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
				<label for="username">예약자 성명</label> <input type="text"
					id="username" placeholder="예약자 성명을 입력해주세요." />
				<p class="error-message" style="display: none">예약자 성명을 입력해주세요.</p>
			</div>

			<div class="form-group">
				<label for="srId">예약 번호</label>
				<div class="input-with-icon" style="position: relative">
					<input type="text" id="srId" name="srId"
						placeholder="YYYYMMDD-000123" inputmode="numeric"
						pattern="\d{8}-\d{6}" maxlength="15" required autocapitalize="off"
						autocomplete="one-time-code" style="padding-right: 40px" />
					<button type="button" aria-label="숨기기/보이기"
						onclick="toggleSrId(this)"
						style="position: absolute; right: 8px; top: 50%; transform: translateY(-50%); background: none; border: none; cursor: pointer;">
						<i class="ph-eye-slash"></i>
					</button>
				</div>
				<small>예) 20250811-000176</small>
			</div>

			<button type="submit" class="btn-login">예약 조회</button>
			<button type="button" class="btn-join">로그인</button>
			<button type="button" class="btn-join">신규 회원 가입</button>
		</form>
		<div class="modal-overlay" id="commonModal">
			<div class="modal-content">
				<p class="modal-message">
					올바른 예약자 성명과<br /> 예약 번호를 입력해주세요.
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
  // 예약번호 보기/숨기기 토글
  function toggleSrId(btn){
    const input = document.getElementById('srId');
    const isText = input.type === 'text';
    input.type = isText ? 'password' : 'text';
    btn.innerHTML = isText ? '<i class="ph-eye"></i>' : '<i class="ph-eye-slash"></i>';
  }

  // 예약번호 자동 하이픈
  document.addEventListener('DOMContentLoaded', () => {
    const srIdInput = document.getElementById('srId');
    srIdInput.addEventListener('input', e => {
      const v = e.target.value.replace(/[^\d]/g,'').slice(0,14);
      e.target.value = v.length > 8 ? v.slice(0,8) + '-' + v.slice(8) : v;
    });
  });

  // 모달 열기/닫기 (+ 메시지)
  function openModal(msg) {
    if (msg) document.querySelector('#commonModal .modal-message').innerHTML = msg;
    document.getElementById("commonModal").style.display = "flex";
  }
  function closeModal() {
    document.getElementById("commonModal").style.display = "none";
  }

  // 폼 제출 → JS로 검증하고 AJAX 조회
  $(document).ready(function () {
    $(".login-form").on("submit", function (e) {
      e.preventDefault();

      const srName = $("#username").val().trim();
      const srId   = $("#srId").val().trim();
      const re = /^\d{8}-\d{6}$/;

      if (!srName) return openModal("예약자 성명을 입력해주세요.");
      if (!re.test(srId)) return openModal("예약번호가 다릅니다.<br/>예) 20250811-000176");

      const token  = $('meta[name="_csrf"]').attr('content');
      const header = $('meta[name="_csrf_header"]').attr('content');
      const base   = "${pageContext.request.contextPath}";
      
      $.ajax({
        url: base + "/guest/reservation/find.json",
        method: "POST",
        data: { srId, srName },
        beforeSend: function(xhr){
          if (token && header) xhr.setRequestHeader(header, token);
        },
        success: function(res){
          if (res.code === "OK" && res.redirect) {
            window.location.href = base + res.redirect; // 성공 → 상세로 이동
          } else {
            // 코드별 커스텀 메시지
            if (res.code === "NOT_FOUND")      openModal("예약번호가 다릅니다.");
            else if (res.code === "NAME_MISMATCH") openModal("예약자 성명이 다릅니다.");
            else openModal(res.msg || "예약을 찾을 수 없습니다.");
          }
        },
        error: function(){
          openModal("잠시 후 다시 시도해주세요.");
        }
      });
    });
  });
</script>
