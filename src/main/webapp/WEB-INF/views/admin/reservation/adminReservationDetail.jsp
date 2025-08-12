<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %> <%@
taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <%@ taglib
prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<fmt:setLocale value="ko_KR" />
<c:set
  var="s3BaseUrl"
  value="https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/"
/>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <title>예약상세 - STAY FOLIO ADMIN</title>
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/common.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/room/roomList.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/room/roomRegister.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/room/roomDetail.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/admin/reservation/adminReservationDetail.css"
    />
    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
  </head>
  <body>
    <div class="admin-container">
      <!-- 좌측 사이드바 -->
      <aside class="admin-sidebar">
        <div class="admin-logo">
          <div class="logo-text">STAY<br />FOLIO</div>
          <div class="admin-text">ADMIN</div>
        </div>
        <nav class="admin-nav">
          <ul>
            <li><a href="/admin/dashboard" class="nav-item">대시보드</a></li>
            <li>
              <a href="/admin/reservation/list" class="nav-item active"
                >예약관리</a
              >
            </li>
            <li>
              <a href="/admin/stay/staylist" class="nav-item">숙소관리</a>
            </li>
            <li><a href="/admin/member/list" class="nav-item">회원관리</a></li>
            <li>
              <a href="/admin/dashboard#category-section" class="nav-item"
                >페이지관리</a
              >
            </li>
          </ul>
        </nav>
      </aside>

      <!-- 우측 컨텐츠 -->
      <main class="admin-main admin-reservation-detail">
        <div class="admin-header">
          <div class="header-content">
            <div class="header-left">
              <h1 class="page-title">예약상세</h1>
              <p class="page-subtitle">예약 정보를 확인하세요.</p>
            </div>
            <div class="header-right">
              <form
                action="/admin/reservation/list"
                method="get"
                style="display: inline-block"
              >
                <button type="submit" class="btn-save">예약 목록 보기</button>
              </form>
            </div>
          </div>
        </div>

        <div class="register-form-container">
          <div class="register-form">
            <!-- 상단 요약 박스 -->
            <section class="form-section">
              <h2 class="section-title">예약 요약</h2>
              <div class="form-grid">
                <div class="form-group">
                  <label class="form-label">예약 번호</label>
                  <div class="form-text-readonly">
                    ${reservationDetailVO.srId} (
                    <c:choose>
                      <c:when test="${reservationDetailVO.srStatus eq 'a'}"
                        >예약 완료</c:when
                      >
                      <c:when test="${reservationDetailVO.srStatus eq 'b'}"
                        >취소 대기</c:when
                      >
                      <c:when test="${reservationDetailVO.srStatus eq 'c'}"
                        >취소 완료</c:when
                      >
                      <c:when test="${reservationDetailVO.srStatus eq 'd'}"
                        >예약 대기</c:when
                      >
                      <c:otherwise>${reservationDetailVO.srStatus}</c:otherwise>
                    </c:choose>
                    :
                    <c:choose>
                      <c:when test="${reservationDetailVO.srStatus eq 'c'}">
                        <fmt:formatDate
                          value="${reservationDetailVO.srCancledate}"
                          pattern="yyyy.MM.dd HH:mm"
                        />
                      </c:when>
                      <c:otherwise>
                        <fmt:formatDate
                          value="${reservationDetailVO.srDate}"
                          pattern="yyyy.MM.dd HH:mm"
                        />
                      </c:otherwise>
                    </c:choose>
                    )
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label">예약 상태</label>
                  <div class="form-text-readonly">
                    <c:choose>
                      <c:when test="${reservationDetailVO.srStatus eq 'a'}">예약 완료</c:when>
                      <c:when test="${reservationDetailVO.srStatus eq 'b'}">취소 대기</c:when>
                      <c:when test="${reservationDetailVO.srStatus eq 'c'}">취소 완료</c:when>
                      <c:when test="${reservationDetailVO.srStatus eq 'd'}">예약 대기</c:when>
                      <c:otherwise>${reservationDetailVO.srStatus}</c:otherwise>
                    </c:choose>
                    :
                    <c:choose>
                      <c:when test="${reservationDetailVO.srStatus eq 'c'}">
                        <fmt:formatDate value="${reservationDetailVO.srCancledate}" pattern="yyyy.MM.dd HH:mm" />
                      </c:when>
                      <c:otherwise>
                        <fmt:formatDate value="${reservationDetailVO.srDate}" pattern="yyyy.MM.dd HH:mm" />
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label">스테이 / 객실</label>
                  <div class="form-text-readonly">
                    ${reservationDetailVO.siName} /
                    ${reservationDetailVO.riName}
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label">예약자</label>
                  <div class="form-text-readonly">
                    ${reservationDetailVO.srName}
                    (${reservationDetailVO.srPhone})
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label">이메일</label>
                  <div class="form-text-readonly">
                    ${reservationDetailVO.srEmail}
                  </div>
                </div>
              </div>
            </section>

            <!-- 일정 및 인원 -->
            <section class="form-section">
              <h2 class="section-title">이용 일정 / 인원</h2>
              <div class="form-grid">
                <div class="form-group">
                  <label class="form-label">체크인</label>
                  <div class="form-text-readonly">
                    <fmt:formatDate
                      value="${reservationDetailVO.srCheckin}"
                      pattern="yyyy.MM.dd HH:mm"
                    />
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label">체크아웃</label>
                  <div class="form-text-readonly">
                    <fmt:formatDate
                      value="${reservationDetailVO.srCheckout}"
                      pattern="yyyy.MM.dd HH:mm"
                    />
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label">숙박 인원</label>
                  <div class="form-text-readonly">
                    총 ${reservationDetailVO.srAdult +
                    reservationDetailVO.srChild}명 (성인:
                    ${reservationDetailVO.srAdult} / 아동:
                    ${reservationDetailVO.srChild})
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label">숙박 일수</label>
                  <div class="form-text-readonly">
                    ${reservationDetailVO.nights} 박
                  </div>
                </div>
              </div>
            </section>

            <!-- 결제 정보 -->
            <section class="form-section">
              <h2 class="section-title">결제 정보</h2>
              <div class="form-grid">
                <div class="form-group">
                  <label class="form-label">총 결제 금액</label>
                  <div class="form-text-readonly">
                    <strong>
                      <fmt:formatNumber
                        value="${reservationDetailVO.srTotalprice}"
                        pattern=",###,###원"
                      />
                    </strong>
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label">결제 방법</label>
                  <div class="form-text-readonly">
                    ${reservationDetailVO.srPayment}
                  </div>
                </div>
                <div class="form-group">
                  <label class="form-label">결제 상태</label>
                  <div class="form-text-readonly">
                    <c:choose>
                      <c:when
                        test="${reservationDetailVO.srPaymentstatus eq 'a'}"
                        >결제 대기</c:when
                      >
                      <c:when
                        test="${reservationDetailVO.srPaymentstatus eq 'b'}"
                        >결제 완료</c:when
                      >
                      <c:when
                        test="${reservationDetailVO.srPaymentstatus eq 'c'}"
                        >결제 취소</c:when
                      >
                      <c:otherwise
                        >${reservationDetailVO.srPaymentstatus}</c:otherwise
                      >
                    </c:choose>
                    :
                    <c:choose>
                      <c:when
                        test="${reservationDetailVO.srPaymentstatus eq 'c'}"
                      >
                        <fmt:formatDate
                          value="${reservationDetailVO.srCancledate}"
                          pattern="yyyy.MM.dd HH:mm"
                        />
                      </c:when>
                      <c:otherwise>
                        <fmt:formatDate
                          value="${reservationDetailVO.srPaydate}"
                          pattern="yyyy.MM.dd HH:mm"
                        />
                      </c:otherwise>
                    </c:choose>
                  </div>
                </div>
              </div>
            </section>

            <!-- 요청사항 -->
            <section class="form-section">
              <h2 class="section-title">요청사항</h2>
              <div class="form-grid">
                <div class="form-group full-width">
                  <label class="form-label">요청사항</label>
                  <div class="form-text-readonly">
                    ${reservationDetailVO.srRequest ne null ?
                    reservationDetailVO.srRequest : '없음'}
                  </div>
                </div>
              </div>
            </section>
          </div>
        </div>
      </main>
    </div>
  </body>
</html>
