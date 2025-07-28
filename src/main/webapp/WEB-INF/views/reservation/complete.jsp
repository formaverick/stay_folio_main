<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<html>
<head>
<title>예약 상세 페이지</title>
<style>
table {
	border-collapse: collapse;
	width: 600px;
}

td, th {
	padding: 8px;
	border: 1px solid #ccc;
}

th {
	background: #f2f2f2;
}
</style>
</head>
<body>

	<h2>예약 상세 정보</h2>

	<table>
		<tr>
			<th>숙소 이미지</th>
			<td><c:if test="${not empty reservation.spUrl}">
					<img
						src="${pageContext.request.contextPath}/display?fileName=${reservation.spUrl}"
						alt="숙소 이미지" width="200">
				</c:if> <c:if test="${empty reservation.spUrl}">
            이미지 없음
        </c:if></td>
		</tr>
		<tr>
			<th>예약번호</th>
			<td>${reservation.srId}</td>
		</tr>
		<tr>
			<th>객실 이름</th>
			<td>${reservation.riName}</td>
		</tr>
		<tr>
			<th>숙소 주소</th>
			<td>${reservation.siAddress}</td>
		</tr>
		<tr>
			<th>관리자 전화번호</th>
			<td>${reservation.siPhone}</td>
		</tr>
		<tr>
			<th>관리자 이메일</th>
			<td>${reservation.siEmail}</td>
		</tr>
		<tr>
			<th>예약 상태</th>
			<td><c:choose>
					<c:when test="${reservation.srStatus eq 'a'}">예약 완료</c:when>
					<c:when test="${reservation.srStatus eq 'b'}">취소 대기</c:when>
					<c:when test="${reservation.srStatus eq 'c'}">취소 완료</c:when>
					<c:when test="${reservation.srStatus eq 'd'}">입금 대기</c:when>
					<c:otherwise>알 수 없음</c:otherwise>
				</c:choose></td>
		</tr>
		<tr>
			<th>체크인</th>
			<td>${reservation.srCheckin}</td>
		</tr>
		<tr>
			<th>체크아웃</th>
			<td>${reservation.srCheckout}</td>
		</tr>
		<tr>
			<th>어른</th>
			<td>${reservation.srAdult}명</td>
		</tr>
		<tr>
			<th>아이</th>
			<td>${reservation.srChild}명</td>
		</tr>
		<tr>
			<th>요청사항</th>
			<td>${reservation.srRequest}</td>
		</tr>
		<tr>
			<th>총 결제 금액</th>
			<td>${reservation.srTotalPrice}원</td>
		</tr>
		<tr>
			<th>할인 금액</th>
			<td>${reservation.srDiscount}원</td>
		</tr>
		<tr>
			<th>결제 방법</th>
			<td>${reservation.srPayment}</td>
		</tr>
		<tr>
			<th>결제일</th>
			<td>${reservation.srPaydate}</td>
		</tr>
		<tr>
			<th>취소일</th>
			<td><c:if test="${empty reservation.srCancelDate}">
                -
            </c:if> <c:if test="${not empty reservation.srCancelDate}">
                ${reservation.srCancelDate}
            </c:if></td>
		</tr>
	</table>

</body>
</html>
