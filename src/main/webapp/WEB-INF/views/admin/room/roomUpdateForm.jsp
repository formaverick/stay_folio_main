<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>객실 수정 - STAY FOLIO</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomRegister.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
	<div class="admin-container">
		<aside class="admin-sidebar">
			<div class="admin-logo">
				<div class="logo-text">
					STAY<br />FOLIO
				</div>
				<div class="admin-text">ADMIN</div>
			</div>
			<nav class="admin-nav">
				<ul>
					<li><a href="/admin/dashboard" class="nav-item">대시보드</a></li>
					<li><a href="/admin/reservation" class="nav-item">예약관리</a></li>
					<li><a href="/admin/stay/staylist" class="nav-item active">숙소관리</a></li>
					<li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
					<li><a href="/admin/dashboard#category-section" class="nav-item">페이지관리</a></li>
				</ul>
			</nav>
		</aside>

		<main class="admin-main">
			<div class="admin-header">
				<div class="header-content">
					<div class="header-left">
						<h1 class="page-title">객실 수정</h1>
						<p class="page-subtitle">객실 정보를 수정합니다.</p>
					</div>
					<div class="header-right">
						<a href="/admin/room/detail?siId=${siId}&riId=${room.riId}"
							class="btn-cancel">돌아가기</a>
					</div>
				</div>
			</div>

			<div class="register-form-container">
				<form action="${pageContext.request.contextPath}/admin/rooms/update" method="post"
					enctype="multipart/form-data">
					<div class="register-form">
						<section class="form-section">
							<h2 class="section-title">기본 정보</h2>
							<div class="form-grid">
								<div class="form-group">
									<label class="form-label" for="riName">객실 이름</label> <input
										type="text" name="riName" value="${room.riName}" id="riName"
										required class="form-input" placeholder="객실 이름을 입력해주세요." />
								</div>
								<div class="form-group">
									<label class="form-label" for="riType">객실 형태</label> <select
										name="riType" id="riType" class="form-select" required>
										<option value="">-- 객실 형태를 선택하세요 --</option>
										<option value="a" <c:if test="${room.riType == 'a'}">selected</c:if>>기본형</option>
										<option value="b" <c:if test="${room.riType == 'b'}">selected</c:if>>독채형</option>
										<option value="c" <c:if test="${room.riType == 'c'}">selected</c:if>>원룸형</option>
										<option value="d" <c:if test="${room.riType == 'd'}">selected</c:if>>도미토리</option>
										<option value="e" <c:if test="${room.riType == 'e'}">selected</c:if>>복층형</option>
									</select>
								</div>
							</div>

							<div class="form-group full-width">
								<label for="riDesc" class="form-label">객실 설명</label>
								<textarea class="form-textarea" name="riDesc" id="riDesc"
									rows="3" placeholder="객실 설명을 입력해주세요.(500자 이내)">${room.riDesc}</textarea>
							</div>

							<div class="form-grid">
								<div class="form-group">
									<label class="form-label">기준 인원</label><input type="number"
										name="riPerson" id="riPerson" required class="form-input"
										value="${room.riPerson}" min="1" required />
								</div>
								<div class="form-group">
									<label class="form-label">최대 인원</label><input type="number"
										name="riMaxperson" id="riMaxperson" required
										class="form-input" value="${room.riMaxperson}" min="1"
										required />
								</div>

								<div class="form-group">
									<label class="form-label" for="riArea">면적(m²)</label> <input
										type="number" id="riArea" name="riArea" class="form-input"
										step="0.01" min="0" value="${room.riArea}" />
								</div>
								<div class="form-group">
									<label class="form-label" for="riPrice">기본 가격</label> <input
										type="number" id="riPrice" name="riPrice"
										value="${room.riPrice}" class="form-input" min="0" required />
								</div>
								<div class="form-group">
									<label class="form-label" for="riBed">침대 종류</label> <input
										type="text" id="riBed" name="riBed" value="${room.riBed}"
										class="form-input" maxlength="30" />
								</div>
								<div class="form-group">
									<label class="form-label" for="riBedcnt">침대 개수</label> <input
										type="number" id="riBedcnt" name="riBedcnt" class="form-input"
										min="0" value="${room.riBedcnt}" />
								</div>
								<div class="form-group">
									<label class="form-label" for="riBedroom">침실 수</label> <input
										type="number" id="riBedroom" name="riBedroom"
										class="form-input" value="${room.riBedroom}" />
								</div>
								<div class="form-group">
									<label class="form-label" for="riBathroom">욕실 수</label> <input
										type="number" id="riBathroom" name="riBathroom"
										class="form-input" value="${room.riBathroom}" />
								</div>
							</div>

							<div class="form-group full-width">
								<label class="form-label">편의시설 선택</label>
								<div class="amenities-grid"
									style="display: flex; flex-wrap: wrap; gap: 12px;">
									<c:forEach var="fac" items="${allFacilities}">
										<label class="amenity-item"
											style="display: flex; align-items: center; gap: 6px;">
											<input type="checkbox" name="facilityIds" value="${fac.fiId}"
											<c:forEach var="id" items="${selectedFacilityIds}">
												<c:if test="${id == fac.fiId}">checked</c:if>
											</c:forEach> />
											${fac.fiName}
										</label>
									</c:forEach>
								</div>
							</div>

							<div class="form-group full-width">
								<label class="form-label">어메니티 선택</label>
								<div class="amenities-grid"
									style="display: flex; flex-wrap: wrap; gap: 12px;">
									<c:forEach var="ame" items="${allAmenities}">
										<label class="amenity-item"
											style="display: flex; align-items: center; gap: 6px;">
											<input type="checkbox" name="amenityIds" value="${ame.aiIdx}"
											<c:forEach var="id" items="${selectedAmenityIds}">
												<c:if test="${id == ame.aiIdx}">checked</c:if>
											</c:forEach> />
											${ame.raName}
										</label>
									</c:forEach>
								</div>
							</div>

							<div class="form-group full-width">
								<label class="form-label">게시 여부</label>
								<div class="amenities-grid"
									style="display: flex; flex-direction: column; gap: 12px;">
									<div class="form-row"
										style="display: flex; align-items: center; gap: 20px;">
										<label><input type="radio" name="riShow" value="1"
											<c:if test="${room.riShow == '1'}">checked</c:if>> 게시</label>
										<label><input type="radio" name="riShow" value="0"
											<c:if test="${room.riShow == '0'}">checked</c:if>>
											미게시</label>
									</div>
								</div>
							</div>

							<section class="form-section">
								<h2 class="section-title">이미지 수정</h2>
								<div class="form-group full-width">
									<div class="simple-upload-container">
										<div class="additional-images-grid">
											<c:forEach var="i" begin="0" end="11">
												<c:set var="photo" value="${photoMap[i]}" />
												<div class="file-upload-wrapper"
													style="display: grid; grid-template-columns: 120px 1fr; align-items: center; gap: 20px; margin-bottom: 20px;">
													<c:choose>
														<c:when test="${not empty photo}">
															<img src="${s3BaseUrl}${photo.spUrl}" width="120"
																class="preview" />
														</c:when>
														<c:otherwise>
															<span style="color: gray;">등록된 이미지 없음</span>
														</c:otherwise>
													</c:choose>
													<div
														style="display: flex; flex-direction: column; gap: 8px;">
														<label for="image-${i}" class="file-upload-label">
															<span class="file-icon"><i class="ph ph-folder"></i></span>
															<span class="file-text"> <c:choose>
																	<c:when test="${i == 0}">대표 이미지</c:when>
																	<c:when test="${i le 2}">추가 이미지 ${i}</c:when>
																	<c:when test="${i le 5}">주요 특징 이미지 ${i-2}</c:when>
																	<c:when test="${i le 8}">특징1 이미지 ${i-5}</c:when>
																	<c:otherwise>특징2 이미지 ${i-8}</c:otherwise>
																</c:choose>
														</span>
														</label> <input type="file" class="file-input" id="image-${i}"
															name="replaceImage_${i}" data-spidx="${i}"
															accept="image/*" />
													</div>
												</div>
											</c:forEach>
										</div>
									</div>
								</div>
								<script>
									document
											.addEventListener(
													'DOMContentLoaded',
													function() {
														document
																.querySelectorAll(
																		'.file-input')
																.forEach(
																		function(
																				input) {
																			input
																					.addEventListener(
																							'change',
																							function() {
																								const label = input.previousElementSibling;
																								const fileName = input.files.length > 0 ? input.files[0].name
																										: '선택된 파일 없음';
																								const fileText = label
																										.querySelector('.file-text');
																								if (fileText)
																									fileText.textContent = fileName;
																							});
																		});
													});
								</script>
							</section>


							<!-- 고정값 -->
							<input type="hidden" name="siId" value="${siId}" />
							<input type="hidden" name="riId" value="${room.riId}" />

							<div class="form-actions">
								<button type="submit" class="btn btn-primary">객실 정보 수정</button>
							</div>
						</section>
					</div>
				</form>
			</div>
		</main>
	</div>
</body>
</html>