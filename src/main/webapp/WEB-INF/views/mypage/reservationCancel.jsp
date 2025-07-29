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
      href="${pageContext.request.contextPath}/resources/css/mypage/myReservation.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/mypage/reservationCancel.css"
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

        <div class="reservation-cancel-section">
          <h3>취소 사유</h3>
          <p class="cancel-question">예약을 취소하려는 이유가 무엇인가요?</p>
          <div class="cancel-reason-list">
            <label
              ><input type="radio" name="reason" /> 여행이 취소되거나
              미뤄졌어요.</label
            >
            <label
              ><input type="radio" name="reason" /> 예약 정보(숙소, 일정,
              결제수단 등)를 변경하고 싶어요.</label
            >
            <label
              ><input type="radio" name="reason" /> 호스트가 예약 취소를
              원해요.</label
            >
            <label><input type="radio" name="reason" /> 기타(직접 입력)</label>
          </div>
          <textarea
            class="cancel-textarea"
            placeholder="취소 사유를 입력해 주세요."
          ></textarea>
        </div>

        <div class="refund-policy-section">
          <h3>환불규정</h3>
          <p class="refund-desc">
            ※ 숙박일의 체크인일을 기준하여 일자, 양수, 금액을 조정합니다.
          </p>
          <table class="refund-table">
            <thead>
              <tr>
                <th>기준일</th>
                <th>환불 금액</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>체크인 7일 전까지</td>
                <td>총 결제 금액의 100% 환불</td>
              </tr>
              <tr>
                <td>체크인 6~5일 전까지</td>
                <td>총 결제 금액의 70% 환불</td>
              </tr>
              <tr>
                <td>체크인 4~3일 전까지</td>
                <td>총 결제 금액의 50% 환불</td>
              </tr>
              <tr>
                <td>체크인 2~1일 전부터</td>
                <td>총 결제 금액의 20% 환불</td>
              </tr>
              <tr>
                <td>체크인 당일</td>
                <td>변경 / 환불 불가</td>
              </tr>
            </tbody>
          </table>
          <div class="refund-check">
            <label
              ><input type="checkbox" /> 환불규정을 모두 확인하였으며 이에
              동의합니다.</label
            >
          </div>
        </div>

        <div class="cancel-buttons">
          <button class="cancel-back">뒤로가기</button>
          <button class="cancel-submit">예약 취소</button>
        </div>
      </div>
    </div>
    <jsp:include page="includes/footer.jsp" />
  </body>
</html>
