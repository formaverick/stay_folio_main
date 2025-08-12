<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>숙소 등록 - STAY FOLIO</title>
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
<script
	src="${pageContext.request.contextPath}/resources/js/admin/room/roomRegister.js"></script>
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
					<li><a href="/admin/dashboard#category-section"
						class="nav-item">페이지관리</a></li>
				</ul>
			</nav>
		</aside>

		<main class="admin-main">
			<div class="admin-header">
				<div class="header-content">
					<div class="header-left">
						<h1 class="page-title">숙소 등록</h1>
						<p class="page-subtitle">새로운 숙소 정보를 등록합니다.</p>
					</div>
					<div class="header-right">
						<button class="btn-cancel" onclick="history.back()">취소</button>
					</div>
				</div>
			</div>

			<div class="register-form-container">
				<form action="/admin/stay/add" method="post"
					class="stay-register-form">
					<!-- 기본 정보 폼 -->
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

					<!-- 상세 정보 시작 -->
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

							<div class="form-group full-width">
								<h2 class="section-title">부가 서비스</h2>
								<div class="amenities-grid form-radio-grid">

									<div class="form-row form-radio">
										<label class="amenity-item radio-label">반려동물 동반</label> <label><input
											type="radio" name="siPet" value="1"
											<c:if test="${detail.siPet}">checked</c:if>> <span
											class="amenity-text">가능</span></label> <label><input
											type="radio" name="siPet" value="0"
											<c:if test="${!detail.siPet}">checked</c:if>> <span
											class="amenity-text">불가능</span></label>
									</div>

									<div class="form-row form-radio">
										<label class="amenity-item radio-label">주차</label> <label><input
											type="radio" name="siParking" value="1"
											<c:if test="${detail.siParking}">checked</c:if>>
											가능</label> <label><input type="radio" name="siParking"
											value="0"
											<c:if test="${!detail.siParking}">checked</c:if>>
											불가능</label>
									</div>

									<div class="form-row form-radio">
										<label class="amenity-item radio-label">취식</label> <label><input
											type="radio" name="siFood" value="1"
											<c:if test="${detail.siFood}">checked</c:if>> 가능</label>
										<label><input type="radio" name="siFood" value="0"
											<c:if test="${!detail.siFood}">checked</c:if>>
											불가능</label>
									</div>
								</div>
							</div>


							<div class="form-group full-width">
								<h2 class="section-title">편의시설 선택</h2>
								<div class="amenities-grid">
									<c:if test="${not empty facilityList}">
										<c:forEach var="fac" items="${facilityList}">
											<c:set var="checked" value="false" />

											<c:if test="${not empty selectedFacilityIds}">
												<c:forEach var="selId" items="${selectedFacilityIds}">
													<c:if test="${selId eq fac.fiId}">
														<c:set var="checked" value="true" />
													</c:if>
												</c:forEach>
											</c:if>

											<label class="amenity-item"> <input type="checkbox"
												name="facilities" value="${fac.fiId}"
												<c:if test="${checked}">checked</c:if> /> ${fac.fiName}
											</label>
										</c:forEach>
									</c:if>
								</div>
							</div>

							<div class="form-group full-width">
								<h2 class="section-title">키워드 선택</h2>
								<div class="amenities-grid">
									<c:if test="${not empty keywordList}">
										<c:forEach var="key" items="${keywordList}">
											<c:set var="checked" value="false" />

											<c:if test="${not empty selectedKeywordIds}">
												<c:forEach var="selId" items="${selectedKeywordIds}">
													<c:if test="${selId eq key.rcId}">
														<c:set var="checked" value="true" />
													</c:if>
												</c:forEach>
											</c:if>

											<label class="amenity-item"> <input type="checkbox"
												name="keyword" value="${key.rcId}"
												<c:if test="${checked}">checked</c:if> /> ${key.rcName}
											</label>
										</c:forEach>
									</c:if>
								</div>
							</div>


							<br>

							<!-- 고정값 hidden -->
							<input type="hidden" name="siShow" value="1"> <input
								type="hidden" name="siDelete" value="0"> <input
								type="hidden" name="siBook" value="0"> <input
								type="hidden" name="siReview" value="0">

							<div class="form-actions">
								<button type="submit" id="stay-submit-btn" class="btn-save"
									<c:if test="${not empty newSiId}">disabled</c:if>>숙소
									정보 저장</button>
							</div>
						</section>
					</div>
				</form>
			</div>


			<div class="register-form-container">
				<!-- 이미지 업로드 -->
				<form class="register-form" id="image-upload-form" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="siId" id="image-siId" /> <input
						type="hidden" name="riId" id="image-riId" />

					<section class="form-section">
						<h2 class="section-title">이미지 업로드</h2>
						<div class="form-group full-width">
							<label class="form-label">대표 이미지</label>
							<div class="simple-upload-container">
								<div class="file-upload-wrapper main-image-wrapper">
									<label for="image-0" class="file-upload-label"> <span
										class="file-icon"><i class="ph ph-folder"></i></span> <span
										class="file-text">대표 이미지 선택</span>
									</label> <input type="file" class="file-input" id="image-0"
										name="imageFiles[]" data-spidx="0" accept="image/*" />
								</div>
							</div>
						</div>

						<div class="form-group full-width">
							<label class="form-label">추가 이미지 (최대 10개)</label>
							<div class="simple-upload-container">
								<div class="additional-images-grid">
									<c:forEach var="i" begin="1" end="11">
										<div class="file-upload-wrapper">
											<label for="image-${i}" class="file-upload-label"> <span
												class="file-icon"><i class="ph ph-folder"></i></span> <span
												class="file-text"> <c:choose>
														<c:when test="${i le 2}">추가 이미지 ${i}</c:when>
														<c:when test="${i le 5}">주요 특징 이미지 ${i-2}</c:when>
														<c:when test="${i le 8}">특징1 이미지 ${i-5}</c:when>
														<c:otherwise>특징2 이미지 ${i-8}</c:otherwise>
													</c:choose>
											</span>
											</label> <input type="file" class="file-input" id="image-${i}"
												name="imageFiles[]" data-spidx="${i}" accept="image/*" />
										</div>
									</c:forEach>
								</div>
							</div>
						</div>

						<div class="form-actions">
							<button type="submit" class="btn-save">이미지 업로드</button>
						</div>

					</section>
				</form>
			</div>


			<!-- 객실 등록 버튼 -->
			<div style="text-align: right; margin-top: 2rem;">
				<c:choose>
					<c:when test="${not empty newSiId}">
						<form action="/admin/rooms" method="get">
							<input type="hidden" name="siId" value="${newSiId}" />
							<button type="submit" class="btn-save">객실 등록하러 가기</button>
						</form>
					</c:when>

					<c:otherwise>
						<button type="button" class="btn-save"
							onclick="alert('⚠️ 숙소 정보를 등록해주세요.')">객실 등록하러 가기</button>
					</c:otherwise>
				</c:choose>
			</div>
			<!-- 객실 등록 버튼 끝-->
		</main>
	</div>

	<script>
  $(document).ready(function () {
    // 숙소 ID 값 세팅
    <c:if test="${not empty newSiId}">
      $("#image-siId").val("${newSiId}");
      alert("숙소 정보가 등록되었습니다. 이미지를 추가해주세요.");
    </c:if>

    // 숙소 상세 정보 저장 버튼 비활성화 처리
    $(".stay-register-form").on("submit", function () {
      const $btn = $("#stay-submit-btn");
      $btn.prop("disabled", true).text("저장 중...");
    });

    // 이미지 업로드
    $("#image-upload-form").submit(function (e) {
      e.preventDefault();
      
      const $imgSubmitBtn = $(this).find('button[type="submit"]');
      $imgSubmitBtn.prop("disabled", true).text("업로드 중...");

      // 이미지 업로드 처리
      const siId = $("#image-siId").val();
      const riId = $("#image-riId").val();
      

      if (!siId || siId.trim() === "") {
        alert("숙소 이미지 업로드는 숙소 정보 등록 이후 가능합니다");
        $imgSubmitBtn.prop("disabled", false).text("이미지 업로드");
        return;
      }

      const formData = new FormData();
      formData.append("siId", siId);
      formData.append("riId", riId);

      let atLeastOneSelected = false;

      document.querySelectorAll(".file-input").forEach(input => {
        if (input.files.length > 0) {
          const file = input.files[0];
          const spIdx = input.dataset.spidx;

          formData.append("imageFiles", file);
          formData.append("spIdxes", spIdx);
          atLeastOneSelected = true;
        } else {
        	alert("⚠️ 파일 미선택");
        }
      });

      if (!atLeastOneSelected) {
        alert("⚠️ 대표 이미지는 필수 항목입니다. 반드시 하나 이상 선택해주세요.");
        return;
      }

      $.ajax({
        url: "/admin/stay/imageUpload",
        method: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function (res) {
          alert("✅ 이미지 업로드 완료: " + res);
          $("#image-upload-form")[0].reset();
          $("#image-riId").val("");
          $imgSubmitBtn.prop("disabled", true).text("이미지 업로드");
        },
        error: function (xhr) {
          alert("⚠️ 오류 발생: " + xhr.responseText);
          $imgSubmitBtn.prop("disabled", false).text("이미지 업로드");
        }
      });
    });
  });
</script>

</body>
</html>
