<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>비밀번호 변경 - STAY FOLIO</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/header.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login/signup.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<jsp:include page="../includes/header.jsp" />

	<main class="signup-main">
		<div class="signup-page">
			<h2 class="signup-title">PASSWORD</h2>
			<p class="signup-subtitle">비밀번호 변경</p>

			<div class="signup-section active">
				<form class="signup-form" id="password-form" method="post"
					action="${pageContext.request.contextPath}/mypage/member/password">
					<c:if test="${not empty _csrf}">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</c:if>

					<div class="form-group">
						<label for="currentPw">현재 비밀번호</label>
						<div class="pw-field">
							<input type="password" id="currentPw" name="currentPw" required
								style="padding-right: 44px;" placeholder="비밀번호를 입력해주세요." />
							<button type="button" class="pw-eye" data-target="#currentPw"
								aria-label="비밀번호 표시/숨기기">
								<i class="ph ph-eye-slash"></i>
							</button>
						</div>
					</div>

					<div class="form-group">
						<label for="newPw">새 비밀번호</label>
						<div class="pw-field">
							<input type="password" id="newPw" name="newPw" minlength="8"
								placeholder="8자 이상, 영문/숫자/특수문자 포함 권장" required
								style="padding-right: 44px;" />
							<button type="button" class="pw-eye" data-target="#newPw"
								aria-label="비밀번호 표시/숨기기">
								<i class="ph ph-eye-slash"></i>
							</button>
						</div>
					</div>

					<div class="form-group">
						<label for="newPw2">새 비밀번호 확인</label>
						<div class="pw-field">
							<input type="password" id="newPw2" name="newPw2" minlength="8"
								required style="padding-right: 44px;"
								placeholder="비밀번호 확인이 필요합니다." />
							<button type="button" class="pw-eye" data-target="#newPw2"
								aria-label="비밀번호 표시/숨기기">
								<i class="ph ph-eye-slash"></i>
							</button>
						</div>
					</div>

					<div class="button-group" style="margin-top: 24px;">
						<button type="submit" class="btn-signup">변경</button>
						<button type="button" class="btn-login" onclick="history.back()">취소</button>
					</div>
				</form>
			</div>

		</div>
	</main>

	<%-- 서버에서 온 플래시 메시지 전달 (있으면 data-alert로 넣음) --%>
	<c:if test="${not empty alertMsg}">
		<div id="flash" data-alert="<c:out value='${alertMsg}'/>"></div>
	</c:if>

	<%-- 공용 모달 --%>
	<div class="modal-overlay" id="commonModal" style="display: none;">
		<div class="modal-content">
			<p class="modal-message"></p>
			<div class="modal-buttons">
				<button type="button" class="btn btn-cancel" id="modalOkBtn">확인</button>
			</div>
		</div>
	</div>

	<script>
		// ----- 모달 열고/닫기 -----
		function openModal(msg) {
			var modal = document.getElementById('commonModal');
			if (!modal)
				return;
			var box = modal.querySelector('.modal-message');
			if (box)
				box.textContent = msg || '';
			modal.style.display = 'flex';
		}
		function closeModal() {
			var modal = document.getElementById('commonModal');
			if (modal)
				modal.style.display = 'none';
		}
		document.addEventListener('click', function(e) {
			if (e.target && e.target.id === 'modalOkBtn')
				closeModal();
			// 오버레이 바깥 클릭 닫기 (선택)
			if (e.target && e.target.id === 'commonModal')
				closeModal();
		});

		// ----- 서버 플래시(alertMsg) 모달로 표시 -----
		(function() {
			var el = document.getElementById('flash');
			if (!el)
				return;
			var msg = el.getAttribute('data-alert') || '';
			if (msg)
				openModal(msg);
		})();

		// ----- 폼 검증(모달로) -----
		$("#password-form").on("submit", function() {
			const cur = $("#currentPw").val().trim();
			const a = $("#newPw").val().trim();
			const b = $("#newPw2").val().trim();

			if (!cur || !a || !b) {
				openModal("모든 항목을 입력하세요.");
				return false;
			}
			if (a !== b) {
				openModal("새 비밀번호 확인이 일치하지 않습니다.");
				return false;
			}
			return true;
		});

		// ----- 비밀번호 표시 아이콘 토글 -----
		$(document).on(
				"click",
				".pw-eye",
				function() {
					const target = $(this).data("target");
					const $f = $(target);
					const isText = $f.attr("type") === "text";
					$f.attr("type", isText ? "password" : "text");
					$(this).find("i").attr("class",
							isText ? "ph ph-eye-slash" : "ph ph-eye");
				});
	</script>

</body>
</html>
