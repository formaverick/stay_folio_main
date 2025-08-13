<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원정보 수정 - STAY FOLIO</title>
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
<script
	src="${pageContext.request.contextPath}/resources/js/mypage/memberEdit.js"></script>
</head>
<body>
	<jsp:include page="../includes/header.jsp" />

	<main class="signup-main">
		<div class="signup-page">
			<h2 class="signup-title">PROFILE</h2>
			<p class="signup-subtitle">회원정보 수정</p>

			<div class="signup-section active">
				<form class="signup-form" id="member-edit-form" method="post"
					action="${pageContext.request.contextPath}/mypage/member/update">
					<c:if test="${not empty _csrf}">
						<input type="hidden" name="${_csrf.parameterName}"
							value="${_csrf.token}" />
					</c:if>

					<!-- 이메일(아이디) -->
					<div class="form-group">
						<label for="email">이메일(아이디)</label> <input type="email" id="email"
							name="miId" value="${member.miId}" readonly />
					</div>

					<!-- 비밀번호: 읽기 전용 + 수정 버튼 -->
					<div class="form-group">
						<label for="passwordView">비밀번호</label> <input type="password"
							id="passwordView" value="********" disabled
							style="letter-spacing: .2em;" />
						<button type="button" class="btn-login" style="margin-top: 8px"
							onclick="location.href='${pageContext.request.contextPath}/mypage/member/password'">
							비밀번호 수정</button>
					</div>

					<!-- 이름 -->
					<div class="form-group">
						<label for="name">이름</label> <input type="text" id="name"
							name="miName" value="${member.miName}" required />
						<p class="error-message"></p>
					</div>

					<!-- 전화번호 -->
					<div class="form-group">
						<label for="phone">전화번호</label> <input type="tel" id="phone"
							name="miPhone" value="${member.miPhone}"
							placeholder="예) 010-1234-5678" required />
						<p class="error-message"></p>
					</div>

					<!-- 성별 -->
					<div class="form-group">
						<label>성별</label>
						<div style="display: flex; gap: 16px;">
							<label><input type="radio" name="miGender" value="M"
								<c:if test="${member.miGender == 'M'}">checked</c:if> /> 남성</label> <label><input
								type="radio" name="miGender" value="F"
								<c:if test="${member.miGender == 'F'}">checked</c:if> /> 여성</label> <label><input
								type="radio" name="miGender" value=""
								<c:if test="${empty member.miGender}">checked</c:if> /> 선택안함</label>
						</div>
					</div>

					<!-- 생년월일 (mi_birth 컬럼 타입이 VARCHAR2라면 그대로, DATE면 컨버전 필요) -->
					<div class="form-group">
						<label for="birth">생년월일</label> <input type="date" id="birth"
							name="miBirth" value="${member.miBirth}" />
					</div>

					<hr class="hr" />

					<!-- 광고 수신 동의 -->
					<div class="checkbox-group">
						<input type="hidden" name="_miIsad" value="on" /> <label>
							<input type="checkbox" id="isad" name="miIsad" value="true"
							<c:if test="${member.miIsad}">checked</c:if> /> (선택) 쿠폰/이벤트 등 혜택
							알림 동의
						</label>
					</div>

					<div class="button-group" style="margin-top: 24px;">
						<button type="submit" class="btn-signup" id="btn-save">저장</button>
						<button type="button" class="btn-login"
							onclick="location.href='${pageContext.request.contextPath}/mypage/reservations'">나가기</button>
					</div>
				</form>
			</div>
		</div>
	</main>

	<%-- 모달 메시지(우선순위: alertMsg > error) --%>
	<c:set var="modalMsg" value="${not empty alertMsg ? alertMsg : error}" />

	<!-- 모달 시작 -->
	<div class="modal-overlay" id="commonModal"
		style="display:${empty modalMsg ? 'none' : 'flex'};">
		<div class="modal-content">
			<p class="modal-message">
				<c:out value='${modalMsg}' />
			</p>
			<div class="modal-buttons">
				<button type="button" class="btn btn-cancel" id="modalOkBtn">확인</button>
			</div>
		</div>
	</div>
	<!-- 모달 끝 -->
	<script>
		(function() {
			var modal = document.getElementById('commonModal');
			if (!modal)
				return;

			// 확인 버튼으로 닫기
			var ok = document.getElementById('modalOkBtn');
			if (ok)
				ok.addEventListener('click', function() {
					modal.style.display = 'none';
				});

			// 바깥(오버레이) 클릭으로 닫기 (선택)
			modal.addEventListener('click', function(e) {
				if (e.target === modal)
					modal.style.display = 'none';
			});
		})();
	</script>
</body>
</html>
