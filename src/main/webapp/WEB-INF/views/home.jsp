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
      href="${pageContext.request.contextPath}/resources/css/main/carousel.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/stayCard.css"
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
    <!-- Carousel JS -->
    <script src="${pageContext.request.contextPath}/resources/js/main/carousel.js"></script>
    <!-- Stay Card Carousel JS -->
    <script src="${pageContext.request.contextPath}/resources/js/main/stayCardCarousel.js"></script>
  </head>
  <body>
    <!-- Header Include -->
    <jsp:include page="includes/header.jsp" />

    <!-- 메인 캐러셀 -->
    <section class="carousel-container">
      <div class="carousel">
        <div class="carousel-track">
          <div class="carousel-slide active">
            <img
              src="${pageContext.request.contextPath}/resources/img/carousel/carousel1.png"
              alt="캐러셀1"
            />
            <div class="carousel-content">
              <h2>이번 휴가는 가볍게,<br />서울 근교로 떠나요</h2>
              <p>
                가평, 인천, 종로, 마포 등<br />최대 24% 할인받아 여행을 준비해요
              </p>
            </div>
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/carousel/carousel2.png"
              alt="캐러셀2"
            />
            <div class="carousel-content">
              <h2>남원 프리미엄 한옥에서<br />시원하게 즐기는 여행</h2>
              <p>오픈 기념 최대 15% 할인!<br />가족과 함께 가볍게 떠나보세요</p>
            </div>
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/carousel/carousel3.png"
              alt="캐러셀3"
            />
            <div class="carousel-content">
              <h2>스테이폴리오 예약만 24번,<br />VIP 추천 스테이</h2>
              <p>
                특별한 기억으로 남은 단 7곳의 스테이<br />혜택과 함께 만나보아요
              </p>
            </div>
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/carousel/carousel4.png"
              alt="캐러셀4"
            />
            <div class="carousel-content">
              <h2>노천탕이 있는 오션뷰 스테이<br />딜문 숙박권 이벤트</h2>
              <p>50만원 상당 숙박권과<br />할인쿠폰을 놓치지 마세요</p>
            </div>
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/carousel/carousel5.png"
              alt="캐러셀5"
            />
            <div class="carousel-content">
              <h2>제주 동쪽 바다를 담은<br />로망 가득한 '로메니'</h2>
              <p>
                노천탕, 오션뷰 다락, 빔 프로젝터 등<br />15% 할인된 가격으로
                만나 보세요 보세요
              </p>
            </div>
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/carousel/carousel6.png"
              alt="캐러셀6"
            />
            <div class="carousel-content">
              <h2>익숙함을 벗어나<br />자연과 음악이 함께하는 곳</h2>
              <p>
                하늘이 열린 천창 욕조, 음악당 등<br />오픈 기념 20% 할인으로
                만나 보세요
              </p>
            </div>
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/carousel/carousel7.png"
              alt="캐러셀7"
            />
            <div class="carousel-content">
              <h2>싱그러운 여행을 선물해요<br />꼬마 탐험가들의 영어캠프</h2>
              <p>1박 2일 영어캠프,<br />객실 및 조식 패키지</p>
            </div>
          </div>
        </div>

        <!-- 네비게이션 버튼 -->
        <button class="carousel-btn carousel-btn-prev" type="button">
          <span>‹</span>
        </button>
        <button class="carousel-btn carousel-btn-next" type="button">
          <span>›</span>
        </button>

        <!-- 인디케이터 -->
        <div class="carousel-indicators">
          <button class="indicator active" data-slide="0"></button>
          <button class="indicator" data-slide="1"></button>
          <button class="indicator" data-slide="2"></button>
          <button class="indicator" data-slide="3"></button>
          <button class="indicator" data-slide="4"></button>
          <button class="indicator" data-slide="5"></button>
          <button class="indicator" data-slide="6"></button>
        </div>
      </div>
    </section>
    <!-- 메인 캐러셀 끝 -->

    <!-- 숙소 카드 캐러셀 섹션 -->
    <section class="stay-section">
      <div class="stay-container">
        <div class="stay-header">
          <div class="stay-title-area">
            <h2 class="stay-main-title">
              무더위에 멀리 가지 마세요, 가까워서 더 좋은 서울과 근교 여행
            </h2>
            <p class="stay-sub-title">8월 여행에서 최대 24% 할인 합께해요!</p>
          </div>
        </div>
      </div>
      <div class="stay-carousel-wrapper">
        <button class="stay-nav-btn stay-nav-prev" id="stayPrevBtn">
          <i class="ph ph-caret-left"></i>
        </button>
        <div class="stay-carousel">
          <div class="stay-carousel-track">
            <!-- 첫 번째 슬라이드 -->
            <div class="stay-grid">
              <div class="stay-item" data-stay-id="1">
                <div class="stay-image">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/card1.png"
                    alt="서울 명동 비즈니스 호텔"
                  />
                  <div class="stay-promotion">프로모션</div>
                  <button class="stay-wishlist" data-wishlist="false">
                    <i class="ph ph-heart"></i>
                  </button>
                </div>
                <div class="stay-content">
                  <h3 class="stay-name">서울 명동 비즈니스 호텔</h3>
                  <div class="stay-location">
                    <i class="ph ph-map-pin"></i>
                    서울 / 중구
                  </div>
                  <div class="stay-price">
                    <span class="stay-price-original">₩120,000</span>
                    <div class="stay-price-main">
                      <span class="stay-price-discount">21%</span>
                      <span class="stay-price-current">₩95,000~</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="stay-item" data-stay-id="2">
                <div class="stay-image">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/card1.png"
                    alt="강남 럭셔리 호텔"
                  />
                  <button class="stay-wishlist" data-wishlist="false">
                    <i class="ph ph-heart"></i>
                  </button>
                </div>
                <div class="stay-content">
                  <h3 class="stay-name">강남 럭셔리 호텔</h3>
                  <div class="stay-location">
                    <i class="ph ph-map-pin"></i>
                    서울 / 강남구
                  </div>
                  <div class="stay-price">
                    <div class="stay-price-main">
                      <span class="stay-price-current">₩180,000~</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="stay-item" data-stay-id="3">
                <div class="stay-image">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/card1.png"
                    alt="홍대 부티크 호텔"
                  />
                  <div class="stay-promotion">프로모션</div>
                  <button class="stay-wishlist" data-wishlist="false">
                    <i class="ph ph-heart"></i>
                  </button>
                </div>
                <div class="stay-content">
                  <h3 class="stay-name">홍대 부티크 호텔</h3>
                  <div class="stay-location">
                    <i class="ph ph-map-pin"></i>
                    서울 / 마포구
                  </div>
                  <div class="stay-price">
                    <span class="stay-price-original">₩140,000</span>
                    <div class="stay-price-main">
                      <span class="stay-price-discount">20%</span>
                      <span class="stay-price-current">₩112,000~</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- 두 번째 슬라이드 -->
            <div class="stay-grid">
              <div class="stay-item" data-stay-id="4">
                <div class="stay-image">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/card1.png"
                    alt="이태원 부티크 호텔"
                  />
                  <div class="stay-promotion">프로모션</div>
                  <button class="stay-wishlist" data-wishlist="false">
                    <i class="ph ph-heart"></i>
                  </button>
                </div>
                <div class="stay-content">
                  <h3 class="stay-name">이태원 부티크 호텔</h3>
                  <div class="stay-location">
                    <i class="ph ph-map-pin"></i>
                    서울 / 용산구
                  </div>
                  <div class="stay-price">
                    <span class="stay-price-original">₩160,000</span>
                    <div class="stay-price-main">
                      <span class="stay-price-discount">25%</span>
                      <span class="stay-price-current">₩120,000~</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="stay-item" data-stay-id="5">
                <div class="stay-image">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/card1.png"
                    alt="잠실 패밀리 호텔"
                  />
                  <button class="stay-wishlist" data-wishlist="false">
                    <i class="ph ph-heart"></i>
                  </button>
                </div>
                <div class="stay-content">
                  <h3 class="stay-name">잠실 패밀리 호텔</h3>
                  <div class="stay-location">
                    <i class="ph ph-map-pin"></i>
                    서울 / 송파구
                  </div>
                  <div class="stay-price">
                    <div class="stay-price-main">
                      <span class="stay-price-current">₩150,000~</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="stay-item" data-stay-id="6">
                <div class="stay-image">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/card1.png"
                    alt="여의도 비즈니스 호텔"
                  />
                  <div class="stay-promotion">프로모션</div>
                  <button class="stay-wishlist" data-wishlist="false">
                    <i class="ph ph-heart"></i>
                  </button>
                </div>
                <div class="stay-content">
                  <h3 class="stay-name">여의도 비즈니스 호텔</h3>
                  <div class="stay-location">
                    <i class="ph ph-map-pin"></i>
                    서울 / 영등포구
                  </div>
                  <div class="stay-price">
                    <span class="stay-price-original">₩180,000</span>
                    <div class="stay-price-main">
                      <span class="stay-price-discount">15%</span>
                      <span class="stay-price-current">₩153,000~</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>

            <!-- 세 번째 슬라이드 -->
            <div class="stay-grid">
              <div class="stay-item" data-stay-id="7">
                <div class="stay-image">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/card1.png"
                    alt="건대 유스 호스텔"
                  />
                  <div class="stay-promotion">프로모션</div>
                  <button class="stay-wishlist" data-wishlist="false">
                    <i class="ph ph-heart"></i>
                  </button>
                </div>
                <div class="stay-content">
                  <h3 class="stay-name">건대 유스 호스텔</h3>
                  <div class="stay-location">
                    <i class="ph ph-map-pin"></i>
                    서울 / 광진구
                  </div>
                  <div class="stay-price">
                    <span class="stay-price-original">₩80,000</span>
                    <div class="stay-price-main">
                      <span class="stay-price-discount">30%</span>
                      <span class="stay-price-current">₩56,000~</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="stay-item" data-stay-id="8">
                <div class="stay-image">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/card1.png"
                    alt="신촌 게스트하우스"
                  />
                  <button class="stay-wishlist" data-wishlist="false">
                    <i class="ph ph-heart"></i>
                  </button>
                </div>
                <div class="stay-content">
                  <h3 class="stay-name">신촌 게스트하우스</h3>
                  <div class="stay-location">
                    <i class="ph ph-map-pin"></i>
                    서울 / 서대문구
                  </div>
                  <div class="stay-price">
                    <div class="stay-price-main">
                      <span class="stay-price-current">₩45,000~</span>
                    </div>
                  </div>
                </div>
              </div>

              <div class="stay-item" data-stay-id="9">
                <div class="stay-image">
                  <img
                    src="${pageContext.request.contextPath}/resources/img/card1.png"
                    alt="성수동 부티크 호텔"
                  />
                  <div class="stay-promotion">프로모션</div>
                  <button class="stay-wishlist" data-wishlist="false">
                    <i class="ph ph-heart"></i>
                  </button>
                </div>
                <div class="stay-content">
                  <h3 class="stay-name">성수동 부티크 호텔</h3>
                  <div class="stay-location">
                    <i class="ph ph-map-pin"></i>
                    서울 / 성동구
                  </div>
                  <div class="stay-price">
                    <span class="stay-price-original">₩200,000</span>
                    <div class="stay-price-main">
                      <span class="stay-price-discount">18%</span>
                      <span class="stay-price-current">₩164,000~</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <button class="stay-nav-btn stay-nav-next" id="stayNextBtn">
          <i class="ph ph-caret-right"></i>
        </button>
      </div>
    </section>
    <!-- 숙소 카드 캐러셀 섹션 끝 -->

    <!-- Footer Include -->
    <jsp:include page="includes/footer.jsp" />
  </body>
</html>
