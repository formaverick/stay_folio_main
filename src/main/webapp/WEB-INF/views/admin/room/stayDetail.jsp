<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<title>숙소 상세 - STAY FOLIO</title>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomRegister.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomDetail.css" />
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
<script src="https://unpkg.com/@phosphor-icons/web"></script>
</head>
<body>
	<div class="admin-container">

		<%-- 사이드바 --%>
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

		<%-- 메인 컨텐츠 --%>
		<main class="admin-main">
			<div class="admin-header">
				<div class="header-content">
					<div class="header-left">
						<h1 class="page-title">숙소 상세</h1>
						<p class="page-subtitle">숙소 등록 정보를 확인하세요</p>
					</div>
					<div class="header-right">
						<div style="display: inline-block; margin-right: 1rem;">
							<button class="btn-save" onclick="history.back()">뒤로가기</button>
						</div>

						<form action="/admin/stay/form" method="get"
							style="display: inline-block; margin-right: 1rem;">
							<input type="hidden" name="siId" value="${stay.siId}" />
							<button type="submit" class="btn-save">숙소 수정</button>
						</form>

						<form action="/admin/room/roomlist" method="get"
							style="display: inline-block;">
							<input type="hidden" name="siId" value="${stay.siId}" />
							<button type="submit" class="btn-save">객실 목록 보기</button>
						</form>
					</div>
				</div>
			</div>

			<div class="register-form-container">
				<div class="register-form">

					<!-- 기본 정보 -->
					<section class="form-section">
						<h2 class="section-title">기본 정보</h2>
						<div class="form-grid">

							<div class="form-group">
								<label class="form-label">숙소명</label>
								<div class="form-text-readonly">${stay.siName}</div>
							</div>

							<div class="form-group">
								<label class="form-label">짧은 설명</label>
								<div class="form-text-readonly">${stay.siDesc}</div>
							</div>

							<div class="form-group">
								<label class="form-label">지역 상세</label>
								<div class="form-text-readonly">${stay.siLoca}</div>
							</div>

							<c:forEach var="loc" items="${locationList}">
								<c:if test="${loc.lcId eq stay.lcId}">
									<c:set var="lcName" value="${loc.lcName}" />
								</c:if>
							</c:forEach>

							<div class="form-group">
								<label class="form-label">지역 선택</label>
								<div class="form-text-readonly">${lcName}</div>
							</div>


							<div class="form-group">
								<label class="form-label">최소 인원</label>
								<div class="form-text-readonly">${stay.siMinperson}</div>
							</div>

							<div class="form-group">
								<label class="form-label">최대 인원</label>
								<div class="form-text-readonly">${stay.siMaxperson}</div>
							</div>

							<div class="form-group">
								<label class="form-label">기본 요금</label>
								<div class="form-text-readonly">${stay.siMinprice}</div>
							</div>

							<div class="form-group">
								<label class="form-label">추가 인원 요금</label>
								<div class="form-text-readonly">${stay.siExtra}</div>
							</div>

							<div class="form-group">
								<label class="form-label">성수기 요율</label>
								<div class="form-text-readonly">${stay.siPeak}</div>
							</div>

							<div class="form-group">
								<label class="form-label">비성수기 요율</label>
								<div class="form-text-readonly">${stay.siOff}</div>
							</div>

							<div class="form-group">
								<label class="form-label">할인율 (%)</label>
								<div class="form-text-readonly">${stay.siDiscount}</div>
							</div>

						</div>
					</section>

					<!-- 상세 설명 -->
					<div class="form-section">
						<h2 class="section-title">상세 설명</h2>

						<div class="form-field-group">
							<label class="form-label">상세주소</label>
							<div class="form-text-readonly">${detail.siAddress}</div>
						</div>

						<div class="form-field-group">
							<label class="form-label">주소 설명</label>
							<div class="form-text-readonly">${detail.siAddrdesc}</div>
						</div>

						<div class="form-field-group">
							<label class="form-label">공지사항</label>
							<div class="form-text-readonly">${detail.siNotice}</div>
						</div>

						<div class="form-field-group">
							<label class="form-label">상세 설명 1</label>
							<div class="form-text-readonly">${detail.siDesc1}</div>
						</div>

						<div class="form-field-group">
							<label class="form-label">상세 설명 2</label>
							<div class="form-text-readonly">${detail.siDesc2}</div>
						</div>

						<div class="form-field-group">
							<label class="form-label">특징 제목 1</label>
							<div class="form-text-readonly">${detail.siFeatTitle1}</div>
						</div>

						<div class="form-field-group">
							<label class="form-label">특징 설명 1</label>
							<div class="form-text-readonly">${detail.siFeat1}</div>
						</div>
						<div class="form-field-group">
							<label class="form-label">특징 제목 2</label>
							<div class="form-text-readonly">${detail.siFeatTitle2}</div>
						</div>

						<div class="form-field-group">
							<label class="form-label">특징 설명 2</label>
							<div class="form-text-readonly">${detail.siFeat2}</div>
						</div>
					</div>


					<!-- 연락처 / 사업자 -->
					<div class="form-section">
						<h2 class="section-title">사업자 정보</h2>
						<div class="form-grid">
							<div class="form-group">
								<label class="form-label">대표자명</label>
								<div class="form-text-readonly">${detail.siCeo}</div>
							</div>

							<div class="form-group">
								<label class="form-label">상호명</label>
								<div class="form-text-readonly">${detail.siBizname}</div>
							</div>

							<div class="form-group">
								<label class="form-label">전화번호</label>
								<div class="form-text-readonly">${detail.siPhone}</div>
							</div>

							<div class="form-group">
								<label class="form-label">이메일</label>
								<div class="form-text-readonly">${detail.siEmail}</div>
							</div>

							<div class="form-group">
								<label class="form-label">인스타그램</label>
								<div class="form-text-readonly">${detail.siInstagram}</div>
							</div>

							<div class="form-group">
								<label class="form-label">사업자번호</label>
								<div class="form-text-readonly">${detail.siBiznum}</div>
							</div>
						</div>
					</div>

					<!-- 이용 정보 -->
					<div class="form-section">
						<h2 class="section-title">이용 정보</h2>
						<div class="form-grid">
							<div class="form-group">
								<label class="form-label">체크인</label>
								<div class="form-text-readonly">${detail.siCheckin}</div>
							</div>
							<div class="form-group">
								<label class="form-label">체크아웃</label>
								<div class="form-text-readonly">${detail.siCheckout}</div>
							</div>
							<div class="form-group">
								<label class="form-label">반려동물</label>
								<div class="form-text-readonly">${detail.siPet ? '가능' : '불가능'}</div>
							</div>
							<div class="form-group">
								<label class="form-label">주차</label>
								<div class="form-text-readonly">${detail.siParking ? '가능' : '불가능'}</div>
							</div>
							<div class="form-group">
								<label class="form-label">취식</label>
								<div class="form-text-readonly">${detail.siFood ? '가능' : '불가능'}</div>
							</div>
						</div>
					</div>

					<!-- 편의시설 -->
					<div class="form-section">
						<h2 class="section-title">편의시설</h2>
						<div class="facility-list">
							<c:forEach var="fac" items="${stayFacilities}">
								<div class="facility-item">
									<i class="ph ${fac.fiIcon}"></i> <span>${fac.fiName}</span>
								</div>
							</c:forEach>
						</div>
					</div>

					<!-- 키워드 -->
					<div class="form-section">
						<h2 class="section-title">키워드</h2>
						<div class="facility-list">
							<c:forEach var="key" items="${stayKeywords}">
								<div class="facility-item">
									<span>${key.rcName}</span>
								</div>
							</c:forEach>
						</div>
					</div>


					<!-- 이미지 -->
					<div class="form-section">
						<h2 class="section-title">숙소 이미지</h2>

						<label class="form-label">대표 이미지</label>
						<c:forEach var="photo" items="${stayPhotos.main}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="대표 이미지" />
						</c:forEach>

						<label class="form-label">추가 이미지</label>
						<c:forEach var="photo" items="${stayPhotos.additional}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="추가 이미지" />
						</c:forEach>

						<label class="form-label">주요 특징 이미지</label>
						<c:forEach var="photo" items="${stayPhotos.feature}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="주요 특징 이미지" />
						</c:forEach>

						<label class="form-label">특징1 이미지</label>
						<c:forEach var="photo" items="${stayPhotos.feat1}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="특징1 이미지" />
						</c:forEach>

						<label class="form-label">특징2 이미지</label>
						<c:forEach var="photo" items="${stayPhotos.feat2}">
							<img class="preview" src="${s3BaseUrl}${photo.spUrl}"
								alt="특징2 이미지" />
						</c:forEach>
					</div>
				</div>
			</div>
		</main>
	</div>
</body>
</html>
