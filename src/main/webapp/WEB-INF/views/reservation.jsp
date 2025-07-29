<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
  <head>
    <meta charset="UTF-8" />
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
      href="${pageContext.request.contextPath}/resources/css/reservation.css"
    />
    <title>스테이폴리오</title>
  </head>
  <body>
    <jsp:include page="includes/header.jsp" />

    <h2>예약 정보 확인 및 결제</h2>

    <form
      action="/reservation/submit"
      method="post"
      style="display: flex; gap: 50px"
    >
      <!-- ✅ 왼쪽: 예약 정보 입력 -->
      <section style="flex: 1">
        <!-- ✅ 객실 정보 -->
        <h3>객실 정보</h3>
        <p>${info.riName}</p>
        <p>기준 인원: ${info.riPerson} / 최대 인원: ${info.riMaxperson}</p>
        <p>침대: ${info.riBed}</p>
        <p>침실 ${info.riBedroom}개 / 욕실 ${info.riBathroom}개</p>

        <!-- ✅ 예약자 정보 -->
        <h3>예약자 정보</h3>
        <c:choose>
          <c:when test="${isLogin}">
            <p>${srName}</p>
            <p>${srEmail}</p>
            <p>${srPhone}</p>
            <input type="hidden" name="srName" value="${srName}" />
            <input type="hidden" name="srEmail" value="${srEmail}" />
            <input type="hidden" name="srPhone" value="${srPhone}" />
          </c:when>
          <c:otherwise>
            <input
              type="text"
              name="srName"
              placeholder="예약자 이름"
              required
            />
            <input type="email" name="srEmail" placeholder="이메일" required />
            <input type="text" name="srPhone" placeholder="전화번호" required />
          </c:otherwise>
        </c:choose>

        <!-- ✅ 요청사항 -->
        <h3>요청사항</h3>
        <textarea
          name="srRequest"
          rows="3"
          placeholder="요청사항을 입력해주세요."
        ></textarea>

        <!-- ✅ 결제 수단 -->
        <h3>결제 수단</h3>
        <label
          ><input type="radio" name="srPayment" value="국민카드" checked />
          국민카드</label
        ><br />
        <label
          ><input type="radio" name="srPayment" value="신한카드" checked />
          신한카드</label
        ><br />
        <label
          ><input type="radio" name="srPayment" value="BANK" />
          무통장입금</label
        ><br />

        <!-- ✅ 약관 동의 -->
        <h3>약관 동의</h3>
        <label><input type="checkbox" required /> (필수) 이용약관 동의</label
        ><br />
        <label
          ><input type="checkbox" required /> (필수) 개인정보 수집 동의</label
        ><br />
        <label><input type="checkbox" /> (선택) 마케팅 수신 동의</label>

        <!-- ✅ 취소 정책 -->
        <h3>취소/환불 정책</h3>
        <table border="1">
          <thead>
            <tr>
              <th>취소일</th>
              <th>환불율</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>이용 8일 전까지</td>
              <td>총 결제금액의 100% 환불</td>
            </tr>
            <tr>
              <td>이용 7일 전까지</td>
              <td>총 결제금액의 90% 환불</td>
            </tr>
            <tr>
              <td>이용 6일 전까지</td>
              <td>총 결제금액의 80% 환불</td>
            </tr>
            <tr>
              <td>이용 5일 전까지</td>
              <td>총 결제금액의 70% 환불</td>
            </tr>
            <tr>
              <td>이용 4일 전까지</td>
              <td>총 결제금액의 60% 환불</td>
            </tr>
            <tr>
              <td>이용 3일 전까지</td>
              <td>총 결제금액의 50% 환불</td>
            </tr>
            <tr>
              <td>이용 2일 전까지</td>
              <td>총 결제금액의 30% 환불</td>
            </tr>
            <tr>
              <td>이용 1일 전까지</td>
              <td>총 결제금액의 10% 환불</td>
            </tr>
            <tr>
              <td>이용 당일 및 이후</td>
              <td>환불 불가</td>
            </tr>
          </tbody>
        </table>
      </section>

      <!-- ✅ 오른쪽: 요금 요약 -->
      <aside style="flex: 0 0 300px; border: 1px solid #ccc; padding: 20px">
        <h3>결제 금액</h3>
        <c:choose>
          <c:when test="${info.nights > 0}">
            <p>
              1박 요금: ₩<fmt:formatNumber
                value="${info.srRoomPrice/info.nights}"
                pattern="#,###"
              />
            </p>
          </c:when>
          <c:otherwise>
            <p>1박 요금: 계산 불가</p>
          </c:otherwise>
        </c:choose>

        <p>숙박일수: ${info.nights}박</p>
        <p>
          추가 인원 요금: ₩<fmt:formatNumber
            value="${info.srAddpersonFee}"
            pattern="#,###"
          />
        </p>
        <p>
          할인 금액: -₩<fmt:formatNumber
            value="${info.siDiscount}"
            pattern="#,###"
          />
        </p>
        <p>
          <strong
            >총 결제금액: ₩<fmt:formatNumber
              value="${info.srtotalPrice}"
              pattern="#,###"
          /></strong>
        </p>

        <hr />
        <p style="color: gray; font-size: 0.9em">
          성수기 %: <fmt:formatNumber value="${info.siPeak}" pattern="0.0" />배
        </p>
        <p style="color: gray; font-size: 0.9em">
          비성수기 %: <fmt:formatNumber value="${info.siOff}" pattern="0.0" />배
        </p>

        <button type="submit" style="width: 100%; padding: 10px">
          결제하기
        </button>
      </aside>

      <!-- ✅ 숨겨서 넘길 값 -->
      <input type="hidden" name="siId" value="${siId}" />
      <input type="hidden" name="riId" value="${riId}" />
      <input type="hidden" name="miId" value="${miId}" />
      <input type="hidden" name="srAdult" value="${srAdult}" />
      <input type="hidden" name="srChild" value="${srChild}" />
      <input type="hidden" name="srCheckin" value="${checkin}" />
      <input type="hidden" name="srCheckout" value="${checkout}" />
      <input type="hidden" name="srRoomPrice" value="${info.srRoomPrice}" />
      <input type="hidden" name="srDiscount" value="${info.srDiscount}" />
      <input
        type="hidden"
        name="srAddpersonFee"
        value="${info.srAddpersonFee}"
      />
      <input type="hidden" name="srTotalprice" value="${info.srtotalPrice}" />
      <input type="hidden" name="srStatus" value="a" />
    </form>

    <jsp:include page="includes/footer.jsp" />
  </body>
</html>
