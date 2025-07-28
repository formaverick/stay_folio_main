<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>예약 확인 및 결제 - STAY FOLIO</title>

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
      href="${pageContext.request.contextPath}/resources/css/search/searchFilter.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/search/search.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/reservation/reservation.css"
    />

    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/flatpickr"></script>
    <script src="${pageContext.request.contextPath}/resources/js/reservation/reservation.js"></script>
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/npm/flatpickr/dist/flatpickr.min.css"
    />
  </head>

  <body>
    <!-- 헤더 인클루드 -->
    <jsp:include page="../includes/header.jsp" />

    <div class="main-container">
      <div class="content-wrapper">
        <div class="left-section">
          <h2 class="reservation-title">
            <a href="javascript:history.back()" class="back-button"
              ><i class="ph ph-caret-left"></i
            ></a>
            예약 확인 및 결제
          </h2>
          <div class="left-wrapper-box">
            <div class="reservation-box">
              <div class="section-title">예약 일정</div>
              <div class="reservation-dates">
                <div class="date-item">
                  체크인<br /><strong class="date-text">8.18(월) 16:00</strong>
                </div>
                <div class="night">1박</div>
                <div class="date-item">
                  체크아웃<br /><strong class="date-text"
                    >8.19(화) 12:00</strong
                  >
                </div>
              </div>
            </div>

            <div class="reservation-box">
              <div class="section-title">예약 인원</div>
              <div class="info-item">성인 2명</div>
            </div>

            <div class="reservation-box">
              <div class="section-title">예약자 정보</div>
              <div class="info-item">
                나현규, <span>nahyeongyu@naver.com</span>
              </div>
              <div class="info-item">+82 <span>01093242517</span></div>
            </div>

            <div class="reservation-box">
              <div class="section-title">요청사항</div>
              <textarea
                placeholder="요청사항을 입력해주세요."
                class="request-textarea"
              ></textarea>
            </div>

            <div class="price-detail-box">
              <h3>요금 상세</h3>
              <div class="price-item">
                객실 요금
                <div>₩207,000</div>
              </div>

              <div class="price-item">
                인원 추가
                <div>₩0</div>
              </div>
              <div class="price-item total">
                총 결제 금액
                <div>₩207,000</div>
              </div>
            </div>

            <div class="payment-method-box">
              <h3>결제 수단</h3>
              <div class="payment-option active" data-payment="bank">
                무통장입금
              </div>
              <div class="payment-option" data-payment="card">카드 결제</div>
              <div class="payment-option" data-payment="cash">현금</div>
              <div class="payment-option" data-payment="kakao">카카오페이</div>
              <div class="payment-option" data-payment="toss">토스페이</div>
            </div>

            <div class="terms-agreement-box">
              <div class="terms-item">
                <label class="terms-checkbox">
                  <input type="checkbox" id="agree-all" />
                  <span class="checkmark"></span>
                  사용자 약관 전체 동의
                </label>
              </div>

              <div class="terms-item sub-terms">
                <label class="terms-checkbox">
                  <input
                    type="checkbox"
                    class="sub-checkbox"
                    data-required="true"
                  />
                  <span class="checkmark"></span>
                  (필수) 개인정보 제 3자 제공 동의
                </label>
                <i class="ph ph-caret-right terms-arrow"></i>
              </div>

              <div class="terms-item sub-terms">
                <label class="terms-checkbox">
                  <input
                    type="checkbox"
                    class="sub-checkbox"
                    data-required="true"
                  />
                  <span class="checkmark"></span>
                  (필수) 미성년자(청소년) 투숙 기준 동의
                </label>
                <i class="ph ph-caret-right terms-arrow"></i>
              </div>

              <div class="terms-item sub-terms">
                <label class="terms-checkbox">
                  <input type="checkbox" class="sub-checkbox" />
                  <span class="checkmark"></span>
                  (필수) 스테이 환불 규정
                </label>
                <i class="ph ph-caret-right terms-arrow"></i>
              </div>

              <div class="terms-item sub-terms">
                <label class="terms-checkbox">
                  <input type="checkbox" class="sub-checkbox" />
                  <span class="checkmark"></span>
                  (필수) 스테이 이용규칙
                </label>
                <i class="ph ph-caret-right terms-arrow"></i>
              </div>
            </div>
          </div>
        </div>
        <div class="right-section">
          <div class="payment-summary-box">
            <h3 class="stay-name">오포짓 스탠다드</h3>
            <img
              src="${pageContext.request.contextPath}/resources/img/stay/staycarousel1.jpg"
              alt="객실 사진"
              class="room-image"
            />
            <div class="room-details">
              <p class="room-name">Terrace Room</p>
              <button class="view-room-button">객실 보기</button>
            </div>
            <div class="room-info">
              <p>기본형 / 기준 2명 (최대 2명)</p>
              <p>침구 1</p>
            </div>
            <button class="payment-button">
              <p><span class="payment-price">₩207,000 </span>결제하기</p>
            </button>
          </div>
        </div>
      </div>
    </div>

    <!-- 푸터 인클루드 -->
    <jsp:include page="../includes/footer.jsp" />
  </body>
</html>
