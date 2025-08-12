<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set
  var="s3BaseUrl"
  value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/"
/>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>예약 완료 - STAY FOLIO</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/common.css'/>" />
    <link rel="stylesheet" href="<c:url value='/resources/css/header.css'/>" />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="<c:url value='/resources/js/mypage/mypage.js'/>"></script>

    <jsp:include page="../includes/header.jsp" />

    <link
      rel="stylesheet"
      href="<c:url value='/resources/css/reservation/reservationComplete.css'/>"
    />
  </head>
  <body>
    <div class="mypage-header">
      <div class="success-icon">
        <i class="ph ph-check-circle"></i>
      </div>
      <h2 class="mypage-title">예약이 완료되었어요!</h2>
      <p class="mypage-subtitle">예약 정보를 확인해주세요.</p>
    </div>

    <div class="mypage-main">
      <div class="reserv-box">
        <div class="reserv-info">
          <div>
            <h3>${reservation.riName}</h3>
            <p class="reserv-day">
              <fmt:formatDate
                value="${reservation.srCheckin}"
                pattern="yyyy.MM.dd"
              />
              ~
              <fmt:formatDate
                value="${reservation.srCheckout}"
                pattern="yyyy.MM.dd"
              />
              (${reservation.nights}박)
            </p>
            <p class="reserv-option" style="margin-top: 1rem; color: #666">
              <c:choose>
                <c:when test="${reservation.riType eq 'a'}">기본형</c:when>
                <c:when test="${reservation.riType eq 'b'}">독채형</c:when>
                <c:when test="${reservation.riType eq 'c'}">원룸형</c:when>
                <c:when test="${reservation.riType eq 'd'}">도미토리</c:when>
                <c:when test="${reservation.riType eq 'e'}">복층형</c:when>
                <c:otherwise>기타</c:otherwise>
              </c:choose>
              / 기준 ${reservation.riPerson}명 (최대
              ${reservation.riMaxperson}명)
            </p>
          </div>
        </div>
        <div class="reserv-image">
          <img src="${s3BaseUrl}${reservation.spUrl}" alt="Room Image" />
        </div>
      </div>

      <div class="reservation-status">
        <h3 class="status-title">예약 상태</h3>
        <div class="status-steps">
          <div class="step step-01">
            <div class="icon">
              <i class="ph ph-file-plus"></i>
            </div>
            <div class="step-title">STEP 01<br />예약 확정</div>
            <p class="step-desc">
              예약 신청이 완료되었으며, 호스트의 예약 확정 대기 상태입니다.
            </p>
          </div>
          <div class="step step-02 active">
            <div class="icon">
              <i class="ph ph-check-circle"></i>
            </div>
            <div class="step-title">STEP 02<br />체크인</div>
            <p class="step-desc">예약이 최종 확정된 상태입니다.</p>
          </div>
          <div class="step step-03">
            <div class="icon">
              <i class="ph ph-suitcase-simple"></i>
            </div>
            <div class="step-title">STEP 03<br />체크아웃</div>
            <p class="step-desc">체크아웃이 완료된 상태입니다.</p>
          </div>
        </div>
      </div>

      <div class="reservation-detail-section">
        <h3>예약 안내</h3>
        <table class="reservation-info-table">
          <tr>
            <td class="reservation-info-title">01. 예약 번호</td>
            <td class="reservation-info-content">
              #${reservation.srId} (예약일자:
              <c:if test="${not empty reservation.srDate}">
                ${reservation.srDate} </c:if
              >)
            </td>
          </tr>
          <tr>
            <td class="reservation-info-title">02. 스테이 및 객실</td>
            <td class="reservation-info-content">
              ${info.siName}/ ${reservation.riName}
            </td>
          </tr>
          <tr>
            <td class="reservation-info-title">03. 숙박 인원</td>
            <td class="reservation-info-content">
              총 ${reservation.srAdult + reservation.srChild}명 (성인:
              ${reservation.srAdult}명 / 아동: ${reservation.srChild}명)
            </td>
          </tr>
          <tr>
            <td class="reservation-info-title">04. 체크인</td>
            <td class="reservation-info-content">
              <fmt:formatDate
                value="${reservation.srCheckin}"
                pattern="yyyy.MM.dd"
              />
              ${info.siCheckin}
            </td>
          </tr>
          <tr>
            <td class="reservation-info-title">05. 체크아웃</td>
            <td class="reservation-info-content">
              <fmt:formatDate
                value="${reservation.srCheckout}"
                pattern="yyyy.MM.dd"
              />
              ${info.siCheckout}
            </td>
          </tr>
          <tr>
            <td class="reservation-info-title">06. 룸설명</td>
            <td class="reservation-info-content">
              <c:choose>
                <c:when test="${not empty reservation.riDesc}">
                  ${reservation.riDesc}
                </c:when>
                <c:otherwise> 정보가 없습니다. </c:otherwise>
              </c:choose>
            </td>
          </tr>
          <tr>
            <td class="reservation-info-title">07. 요청사항</td>
            <td class="reservation-info-content">
              <c:choose>
                <c:when test="${not empty reservation.srRequest}">
                  ${reservation.srRequest}
                </c:when>
                <c:otherwise> 요청사항 없습니다. </c:otherwise>
              </c:choose>
            </td>
          </tr>

          <tr>
            <td class="reservation-info-title">08. 공지 포함</td>
            <td class="reservation-info-content">
              숙박자의 체류목적, 일정, 인원, 교통편 조정합니다. 예약자의 사전
              동의 없이는 체류 목적 외 방문, 인원 변경 등이 불가능합니다.
            </td>
          </tr>
        </table>
      </div>

      <div class="reservation-detail-section">
        <h3>결제 정보</h3>
        <table class="payment-info-table">
          <tr>
            <td class="reservation-info-title">01. 결제 금액</td>
            <td class="reservation-info-content">
              <p>
                숙소 요금: ₩
                <fmt:formatNumber value="${info.srRoomprice}" pattern="#,#00" />
              </p>
              <c:if test="${info.srAddpersonFee != 0}">
                <p class="payment-add">
                  인원 추가: ₩
                  <fmt:formatNumber
                    value="${info.srAddpersonFee}"
                    pattern="#,##0"
                  />
                </p>
              </c:if>
              <c:if test="${info.srDiscount != 0}">
                <p class="payment-add">
                  할인 금액: ₩
                  <fmt:formatNumber
                    value="${info.srDiscount}"
                    pattern="#,##0"
                  />
                </p>
              </c:if>

              <div class="payment-summary">
                총 결제 금액
                <span
                  >₩<fmt:formatNumber
                    value="${reservation.srTotalprice}"
                    pattern="#,##0"
                /></span>
              </div>
            </td>
          </tr>
          <tr>
            <td class="reservation-info-title">02. 결제 방법</td>
            <td class="reservation-info-content">
              ${reservation.srPayment} (결제 완료:
              <fmt:formatDate
                value="${reservation.srPaydate}"
                pattern="yyyy-MM-dd HH:mm:ss"
              />)
            </td>
          </tr>
        </table>
      </div>

      <div class="reservation-detail-section">
        <div class="detail-bottom-buttons">
          <c:if test="${isLogin}">
            <button
              onclick="location.href='/mypage/reservations/${reservation.srId}'"
            >
              예약 상세페이지
            </button>
          </c:if>

          <button onclick="location.href='/'">메인으로</button>
        </div>
      </div>
    </div>

    <jsp:include page="../includes/footer.jsp" />
  </body>
</html>
