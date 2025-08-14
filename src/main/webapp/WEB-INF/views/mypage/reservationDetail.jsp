<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%> <%@ taglib prefix="c"
uri="http://java.sun.com/jsp/jstl/core"%> <%@ taglib prefix="fmt"
uri="http://java.sun.com/jsp/jstl/fmt"%> <%@ taglib prefix="sec"
uri="http://www.springframework.org/security/tags"%>
<c:set
  var="s3BaseUrl"
  value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/"
/>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>예약 상세 - STAY FOLIO</title>
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
    <jsp:include page="../includes/header.jsp" />

    <main class="mypage-main">
      <div class="mypage-header">
        <sec:authentication property="principal" var="pinfo" />
        <h2 class="mypage-title">${pinfo.member.miName}님반가워요!</h2>
        <p class="mypage-subtitle">
          <fmt:formatDate
            value="${pinfo.member.miDate}"
            pattern="yyyy년 MM월"
          />
          부터 ${travelCount}번의 여행을 했어요.
        </p>
      </div>
      <div class="mypage-page">
        <div class="mypage-submenu">
          <ul class="submenu">
            <li class="active"><a href="/mypage/reservations">예약 정보</a></li>
            <li><a href="/mypage/bookmarks">북마크</a></li>
            <li><a href="#">회원정보 수정</a></li>
          </ul>
        </div>

        <div class="mypage-main">
          <div class="reserv-title">
            <h2>
              <a href="/mypage/reservations">예약 정보 ></a>
              ${reserv.siName}(#${reserv.srId})
            </h2>
          </div>
          <div class="reserv-box">
            <div class="reserv-info">
              <div class="info-title">
                <h3>${reserv.siName }</h3>
              </div>
              <div class="info-detail">
                <p>${reserv.siAddress }</p>
                <p>${reserv.siPhone }</p>
                <p>${reserv.siEmail }</p>
              </div>
            </div>
            <div class="reserv-image">
              <img src="${s3BaseUrl}${reserv.spUrl}" alt="${reserv.siName}" />
            </div>
          </div>
          <div class="reservation-status">
            <h3 class="status-title">예약 상태</h3>
            <jsp:useBean id="now" class="java.util.Date" />
            <div class="status-steps">
              <div
                class="step step-01 ${reserv.srStatus eq 'a' and reserv.srCheckin gt now ? 'active' : ''}"
              >
                <div class="icon">
                  <i class="ph ph-file-plus"></i>
                </div>
                <div class="step-title">STEP 01<br />예약 확정</div>
                <p class="step-desc">
                  호스트가 예약을 최종 확정한 상태입니다. 예약 취소 시 각
                  스테이의 환불규정에 따라 환불이 진행됩니다.
                </p>
              </div>
              <div
                class="step step-02 ${reserv.srStatus eq 'a' and reserv.srCheckin lt now and reserv.srCheckout gt now ? 'active' : ''}"
              >
                <div class="icon">
                  <i class="ph ph-check-circle"></i>
                </div>
                <div class="step-title">STEP 02<br />체크인</div>
                <p class="step-desc">
                  예약 내용에 따라 스테이를 이용할 수 있습니다. 예약 당일 오전
                  체크인 안내를 드리고 있습니다.
                </p>
              </div>
              <div
                class="step step-03 ${reserv.srStatus eq 'a' and reserv.srCheckout lt now ? 'active' : ''}"
              >
                <div class="icon">
                  <i class="ph ph-suitcase-simple"></i>
                </div>
                <div class="step-title">STEP 03<br />체크아웃</div>
                <p class="step-desc">스테이를 이용해 주셔서 감사합니다.</p>
              </div>
            </div>
          </div>
          <div class="reservation-detail-section">
            <h3>예약 안내</h3>
            <table class="reservation-info-table">
              <tr>
                <td class="reservation-info-title">01. 예약 번호</td>
                <td class="reservation-info-content">
                  ${reserv.srId }(
                  <c:choose>
                    <c:when test="${reserv.srStatus eq 'a'}">예약 완료</c:when>
                    <c:when test="${reserv.srStatus eq 'b'}">취소대기</c:when>
                    <c:when test="${reserv.srStatus eq 'c'}">취소완료</c:when>
                    <c:when test="${reserv.srStatus eq 'd'}">예약대기</c:when>
                  </c:choose>
                  :
                  <c:choose>
                    <c:when test="${reserv.srStatus eq 'c'}">
                      <fmt:formatDate
                        value="${reserv.srCancledate }"
                        pattern="yyyy.MM.dd HH:mm"
                      />
                    </c:when>
                    <c:otherwise>
                      <fmt:formatDate
                        value="${reserv.srDate }"
                        pattern="yyyy.MM.dd HH:mm"
                      />
                    </c:otherwise>
                  </c:choose>
                  )
                </td>
              </tr>
              <tr>
                <td class="reservation-info-title">02. 스테이 및 객실</td>
                <td class="reservation-info-content">
                  ${reserv.siName }/ ${reserv.riName }
                </td>
              </tr>
              <tr>
                <td class="reservation-info-title">03. 숙박 인원</td>
                <td class="reservation-info-content">
                  총 ${reserv.srAdult + reserv.srChild }명 (성인:
                  ${reserv.srAdult }명 / 아동: ${reserv.srChild }명)
                </td>
              </tr>
              <tr>
                <td class="reservation-info-title">04. 체크인</td>
                <td class="reservation-info-content">
                  <fmt:formatDate
                    value="${reserv.srCheckin }"
                    pattern="yyyy.MM.dd HH:mm"
                  />
                </td>
              </tr>
              <tr>
                <td class="reservation-info-title">05. 체크아웃</td>
                <td class="reservation-info-content">
                  <fmt:formatDate
                    value="${reserv.srCheckout }"
                    pattern="yyyy.MM.dd HH:mm"
                  />
                </td>
              </tr>
              <tr>
                <td class="reservation-info-title">06. 요청사항</td>
                <td class="reservation-info-content">
                  ${reserv.srRequest ne null ? reserv.srRequest : '없음' }
                </td>
              </tr>
              <tr>
                <td class="reservation-info-title">07. 예약자 정보</td>
                <td class="reservation-info-content">
                  예약자 이름 : ${empty reserv.srName ? '정보 없음' :
                  reserv.srName}<br />
                  예약자 이메일 : ${empty reserv.srEmail ? '정보 없음' :
                  reserv.srEmail}<br />
                  예약자 전화번호 : ${empty reserv.srPhone ? '정보 없음' :
                  reserv.srPhone}
                </td>
              </tr>
              <tr>
                <td class="reservation-info-title">08. 공지 포함</td>
                <td class="reservation-info-content">
                  <strong
                    >숙박권의 재판매, 양도, 양수, 교환을 금지합니다.</strong
                  ><br />
                  예약자의 부득이한 사유로 인해 본인 이용이 어려울 경우, 가족에
                  한해 해당 스테이에 가족관계임을 증명할 수 있는
                  서류(가족관계증명서 등)와 실제 이용하시는 분의 신분증을 제시
                  후 이용이 가능합니다.
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
                    객실 요금: ₩<fmt:formatNumber
                      value="${reserv.srRoomprice}"
                      type="number"
                      groupingUsed="true"
                    />
                  </p>
                  <p>
                    요금 할인: ₩<fmt:formatNumber
                      value="${reserv.srDiscount}"
                      type="number"
                      groupingUsed="true"
                    />
                  </p>
                  <p class="payment-add">
                    인원 추가: ₩<fmt:formatNumber
                      value="${reserv.srAddpersonFee}"
                      type="number"
                      groupingUsed="true"
                    />
                  </p>
                  <div class="payment-summary">
                    총 결제 금액
                    <span>
                      ₩<fmt:formatNumber
                        value="${reserv.srTotalprice}"
                        type="number"
                        groupingUsed="true"
                      />
                    </span>
                  </div>
                </td>
              </tr>
              <tr>
                <td class="reservation-info-title">02. 결제 방법</td>
                <td class="reservation-info-content">
                  ${reserv.srPayment }(
                  <c:choose>
                    <c:when test="${reserv.srPaymentstatus eq 'a'}"
                      >결제 대기</c:when
                    >
                    <c:when test="${reserv.srPaymentstatus eq 'b'}"
                      >결제 완료</c:when
                    >
                    <c:when test="${reserv.srPaymentstatus eq 'c'}"
                      >결제 취소</c:when
                    >
                  </c:choose>
                  :
                  <c:choose>
                    <c:when test="${reserv.srPaymentstatus eq 'c' }">
                      <fmt:formatDate
                        value="${reserv.srCancledate }"
                        pattern="yyyy.MM.dd HH:mm"
                      />
                    </c:when>
                    <c:otherwise>
                      <fmt:formatDate
                        value="${reserv.srPaydate }"
                        pattern="yyyy.MM.dd HH:mm"
                      />
                    </c:otherwise>
                  </c:choose>
                  )
                </td>
              </tr>
            </table>
          </div>
          <div class="reservation-detail-section">
            <div class="detail-bottom-buttons">
              <c:if
                test="${reserv.srStatus eq 'a' and reserv.srCheckin gt now}"
              >
                <button
                  onclick="location.href='${pageContext.request.contextPath}/mypage/reservations/${reserv.srId}/cancel'"
                >
                  예약 취소
                </button>
              </c:if>
              <button>이용 안내 및 환불 규정</button>
            </div>
          </div>
        </div>
      </div>
    </main>
    <jsp:include page="../includes/footer.jsp" />
  </body>
</html>
