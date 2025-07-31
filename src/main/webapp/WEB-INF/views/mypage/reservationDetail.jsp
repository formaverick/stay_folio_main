<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>STAY FOLIO</title>
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
      href="${pageContext.request.contextPath}/resources/css/mypage/mypageCommon.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/mypage/reservationDetail.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- Font Awesome -->
    <link
      rel="stylesheet"
      href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
    />
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  </head>
  <body>
    <!-- Header Include -->
    <jsp:include page="includes/header.jsp" />
    <div class="mypage-header">
      <h2 class="mypage-title">이지선님 반가워요!</h2>
      <p class="mypage-subtitle">2025년 7월부터 0번의 여행을 했어요.</p>
    </div>
    <div class="mypage-page">
      <div class="mypage-submenu">
        <ul>
          <li class="active"><a href="#">예약 정보</a></li>
          <li><a href="#">북마크</a></li>
          <li><a href="#">회원정보 수정</a></li>
        </ul>
      </div>

      <div class="mypage-main">
        <div class="reserv-box">
          <div class="reserv-info">
            <div>
              <h3>Terrace Room</h3>
              <p class="reserv-day">2025.09.16 ~ 2025.09.17 (1박)</p>
              <p class="reserv-option" style="margin-top: 1rem; color: #666">
                기본형 / 기준 2명 (최대 2명)
              </p>
            </div>
          </div>
          <div class="reserv-image">
            <img src="../../img/stay/stayimg1.jpg" alt="Terrace Room" />
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
                2048825207 (예약 일자 : 2025-07-29 10:45)
              </td>
            </tr>
            <tr>
              <td class="reservation-info-title">02. 스테이 및 객실</td>
              <td class="reservation-info-content">
                버니하우스 / 트윈트윈 (B)
              </td>
            </tr>
            <tr>
              <td class="reservation-info-title">03. 숙박 인원</td>
              <td class="reservation-info-content">
                총 1명 (성인: 1명 / 아동: 0명 / 영아: 0명)
              </td>
            </tr>
            <tr>
              <td class="reservation-info-title">04. 체크인</td>
              <td class="reservation-info-content">2025-10-10 16:00</td>
            </tr>
            <tr>
              <td class="reservation-info-title">05. 체크아웃</td>
              <td class="reservation-info-content">2025-10-11 11:00</td>
            </tr>
            <tr>
              <td class="reservation-info-title">06. 룸설명</td>
              <td class="reservation-info-content">정보가 없습니다.</td>
            </tr>
            <tr>
              <td class="reservation-info-title">07. 요청사항</td>
              <td class="reservation-info-content">요청사항이 없습니다.</td>
            </tr>
            <tr>
              <td class="reservation-info-title">08. 공지 포함</td>
              <td class="reservation-info-content">
                숙박자의 체류목적, 일정, 인원, 교통편 조정합니다.<br />
                예약자의 사전 동의 없이는 체류 목적 외 방문, 인원 변경 등이
                불가능합니다.
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
                <p>숙소 요금: 33,000</p>
                <p class="payment-add">인원 추가: 0</p>
                <div class="payment-summary">
                  총 결제 금액 <span>33,000</span>
                </div>
              </td>
            </tr>
            <tr>
              <td class="reservation-info-title">02. 결제 방법</td>
              <td class="reservation-info-content">
                토스페이 (결제 완료: 2025-07-29 10:53)
              </td>
            </tr>
          </table>
        </div>
        <div class="reservation-detail-section">
          <div class="detail-bottom-buttons">
            <button>예약 취소</button>
            <button>이용 안내 및 환불 규정</button>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="includes/footer.jsp" />
  </body>
</html>
