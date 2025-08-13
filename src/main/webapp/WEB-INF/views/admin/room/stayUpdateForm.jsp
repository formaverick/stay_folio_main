<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>숙소 수정 - STAY FOLIO ADMIN</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomRegister.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css">
<script src="https://unpkg.com/@phosphor-icons/web"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
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
					<li><a href="/admin/reservation/list" class="nav-item">예약관리</a></li>
					<li><a href="/admin/stay/staylist" class="nav-item active">숙소관리</a></li>
					<li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
					<li><a href="/admin/dashboard#category-section"
						class="nav-item">페이지관리</a></li>
				</ul>
			</nav>
		</aside>

		<main class="admin-main">
			<div class="admin-header">
				<div class="header-content">
					<div class="header-left">
						<h1 class="page-title">숙소 수정</h1>
						<p class="page-subtitle">숙소 정보를 수정합니다.</p>
					</div>
					<div class="header-right">
						<a href="/admin/stay/detail?siId=${stay.siId}" class="btn-cancel">돌아가기</a>
					</div>
				</div>
			</div>

			<div class="register-form-container">
				<form action="/admin/stay/update" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="siId" value="${stay.siId}" />

					<div class="register-form">
						<section class="form-section">
							<h2 class="section-title">기본 정보</h2>
							<div class="form-grid">
								<div class="form-group">
									<label class="form-label">숙소명</label><input name="siName"
										value="${stay.siName}" required class="form-input"
										placeholder="숙소 이름을 입력해주세요." />
								</div>
								<div class="form-group">
									<label class="form-label">짧은 설명</label><input name="siDesc"
										class="form-input" value="${stay.siDesc}"
										placeholder="숙소에 대한 간단한 설명을 입력해주세요.(100자 이내)" maxlength="200" />
								</div>
								<div class="form-group">
									<label class="form-label">지역 상세</label><input name="siLoca"
										value="${stay.siLoca}" required class="form-input"
										placeholder="(예: 서울, 은평구)" />
								</div>
								<div class="form-group">
									<label class="form-label">지역 선택</label><select name="lcId"
										class="form-select" required>
										<option value="">-- 선택 --</option>
										<c:forEach var="loc" items="${locationList}">
											<option value="${loc.lcId}"
												<c:if test="${loc.lcId eq stay.lcId}">selected</c:if>>${loc.lcName}</option>
										</c:forEach>
									</select>
								</div>
								<div class="form-group">
									<label class="form-label">최소 인원</label><input type="number"
										name="siMinperson" value="${stay.siMinperson}" required
										class="form-input" placeholder="1" min="1" required />
								</div>
								<div class="form-group">
									<label class="form-label">최대 인원</label><input type="number"
										name="siMaxperson" value="${stay.siMaxperson}" required
										class="form-input" placeholder="4" min="1" required />
								</div>
								<div class="form-group">
									<label class="form-label">기본 요금</label><input type="number"
										name="siMinprice" value="${stay.siMinprice}" required
										class="form-input" placeholder="50000" required />
								</div>
								<div class="form-group">
									<label class="form-label">추가 인원 요금</label><input type="number"
										name="siExtra" value="${stay.siExtra}" required
										class="form-input" placeholder="10000" />
								</div>
								<div class="form-group">
									<label class="form-label">성수기 요율</label><input type="number"
										name="siPeak" value="${stay.siPeak}" step="0.1" required
										class="form-input" placeholder="1.2" />
								</div>
								<div class="form-group">
									<label class="form-label">비성수기 요율</label><input type="number"
										name="siOff" value="${stay.siOff}" step="0.1" required
										class="form-input" placeholder="0.8" />
								</div>
								<div class="form-group">
									<label class="form-label">할인율 (%)</label><input type="number"
										name="siDiscount" value="${stay.siDiscount}" step="0.01"
										required class="form-input" placeholder="0.2" />
								</div>
							</div>
						</section>
					</div>

					<div class="register-form">
						<section class="form-section">
							<h2 class="section-title">상세 정보</h2>
							<div class="form-group full-width">
								<label class="form-label">공지사항</label>
								<textarea name="siNotice" class="form-textarea"
									placeholder="공지사항을 입력해주세요.(400자 이내)">${detail.siNotice}</textarea>
							</div>
							<div class="form-group full-width">
								<label class="form-label">상세 설명 1</label>
								<textarea name="siDesc1" class="form-textarea"
									placeholder="이미지 1에 대한 설명을 입력해주세요.(3000자 이하)" maxlength="2000">${detail.siDesc1}</textarea>
							</div>
							<div class="form-group full-width">
								<label class="form-label">상세 설명 2</label>
								<textarea name="siDesc2" class="form-textarea"
									placeholder="이미지 2에 대한 설명을 입력해주세요.(3000자 이하)" maxlength="2000">${detail.siDesc2}</textarea>
							</div>
							<div class="form-group full-width">
								<label class="form-label">특징 제목 1</label><input
									name="siFeatTitle1" value="${detail.siFeatTitle1}"
									class="form-input"
									placeholder="특징 1에 대한 제목을 간력히 입력해주세요.(예: TERRACE, 독서)" />
							</div>
							<div class="form-group full-width">
								<label class="form-label">특징 설명 1</label>
								<textarea name="siFeat1" class="form-textarea"
									placeholder="특징 1에 대한 설명을 입력해주세요.(800자 이하)" maxlength="700">${detail.siFeat1}</textarea>
							</div>
							<div class="form-group full-width">
								<label class="form-label">특징 제목 2</label><input
									name="siFeatTitle2" value="${detail.siFeatTitle2}"
									class="form-input"
									placeholder="특징 2에 대한 제목을 간력히 입력해주세요.(예: TERRACE, 독서)" />
							</div>
							<div class="form-group full-width">
								<label class="form-label">특징 설명 2</label>
								<textarea name="siFeat2" class="form-textarea"
									placeholder="특징 2에 대한 설명을 입력해주세요.(800자 이하)" maxlength="700">${detail.siFeat2}</textarea>
							</div>
							<div class="form-grid">
								<div class="form-group">
									<label class="form-label">주소</label><input name="siAddress"
										value="${detail.siAddress}" class="form-input"
										placeholder="상세주소를 입력해주세요." />
								</div>
								<div class="form-group">
									<label class="form-label">주소 설명</label><input name="siAddrdesc"
										value="${detail.siAddrdesc}" class="form-input"
										placeholder="주소에 대한 추가 설명을 입력해주세요." />
								</div>
								<div class="form-group">
									<label class="form-label">전화번호</label><input name="siPhone"
										value="${detail.siPhone}" class="form-input"
										placeholder="전화번호를 입력해주세요. (예: 010-2345-678)" />
								</div>
								<div class="form-group">
									<label class="form-label">이메일</label><input name="siEmail"
										value="${detail.siEmail}" class="form-input"
										placeholder="이메일 주소를 입력해주세요." />
								</div>
								<div class="form-group">
									<label class="form-label">인스타그램</label><input
										name="siInstagram" value="${detail.siInstagram}"
										class="form-input"
										placeholder="인스타그램 계정을 입력해주세요. (예: @stayfolio)" />
								</div>
								<div class="form-group">
									<label class="form-label">사업자명</label><input name="siBizname"
										value="${detail.siBizname}" class="form-input"
										placeholder="사업자명을 입력해주세요." />
								</div>
								<div class="form-group">
									<label class="form-label">사업자번호</label><input name="siBiznum"
										value="${detail.siBiznum}" class="form-input"
										placeholder="사업자번호를 입력해주세요. (예: 123-45-67890)" />
								</div>
								<div class="form-group">
									<label class="form-label">대표자명</label><input name="siCeo"
										value="${detail.siCeo}" class="form-input"
										placeholder="대표자명을 입력해주세요." />
								</div>
								<div class="form-group">
									<label class="form-label">체크인</label><input name="siCheckin"
										value="${detail.siCheckin}" class="form-input"
										placeholder="15:00" />
								</div>
								<div class="form-group">
									<label class="form-label">체크아웃</label><input name="siCheckout"
										value="${detail.siCheckout}" class="form-input"
										placeholder="11:00" />
								</div>
							</div>

							<br>

							<div class="form-group full-width">
								<label class="form-label">부가 서비스</label>
								<div class="amenities-grid form-radio-grid">

									<div class="form-row form-radio">
										<span class="amenity-item radio-label">반려동물 동반</span> <label><input
											type="radio" name="siPet" value="1"
											<c:if test="${detail.siPet}">checked</c:if>> 가능</label>
										<label><input type="radio" name="siPet" value="0"
											<c:if test="${!detail.siPet}">checked</c:if>> 불가능</label>
									</div>

									<div class="form-row form-radio">
										<span class="amenity-item radio-label">주차</span> <label><input
											type="radio" name="siParking" value="1"
											<c:if test="${detail.siParking}">checked</c:if>>
											가능</label> <label><input type="radio" name="siParking"
											value="0"
											<c:if test="${!detail.siParking}">checked</c:if>>
											불가능</label>
									</div>

									<div class="form-row form-radio">
										<span class="amenity-item radio-label">취식</span> <label><input
											type="radio" name="siFood" value="1"
											<c:if test="${detail.siFood}">checked</c:if>> 가능</label>
										<label><input type="radio" name="siFood" value="0"
											<c:if test="${!detail.siFood}">checked</c:if>>
											불가능</label>
									</div>

								</div>
							</div>

							<br>

							<div class="form-group full-width">
								<label class="form-label">편의시설 선택</label>
								<div class="amenities-grid"
									style="display: flex; flex-wrap: wrap; gap: 12px;">
									<c:forEach var="fac" items="${allFacilities}">
										<label class="amenity-item radio-item"> <input
											type="checkbox" name="facilityIds" value="${fac.fiId}"
											<c:forEach var="id" items="${selectedFacilityIds}">
												<c:if test="${id == fac.fiId}">checked</c:if>
											</c:forEach> />
											${fac.fiName}
										</label>
									</c:forEach>
								</div>
							</div>

							<div class="form-group full-width">
								<label class="form-label">키워드 선택</label>
								<div class="amenities-grid"
									style="display: flex; flex-wrap: wrap; gap: 12px;">
									<c:forEach var="key" items="${allKeyword}">
										<label class="amenity-item radio-item"> <input
											type="checkbox" name="keywordIds" value="${key.rcId}"
											<c:forEach var="id" items="${selectedKeywordIds}">
												<c:if test="${id == key.rcId}">checked</c:if>
											</c:forEach> />
											${key.rcName}
										</label>
									</c:forEach>
								</div>
							</div>


							<br>

							<div class="form-group full-width">
								<label class="form-label">게시 여부</label>
								<div class="amenities-grid"
									style="display: flex; flex-direction: column; gap: 12px;">
									<div class="form-row"
										style="display: flex; align-items: center; gap: 20px;">
										<label><input type="radio" name="siShow" value="1"
											<c:if test="${stay.siShow == '1'}">checked</c:if>> 게시</label>
										<label><input type="radio" name="siShow" value="0"
											<c:if test="${stay.siShow == '0'}">checked</c:if>>
											미게시</label>
									</div>
								</div>
							</div>
						</section>

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

					</div>
					<br>
					<div class="form-actions">
						<button type="submit" id="stay-submit-btn" class="btn-save">숙소
							정보 수정</button>
					</div>
				</form>
			</div>
		</main>
	</div>
</body>
</html>
