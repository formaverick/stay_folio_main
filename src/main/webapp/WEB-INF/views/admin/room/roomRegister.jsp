<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>객실 등록 - STAY FOLIO</title>
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
					<li><a href="/admin/review" class="nav-item">리뷰관리</a></li>
				</ul>
			</nav>
		</aside>

		<main class="admin-main">
			<div class="admin-header">
				<div class="header-content">
					<div class="header-left">
						<h1 class="page-title">객실 등록</h1>
						<p class="page-subtitle">새로운 객실 정보를 등록합니다.</p>
					</div>
					<div class="header-right">
						<button class="btn-cancel" onclick="history.back()">취소</button>
						<button class="btn-save" id="last-save-btn">저장 후 상세페이지로
							이동</button>
					</div>
				</div>
			</div>

			<div class="register-form-container">
				<form action="/admin/stay/rooms/add" method="post"
					class="stay-register-form">
					<div class="register-form">
						<section class="form-section">
							<h2 class="section-title">기본 정보</h2>
							<div class="form-grid">
								<div class="form-group">
									<label class="form-label" for="riName">객실 이름</label> <input
										type="text" name="riName" id="riName" required
										class="form-input" placeholder="객실 이름을 입력해주세요." />
								</div>
								<div class="form-group">
									<label class="form-label" for="riType">객실 형태</label> <select
										name="riType" id="riType" class="form-select" required>
										<option value="">-- 객실 형태를 선택하세요 --</option>
										<option value="a">기본형</option>
										<option value="b">독채형</option>
										<option value="c">원룸형</option>
										<option value="d">도미토리</option>
										<option value="e">복층형</option>
									</select>
								</div>
							</div>

							<div class="form-group full-width">
								<label for="riDesc" class="form-label">객실 설명</label>
								<textarea class="form-textarea" name="riDesc" id="riDesc"
									rows="3" placeholder="객실 설명을 입력해주세요.(500자 이내)"></textarea>
							</div>

							<div class="form-grid">
								<div class="form-group">
									<label class="form-label">기준 인원</label><input type="number"
										name="riPerson" id="riPerson" required class="form-input"
										placeholder="1" min="1" required />
								</div>
								<div class="form-group">
									<label class="form-label">최대 인원</label><input type="number"
										name="riMaxperson" id="riMaxperson" required
										class="form-input" placeholder="4" min="1" required />
								</div>

								<div class="form-group">
									<label class="form-label" for="riArea">면적(m²)</label> <input
										type="number" id="riArea" name="riArea" class="form-input"
										step="0.01" min="0" placeholder="32.5" />
								</div>
								<div class="form-group">
									<label class="form-label" for="riPrice">기본 가격</label> <input
										type="number" id="riPrice" name="riPrice" placeholder="50000"
										class="form-input" min="0" required />
								</div>
								<div class="form-group">
									<label class="form-label" for="riBed">침대 종류</label> <input
										type="text" id="riBed" name="riBed"
										placeholder="킹 침대 1 / 더블 침대 1" class="form-input"
										maxlength="30" />
								</div>
								<div class="form-group">
									<label class="form-label" for="riBedcnt">침대 개수</label> <input
										type="number" id="riBedcnt" name="riBedcnt" class="form-input"
										min="0" placeholder="1" />
								</div>
								<div class="form-group">
									<label class="form-label" for="riBedroom">침실 수</label> <input
										type="number" id="riBedroom" name="riBedroom"
										class="form-input" value="1" placeholder="1" />
								</div>
								<div class="form-group">
									<label class="form-label" for="riBathroom">욕실 수</label> <input
										type="number" id="riBathroom" name="riBathroom"
										class="form-input" value="1" placeholder="1" />
								</div>
							</div>

							<div class="form-group full-width">
								<label class="form-label">편의시설 선택</label>
								<div class="amenities-grid">
									<c:if test="${not empty facilityList}">
										<c:forEach var="fac" items="${facilityList}">
											<label class="amenity-item"> <input type="checkbox"
												name="facilities" value="${fac.fiId}"
												<c:if test="${checked}">checked</c:if> /> ${fac.fiName}
											</label>
										</c:forEach>
									</c:if>
								</div>
							</div>

							<div class="form-group full-width">
								<label class="form-label">어메니티 선택</label>
								<div class="amenities-grid">
									<c:if test="${not empty amenityList}">
										<c:forEach var="ame" items="${amenityList}">
											<label class="amenity-item"> <input type="checkbox"
												name="amenities" value="${ame.aiIdx}"
												<c:if test="${checked}">checked</c:if> /> ${ame.raName}
											</label>
										</c:forEach>
									</c:if>
								</div>
							</div>

							<!-- 고정값 -->
							<input type="hidden" name="riShow" value="1" /> <input
								type="hidden" name="riDelete" value="0" /> <input type="hidden"
								name="siId" value="${siId}" />

							<div class="form-actions">
								<button type="submit" class="btn btn-primary">객실 정보 저장</button>
							</div>
						</section>
					</div>
				</form>
			</div>

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
								</label> <input type="file" class="file-input room-file-input"
									id="image-0" name="imageFiles[]" data-spidx="0"
									accept="image/*" required />
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
										</label> <input type="file" class="file-input room-file-input"
											id="image-${i}" name="imageFiles[]" data-spidx="${i}"
											accept="image/*" />
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

			<br> <br>

			<!-- 저장된 객실 목록 출력 -->
			<div class="admin-content">
				<div class="room-table-container">
					<table class="room-table">
						<thead>
							<tr>
								<th>번호</th>
								<th>객실명</th>
								<th>형태</th>
								<th>기준 인원</th>
								<th>기본 가격</th>
							</tr>
						</thead>
						<tbody class="room-list-section"></tbody>
					</table>
				</div>
			</div>

			<script>
			
			$(document).ready(function () {
				  // siId, riId 파라미터를 hidden input에 설정
				  const siId = new URLSearchParams(window.location.search).get("siId");
				  const riId = new URLSearchParams(window.location.search).get("riId");

				  if (siId) {
					   $("#image-siId").val(siId);
				  }
				  
				  if (riId) {
					   $("#image-riId").val(riId);
					   alert("객실 정보가 등록되었습니다. 이미지를 추가해주세요.");
				  }else if(siId){
					  // 객실 리스트에서 들어왔을 경우
					  refreshRoomList(siId);
				  }

				  // 마지막 저장 후 상세페이지 이동 버튼
				  $("#last-save-btn").on("click", function () {
  					const siId = $("#image-siId").val();

  					if (!siId) {
    					alert("⚠️ 숙소 정보가 없습니다. 다시 시도해주세요.");
    					return;
  					}

  				   // 객실이 하나 이상 등록되어 있는지 확인
  				   $.get(`/admin/stay/rooms/list`, { siId }, function (roomList) {
    					if (!Array.isArray(roomList) || roomList.length === 0) {
      						alert("⚠️ 객실이 1개 이상 등록되어야 상세 페이지로 이동할 수 있습니다.");
    					} else {
      						location.href = `/admin/stay/detail?siId=${siId}`;
    					}
  				  	}).fail(function () {
    					alert("⚠️ 객실 정보를 불러오지 못했습니다.");
  					});
				  });

				  // 이미지 업로드 처리
				  $("#image-upload-form").submit(function (e) {
				    e.preventDefault();

				    const $imgSubmitBtn = $(this).find('button[type="submit"]');
				    $imgSubmitBtn.prop("disabled", true).text("업로드 중...");

				    const siId = $("#image-siId").val();
				    const riId = $("#image-riId").val();

				    if (!siId || !riId) {
				      alert("객실 이미지 업로드는 객실 정보 등록 이후 가능합니다");
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
				        $(input).siblings(".file-text").text(file.name); // 파일명 표시
				      }
				    });

				    if (!atLeastOneSelected) {
				      alert("⚠️ 대표 이미지는 필수 항목입니다. 반드시 하나 이상 선택해주세요.");
				      $imgSubmitBtn.prop("disabled", false).text("이미지 업로드");
				      return;
				    }

				    $.ajax({
				      url: "/admin/room/imageUpload",
				      method: "POST",
				      data: formData,
				      processData: false,
				      contentType: false,
				      success: function (res) {
				        alert("✅ " + res);
				        
				        refreshRoomList(siId);
						
				        $("#image-upload-form")[0].reset();
				        $("#image-riId").val("");
				        
				        location.href = `/admin/rooms?siId=${siId}`;
				      },
				      error: function (xhr) {
				        alert("⚠️ " + xhr.responseText);
				        $imgSubmitBtn.prop("disabled", false).text("이미지 업로드");
				      }
				    });
				  });
				});

				// 객실 목록 갱신 함수
				function refreshRoomList(siId) {
				  $.get("/admin/stay/rooms/list", { siId }, function (roomList) {
				    if (!Array.isArray(roomList)) {
				      alert("객실 목록 응답이 배열이 아닙니다.");
				      return;
				    }

				    let html = "";
				    roomList.forEach(room => {
				      html += '<tr>';
				      html += '<td>' + room.riId + '</td>';
				      html += '<td>' + room.riName + '</td>';
				      html += '<td>' + room.riType + '</td>';
				      html += '<td>' + room.riPerson + '명</td>';
				      html += '<td>' + room.riPrice + '원</td>';
				      html += '</tr>';
				    });

				    $(".room-list-section").html(html);
				  });
				}
			</script>
		</main>
	</div>
</body>
</html>