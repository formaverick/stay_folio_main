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
      href="${pageContext.request.contextPath}/resources/css/mypage/bookmark.css"
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
        <div class="results-group">
          <div class="stay-item" data-stay-id="1">
            <div class="search-stay-image">
              <img src="../../img/card1.png" alt="강남 럭셔리 호텔" />
              <button class="search-stay-wishlist" data-wishlist="false">
                <i class="ph ph-heart"></i>
              </button>
            </div>
            <div class="search-stay-content">
              <h3 class="search-stay-name">강남 럭셔리 호텔</h3>
              <div class="search-stay-location">
                <i class="ph ph-map-pin"></i>
                서울 / 강남구
              </div>
              <div class="search-stay-price">
                <div class="search-stay-price-main">
                  <span class="search-stay-price-current">₩180,000~</span>
                </div>
              </div>
            </div>
          </div>

          <div class="stay-item" data-stay-id="2">
            <div class="search-stay-image">
              <img src="../../img/card1.png" alt="홍대 부티크 호텔" />
              <div class="search-stay-promotion">프로모션</div>
              <button class="search-stay-wishlist" data-wishlist="false">
                <i class="ph ph-heart"></i>
              </button>
            </div>
            <div class="search-stay-content">
              <h3 class="search-stay-name">홍대 부티크 호텔</h3>
              <div class="search-stay-location">
                <i class="ph ph-map-pin"></i>
                서울 / 마포구
              </div>
              <div class="search-stay-price">
                <span class="search-stay-price-original">₩140,000</span>
                <div class="search-stay-price-main">
                  <span class="search-stay-price-discount">20%</span>
                  <span class="search-stay-price-current">₩112,000~</span>
                </div>
              </div>
            </div>
          </div>

          <div class="stay-item" data-stay-id="3">
            <div class="search-stay-image">
              <img src="../../img/card1.png" alt="이태원 부티크 호텔" />
              <div class="search-stay-promotion">프로모션</div>
              <button class="search-stay-wishlist" data-wishlist="true">
                <i class="ph ph-heart"></i>
              </button>
            </div>
            <div class="search-stay-content">
              <h3 class="search-stay-name">이태원 부티크 호텔</h3>
              <div class="search-stay-location">
                <i class="ph ph-map-pin"></i>
                서울 / 용산구
              </div>
              <div class="search-stay-price">
                <span class="search-stay-price-original">₩160,000</span>
                <div class="search-stay-price-main">
                  <span class="search-stay-price-discount">25%</span>
                  <span class="search-stay-price-current">₩120,000~</span>
                </div>
              </div>
            </div>
          </div>

          <div class="stay-item" data-stay-id="4">
            <div class="search-stay-image">
              <img src="../../img/card1.png" alt="잠실 패밀리 호텔" />
              <button class="search-stay-wishlist" data-wishlist="false">
                <i class="ph ph-heart"></i>
              </button>
            </div>
            <div class="search-stay-content">
              <h3 class="search-stay-name">잠실 패밀리 호텔</h3>
              <div class="search-stay-location">
                <i class="ph ph-map-pin"></i>
                서울 / 송파구
              </div>
              <div class="search-stay-price">
                <div class="search-stay-price-main">
                  <span class="search-stay-price-current">₩150,000~</span>
                </div>
              </div>
            </div>
          </div>

          <div class="stay-item" data-stay-id="5">
            <div class="search-stay-image">
              <img src="../../img/card1.png" alt="여의도 비즈니스 호텔" />
              <div class="search-stay-promotion">프로모션</div>
              <button class="search-stay-wishlist" data-wishlist="false">
                <i class="ph ph-heart"></i>
              </button>
            </div>
            <div class="search-stay-content">
              <h3 class="search-stay-name">여의도 비즈니스 호텔</h3>
              <div class="search-stay-location">
                <i class="ph ph-map-pin"></i>
                서울 / 영등포구
              </div>
              <div class="search-stay-price">
                <span class="search-stay-price-original">₩200,000</span>
                <div class="search-stay-price-main">
                  <span class="search-stay-price-discount">30%</span>
                  <span class="search-stay-price-current">₩140,000~</span>
                </div>
              </div>
            </div>
          </div>

          <div class="stay-item" data-stay-id="6">
            <div class="search-stay-image">
              <img src="../../img/card1.png" alt="건대 유스 호스텔" />
              <div class="search-stay-promotion">프로모션</div>
              <button class="search-stay-wishlist" data-wishlist="false">
                <i class="ph ph-heart"></i>
              </button>
            </div>
            <div class="search-stay-content">
              <h3 class="search-stay-name">건대 유스 호스텔</h3>
              <div class="search-stay-location">
                <i class="ph ph-map-pin"></i>
                서울 / 광진구
              </div>
              <div class="search-stay-price">
                <div class="search-stay-price-main">
                  <span class="search-stay-price-current">₩80,000~</span>
                </div>
              </div>
            </div>
          </div>

          <div class="stay-item" data-stay-id="7">
            <div class="search-stay-image">
              <img src="../../img/card1.png" alt="명동 시티 호텔" />
              <button class="search-stay-wishlist" data-wishlist="true">
                <i class="ph ph-heart"></i>
              </button>
            </div>
            <div class="search-stay-content">
              <h3 class="search-stay-name">명동 시티 호텔</h3>
              <div class="search-stay-location">
                <i class="ph ph-map-pin"></i>
                서울 / 중구
              </div>
              <div class="search-stay-price">
                <span class="search-stay-price-original">₩180,000</span>
                <div class="search-stay-price-main">
                  <span class="search-stay-price-discount">25%</span>
                  <span class="search-stay-price-current">₩135,000~</span>
                </div>
              </div>
            </div>
          </div>

          <div class="stay-item" data-stay-id="8">
            <div class="search-stay-image">
              <img src="../../img/card1.png" alt="신촌 게스트하우스" />
              <button class="search-stay-wishlist" data-wishlist="false">
                <i class="ph ph-heart"></i>
              </button>
            </div>
            <div class="search-stay-content">
              <h3 class="search-stay-name">신촌 게스트하우스</h3>
              <div class="search-stay-location">
                <i class="ph ph-map-pin"></i>
                서울 / 서대문구
              </div>
              <div class="search-stay-price">
                <div class="search-stay-price-main">
                  <span class="search-stay-price-current">₩65,000~</span>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
    <jsp:include page="includes/footer.jsp" />
  </body>
</html>
