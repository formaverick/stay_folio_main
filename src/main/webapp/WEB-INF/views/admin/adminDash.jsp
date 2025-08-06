<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="s3BaseUrl"
	value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/" />
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>대시보드 - STAY FOLIO</title>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.5.0/Chart.min.js"></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/common.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/room/roomRegister.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/admin/dashboard/dashboard.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css" />
</head>
<body>
	<div class="admin-container">
		<!-- 사이드바 -->
		<aside class="admin-sidebar">
			<div class="admin-logo">
				<h1 class="logo-text">
					STAY<br />FOLIO<br /> <span class="admin-text">ADMIN</span>
				</h1>
			</div>
			<nav class="admin-nav">
				<ul>
					<li><a href="/admin/dashboard" class="nav-item active">대시보드</a></li>
					<li><a href="/admin/reservation" class="nav-item">예약관리</a></li>
					<li><a href="/admin/stay/staylist" class="nav-item">숙소관리</a></li>
					<li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
					<li><a href="/admin/review" class="nav-item">리뷰관리</a></li>
				</ul>
			</nav>
		</aside>

		<main class="admin-main">
			<div class="admin-header">
				<div class="header-content">
					<div class="header-left">
						<h1 class="page-title">대시보드</h1>
						<p class="page-subtitle">예약 현황, 숙소 등록 상태, 통계 정보를 빠르게 확인하세요.</p>
					</div>
					<div class="header-right">
						<button type="submit" class="btn-save">마이페이지</button>
					</div>
				</div>
			</div>

			<div class="admin-content"
				style="margin-top: 40px; margin-bottom: 40px;">
				<div class="chart-grid">
					<!-- 예약 현황 -->
					<div class="chart-box">
						<h2 style="margin-bottom: 16px;">예약 현황</h2>
						<canvas id="reservationChart" width="300" height="280"></canvas>
					</div>

					<div class="chart-box">
						<h3 style="margin-bottom: 16px;">회원 vs 비회원 예약 비율</h3>
						<canvas id="memberGuestChart" width="250" height="250"></canvas>
					</div>

					<!-- 지역별 숙소 등록 -->
					<div class="chart-box">
						<h2 style="margin-bottom: 16px;">지역별 숙소 등록 현황</h2>
						<canvas id="regionChart" width="300" height="280"></canvas>
					</div>
				</div>
			</div>


			<!-- 예약 Top5 리스트 -->
			<section class="dashboard-top5">
				<h3>예약 많은 숙소 TOP 5</h3>
				<div class="room-table-container">
					<table class="room-table">
						<thead>
							<tr>
								<th>순위</th>
								<th>숙소명</th>
								<th>지역</th>
								<th>예약 건수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stay" items="${topReservedStays}"
								varStatus="loop">
								<tr>
									<td>${loop.index + 1}</td>
									<td><a href="/admin/stay/detail?siId=${stay.siId}">${stay.siName}</a></td>
									<td>${stay.siLoca}</td>
									<td>${stay.reserveCount}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</section>

			<!-- 북마크 Top5 리스트 -->
			<section class="dashboard-top5">
				<h3>북마크 많은 숙소 TOP 5</h3>
				<div class="room-table-container">
					<table class="room-table">
						<thead>
							<tr>
								<th>순위</th>
								<th>숙소명</th>
								<th>북마크 수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="stay" items="${topBookmarkedStays}"
								varStatus="loop">
								<tr>
									<td>${loop.index + 1}</td>
									<td><a href="/admin/stay/detail?siId=${stay.siId}">${stay.siName}</a></td>
									<td>${stay.siBook}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</section>

			<!-- 객실 리스트  -->
			<section>
				<div class="header-content">
					<div class="header-left">
						<h1 class="page-title">숙소 리스트</h1>
					</div>
					<div class="header-right">
						<form action="/admin/stay/staylist" method="get"
							style="display: inline-block; margin-right: 1rem;">
							<button type="submit" class="btn-save">+ 더보기</button>
						</form>
					</div>
				</div>

				<div class="admin-content">
					<div class="room-table-container">
						<table class="room-table">
							<thead>
								<tr>
									<th>숙소 ID</th>
									<th>숙소명</th>
									<th>지역</th>
									<th>등록일자</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="stay" items="${stayList}">
									<tr>
										<td>${stay.siId}</td>
										<td>${stay.siName}</td>
										<td>${stay.siLoca}</td>
										<td>${stay.siDate.substring(0, 10)}</td>
										<td><a href="/admin/stay/detail?siId=${stay.siId}"
											class="btn-edit">상세보기</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</section>

			<!-- home 카테고리 리스트 -->
			<section>
				<div>
					<div class="header-left">
						<h1 class="page-title">카테고리 리스트</h1>
					</div>
				</div>

				<div class="admin-content">
					<div class="room-table-container">
						<table class="room-table">
							<thead>
								<tr>
									<th>카테고리</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="category" items="${categoryList}">
									<tr>
										<td>${category.rcDetailTop}</td>
										<td><a href="#" class="btn-edit">상세보기</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</section>

			<!-- 검색 키워드 리스트 -->
			<section>
				<div>
					<div class="header-left">
						<h1 class="page-title">키워드 리스트</h1>
					</div>
				</div>

				<div class="admin-content">
					<div class="room-table-container">
						<table class="room-table">
							<thead>
								<tr>
									<th>키워드</th>
									<th>숙소 개수</th>
									<th></th>
								</tr>
							</thead>
							<tbody>
								<c:forEach var="keyword" items="${keywordList}">
									<tr>
										<td>${keyword.rcName}</td>
										<td>${keyword.siNum}</td>
										<td><a href="#" class="btn-edit">상세보기</a></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</div>
			</section>
		</main>
	</div>

	<script>
document.addEventListener("DOMContentLoaded", function () {

  // 예약 현황 (null-safe)
  const total = ${stats.totalCount != null ? stats.totalCount : 0};
  const inProgress = ${stats.inProgressCount != null ? stats.inProgressCount : 0};
  const completed = ${stats.completedCount != null ? stats.completedCount : 0};
  const canceled = ${stats.canceledCount != null ? stats.canceledCount : 0};

  new Chart(document.getElementById("reservationChart"), {
    type: "bar",
    data: {
      labels: ["총 예약", "진행 중", "완료", "취소"],
      datasets: [{
        label: "건수",
        backgroundColor: ["#bbbbbb", "#888888", "#555555", "#dddddd"],
        data: [total, inProgress, completed, canceled]
      }]
    },
    options: {
      responsive: true,
      title: { display: true, text: "예약 현황 통계" },
      legend: { display: false },
      scales: {
        yAxes: [{ ticks: { beginAtZero: true, precision: 0 } }]
      }
    }
  });

  // 회원/비회원
  const member = ${memberCount != null ? memberCount : 0};
  const guest = ${guestCount != null ? guestCount : 0};
  
  console.log("member : ", member, "guest : ", guest);

  new Chart(document.getElementById("memberGuestChart"), {
    type: "doughnut",
    data: {
      labels: ["회원", "비회원"],
      datasets: [{
        data: [member, guest],
        backgroundColor: ["#ccc", "#000"]
      }]
    },
    options: {
      responsive: true,
      legend: { position: "bottom" }
    }
  });

  // 지역별 숙소
  const regionLabels = [
    <c:forEach var="region" items="${regionStats}" varStatus="loop">
      "${region.lcName}"<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
  ];
  const regionData = [
    <c:forEach var="region" items="${regionStats}" varStatus="loop">
      ${region.count}<c:if test="${!loop.last}">,</c:if>
    </c:forEach>
  ];

  new Chart(document.getElementById("regionChart"), {
    type: "bar",
    data: {
      labels: regionLabels,
      datasets: [{
        label: "숙소 개수",
        backgroundColor: "#aaaaaa",
        data: regionData
      }]
    },
    options: {
      responsive: true,
      title: { display: true, text: "지역별 숙소 등록 통계" },
      legend: { display: false },
      scales: {
        yAxes: [{ ticks: { beginAtZero: true, precision: 0 } }]
      }
    }
  });

});
</script>


</body>

</html>