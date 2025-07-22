<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>숙소 목록 - STAY FOLIO</title>
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
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <!-- jQuery -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
  </head>
  <body>
    <!-- Header Include -->
    <jsp:include page="../includes/header.jsp" />

    <!-- 숙소 목록 -->
    <main class="stay-main">
      <div class="stay-container">
        <div class="stay-header">
          <h1>숙소 목록</h1>
          <p>원하는 숙소를 찾아보세요</p>
        </div>

        <div class="stay-grid">
          <!-- 숙소 카드들이 여기에 렌더링됩니다 -->
        </div>
      </div>
    </main>
  </body>
</html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>숙소 상세 - STAY FOLIO</title>
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
      href="${pageContext.request.contextPath}/resources/css/stay/stay.css"
    />
    <link
      rel="stylesheet"
      href="${pageContext.request.contextPath}/resources/css/stay/stayCarousel.css"
    />

    <link
      rel="stylesheet"
      href="https://cdn.jsdelivr.net/gh/orioncactus/pretendard/dist/web/static/pretendard.css"
    />
    <script src="https://unpkg.com/@phosphor-icons/web"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <!-- Carousel JS -->
    <script src="${pageContext.request.contextPath}/resources/js/stay/stayCarousel.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/stay/stayNavigation.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/stay/stay.js"></script>
  </head>
  <body>
    <!-- 헤더 인클루드 -->
    <jsp:include page="../includes/header.jsp" />

    <!-- 숙소 캐러셀 시작 -->
    <section class="carousel-container">
      <!-- 뒤로가기 버튼 -->
      <a href="javascript:history.back()" class="back-button">
        <i class="ph ph-arrow-left"></i>
      </a>
      <div class="carousel">
        <div class="carousel-track">
          <div class="carousel-slide active">
            <img
              src="${pageContext.request.contextPath}/resources/img/stay/staycarousel1.jpg"
              alt="숙소이미지1"
            />
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/stay/staycarousel2.jpg"
              alt="숙소이미지2"
            />
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/stay/staycarousel3.jpg"
              alt="숙소이미지3"
            />
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/stay/staycarousel4.jpg"
              alt="숙소이미지4"
            />
          </div>
          <div class="carousel-slide">
            <img
              src="${pageContext.request.contextPath}/resources/img/stay/staycarousel5.jpg"
              alt="숙소이미지5"
            />
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
        </div>
      </div>
    </section>
    <!-- 숙소 캐러셀 끝 -->

    <!-- 숙소 정보 시작 -->
    <section class="stay-info-container">
      <div class="stay-info">
        <div class="stay-header">
          <div class="title-row">
            <h1>오포짓 스탠다드</h1>
            <button class="heart-btn"><i class="ph ph-heart"></i></button>
          </div>
          <div class="stay-location">서울, 은평구</div>
        </div>
        <div class="stay-stats">
          <span class="views"><i class="ph ph-heart"></i> 2621</span>
        </div>

        <div class="amenity-title">편의시설</div>
        <div class="stay-amenities">
          <div class="amenity">
            <i class="ph ph-tree"></i>
            <span>야외가구</span>
          </div>
          <div class="amenity">
            <i class="ph ph-sun"></i>
            <span>썬베드</span>
          </div>
          <div class="amenity">
            <i class="ph ph-table"></i>
            <span>빅테이블</span>
          </div>
          <div class="amenity">
            <i class="ph ph-house"></i>
            <span>테라스</span>
          </div>
          <div class="amenity">
            <i class="ph ph-tent"></i>
            <span>캠핑테이블체어</span>
          </div>

          <!-- 화장실/스파 -->
          <div class="amenity">
            <i class="ph ph-toilet"></i>
            <span>독립 화장실</span>
          </div>
          <div class="amenity">
            <i class="ph ph-shower"></i>
            <span>공용 샤워실</span>
          </div>
          <div class="amenity">
            <i class="ph ph-shower"></i>
            <span>샤워실</span>
          </div>
          <div class="amenity">
            <i class="ph ph-bathtub"></i>
            <span>월풀 스파</span>
          </div>
          <div class="amenity">
            <i class="ph ph-swimming-pool"></i>
            <span>수영장</span>
          </div>
          <div class="amenity">
            <i class="ph ph-swimming-pool"></i>
            <span>공용 수영장</span>
          </div>
          <div class="amenity">
            <i class="ph ph-bathtub"></i>
            <span>노천탕</span>
          </div>
          <div class="amenity">
            <i class="ph ph-bathtub"></i>
            <span>반신욕</span>
          </div>
          <div class="amenity">
            <i class="ph ph-bathtub"></i>
            <span>오픈 배스</span>
          </div>

          <!-- 식사/취사 -->
          <div class="amenity">
            <i class="ph ph-coffee"></i>
            <span>조식</span>
          </div>
          <div class="amenity">
            <i class="ph ph-fork-knife"></i>
            <span>아침식사</span>
          </div>
          <div class="amenity">
            <i class="ph ph-coffee"></i>
            <span>웰컴티</span>
          </div>
          <div class="amenity">
            <i class="ph ph-cooking-pot"></i>
            <span>취사</span>
          </div>
          <div class="amenity">
            <i class="ph ph-knife"></i>
            <span>독립 키친</span>
          </div>
          <div class="amenity">
            <i class="ph ph-fire"></i>
            <span>바베큐</span>
          </div>
          <div class="amenity">
            <i class="ph ph-fire"></i>
            <span>개별 BBQ데크</span>
          </div>

          <!-- 기타 편의시설 -->
          <div class="amenity">
            <i class="ph ph-car"></i>
            <span>주차</span>
          </div>
          <div class="amenity">
            <i class="ph ph-projector-screen"></i>
            <span>빔 프로젝터</span>
          </div>
          <div class="amenity">
            <i class="ph ph-television"></i>
            <span>TV / 빔프로젝터</span>
          </div>
          <div class="amenity">
            <i class="ph ph-tree"></i>
            <span>정원</span>
          </div>
          <div class="amenity">
            <i class="ph ph-footprints"></i>
            <span>산책로</span>
          </div>
          <div class="amenity">
            <i class="ph ph-dog"></i>
            <span>반려동물</span>
          </div>
        </div>

        <!-- 미니 네비게이션 -->
        <div class="stay-nav-container" id="stay-nav-container">
          <nav class="stay-nav">
            <ul>
              <li class="active"><a href="#stay-intro">스테이 소개</a></li>
              <li><a href="#room-select">객실 선택</a></li>
              <!-- <li><a href="#reviews">리뷰</a></li> -->
              <li><a href="#location-info">위치 및 정보</a></li>
              <li><a href="#guidelines">안내사항</a></li>
            </ul>
          </nav>
        </div>

        <!-- 스테이 소개 섹션 -->
        <section id="stay-intro" class="stay-section">
          <!-- 1. 타이틀 -->
          <h2 class="section-title">
            정해진 틀을 벗어나 나만의 새로운 관점을 가지다
          </h2>

          <!-- 2. 대표이미지 1 -->
          <div class="stay-main-image">
            <img
              src="${pageContext.request.contextPath}/resources/img/stay/staycarousel2.jpg"
              alt="오포짓 스탠다드 외관"
              class="full-width-image"
            />
          </div>

          <!-- 3. 대표이미지 1 설명 -->
          <div class="stay-description-main">
            <p>
              서울시 은평구는 조용한 거주지역이지만 골목 사이에 감각적인 식당과
              카페가 숨겨져 있는 동네입니다. 넓은 테라스에서 북한산의 유려한
              능선을 관망할 수 있는 '오포짓 스탠다드'가 있습니다. 정해진 틀을
              벗어나 새로운 방향으로 경험과 문화를 만들어 가는 문화복합공간으로,
              일상적인 기준의 바깥에서 스스로를 객관적으로 바라볼 수 있도록
              기획되었습니다. 트렌디한 카페, 영감을 주는 리스닝 바, 테라스,
              객실로 이어지는 이곳에서의 산책은 각자 편안한 형태의 시간으로
              다가옵니다.
            </p>
          </div>

          <!-- 4. 대표이미지 2 -->
          <div class="stay-main-image">
            <img
              src="${pageContext.request.contextPath}/resources/img/stay/staycarousel3.jpg"
              alt="오포짓 스탠다드 내부"
              class="full-width-image"
            />
          </div>

          <!-- 5. 대표이미지 2 설명 -->
          <div class="stay-description-main">
            <p>
              들어가는 순간부터 나올 때까지 머무르는 이의 동선은 자연스러운
              흐름을 이룹니다. 카페와 리스닝 바, 바깥을 바라보는 테라스와 편안한
              침실까지 자유롭게 지낼 수 있습니다. 일상의 건너편, 기준의 바깥에서
              오롯이 나에게 집중하는 시간을 가져보면 어떨까요. 자신만의 고유한
              리듬에 맞추어 머물고, 거닐며 표현해보세요.
            </p>
          </div>

          <!-- 6. 주요특징(서브타이틀) -->
          <h3 class="feature-title">주요 특징</h3>

          <!-- 7. 사진 3개 영역 1 -->
          <div class="photo-group">
            <div class="photo-item">
              <img
                src="${pageContext.request.contextPath}/resources/img/stay/stayimg1.jpg"
                alt="특징 1-1"
              />
            </div>
            <div class="photo-item">
              <img
                src="${pageContext.request.contextPath}/resources/img/stay/stayimg2.jpg"
                alt="특징 1-2"
              />
            </div>
            <div class="photo-item">
              <img
                src="${pageContext.request.contextPath}/resources/img/stay/stayimg3.jpg"
                alt="특징 1-3"
              />
            </div>
          </div>

          <!-- 8. 설명 1 -->
          <div class="feature-description">
            <h4>TERRACE</h4>
            <p>
              낮에는 북한산의 유려한 능선을 감상하고 밤에는 서울의 야경을 볼 수
              있는 아늑한 공간입니다. 편안하고 자유롭게 프라이빗한 시간을
              보내세요.
            </p>
          </div>

          <!-- 9. 사진 3개 영역 2 -->
          <div class="photo-group">
            <div class="photo-item">
              <img
                src="${pageContext.request.contextPath}/resources/img/stay/stayimg4.jpg"
                alt="특징 2-1"
              />
            </div>
            <div class="photo-item">
              <img
                src="${pageContext.request.contextPath}/resources/img/stay/stayimg5.jpg"
                alt="특징 2-2"
              />
            </div>
            <div class="photo-item">
              <img
                src="${pageContext.request.contextPath}/resources/img/stay/stayimg6.jpg"
                alt="특징 2-3"
              />
            </div>
          </div>

          <!-- 10. 설명 2 -->
          <div class="feature-description">
            <h4>MUSTARD CAFE</h4>
            <p>
              카페이자 라이프 굿즈가 구비되어 있는 웰컴 플레이스가 1층에
              있습니다. 신선한 음료와 베이커리, 계절음료를 만나보세요.
            </p>
          </div>

          <!-- 11. 사진 3개 영역 3 -->
          <div class="photo-group">
            <div class="photo-item">
              <img
                src="${pageContext.request.contextPath}/resources/img/stay/stayimg7.jpg"
                alt="특징 3-1"
              />
            </div>
            <div class="photo-item">
              <img
                src="${pageContext.request.contextPath}/resources/img/stay/stayimg8.jpg"
                alt="특징 3-2"
              />
            </div>
            <div class="photo-item">
              <img
                src="${pageContext.request.contextPath}/resources/img/stay/stayimg9.jpg"
                alt="특징 3-3"
              />
            </div>
          </div>

          <!-- 12. 설명 3 -->
          <div class="feature-description">
            <h4>DEBLAUX BAR</h4>
            <p>
              ALTEC LANSING, JBL, OJAS by DEVON TURNBULL 등 하이파이 사운드
              시스템으로 구성된 리스닝 바가 있습니다. 엄선된 메뉴와 무드를
              즐겨보세요.
            </p>
          </div>
        </section>

        <!-- 객실 선택 섹션 -->
        <section id="room-select" class="stay-section">
          <h2 class="section-title">객실 선택</h2>
          <div class="room-list">
            <div class="room-card">
              <div class="room-image">
                <img
                  src="${pageContext.request.contextPath}/resources/img/stay/stayimg1.jpg"
                  alt="Terrace Room"
                />
              </div>
              <div class="room-info">
                <h3>Terrace Room</h3>
                <p class="room-capacity">기본형 / 기준 2명 (최대 2명)</p>
                <p class="room-amenity">침구 1</p>
                <div class="room-price-container">
                  <div class="price-info">
                    <div class="original-price">₩230,000</div>
                    <div class="discount-price">
                      <span class="discount-rate">2%</span>
                      <span class="final-price">₩225,000 ~</span>
                      <span class="per-night">/ 박</span>
                    </div>
                  </div>
                  <button class="room-select-btn">객실 선택</button>
                </div>
              </div>
            </div>
          </div>
        </section>

        <!-- 위치 및 정보 섹션 -->
        <section id="location-info" class="stay-section">
          <h2 class="section-title">위치 및 정보</h2>
          <div class="location-info-container">
            <div class="location-details">
              <p>
                오포짓 스탠다드의 위치는 [ 서울시 은평구 서오로 17 ] 입니다.
              </p>
              <p>건물 내부에 전용 주차장이 마련되어 있습니다.</p>
              <div class="contact-info">
                <div class="contact-item">
                  <i class="ph ph-phone"></i>
                  <span>02-555-7001</span>
                </div>
                <div class="contact-item">
                  <i class="ph ph-envelope"></i>
                  <span>info@oppositestandard.com</span>
                </div>
                <div class="contact-item">
                  <i class="ph ph-instagram-logo"></i>
                  <span>@opposite_standard</span>
                </div>
              </div>
            </div>
          </div>
          <!-- 카카오맵 영역 -->
          <div class="location-map">
            <div id="map" style="width: 100%; height: 400px"></div>
          </div>
        </section>

        <!-- 안내사항 섹션 -->
        <section id="guidelines" class="stay-section">
          <h2 class="section-title">안내사항</h2>
          <div class="guidelines-content">
            <!-- 예약 안내 아코디언 -->
            <div class="accordion-item">
              <div class="accordion-header">
                <h3>예약 안내</h3>
                <span class="accordion-icon"
                  ><i class="ph ph-caret-down"></i
                ></span>
              </div>
              <div class="accordion-content">
                <p>기준인원 초과 시 추가 금액이 부과될 수 있습니다.</p>
                <p>기준인원을 초과한 예약에는 추가 침구가 제공됩니다.</p>
                <p>반려 동물 동반이 [가능/불가능] 한 숙소입니다.</p>
              </div>
            </div>

            <!-- 이용 안내 아코디언 -->
            <div class="accordion-item">
              <div class="accordion-header">
                <h3>이용 안내</h3>
                <span class="accordion-icon"
                  ><i class="ph ph-caret-down"></i
                ></span>
              </div>
              <div class="accordion-content">
                <p>
                  체크인은 [체크인 시간]시, 체크아웃은 [체크아웃 시간]시 입니다.
                </p>
                <p>
                  미성년자의 경우 보호자(법정대리인)의 동행 없이 투숙이
                  불가능합니다.
                </p>
                <p>
                  화재 위험 및 쾌적한 환경 유지를 위해 실내 흡연은 절대
                  불가합니다.
                </p>
                <p>침구나 비품의 오염, 파손 및 분실 시 변상비가 청구됩니다.</p>
                <p>귀중품 분실에 대해서는 책임지지 않습니다.</p>
                <p>주차 [가능/불가능]한 숙소입니다.</p>
                <p>취식이 [가능/불가능]한 숙소입니다.</p>
              </div>
            </div>

            <!-- 환불 안내 아코디언 -->
            <div class="accordion-item">
              <div class="accordion-header">
                <h3>환불 안내</h3>
                <span class="accordion-icon"
                  ><i class="ph ph-caret-down"></i
                ></span>
              </div>
              <div class="accordion-content">
                <p>
                  <strong
                    >숙박권의 재판매를 비롯하여 양도, 양수, 교환을
                    금지합니다.</strong
                  >
                </p>
                <p>체크인 7일 전: 100% 환불</p>
                <p>체크인 3일 전: 50% 환불</p>
                <p>체크인 당일: 환불 불가</p>
                <p>천재지변, 기상 악화로 인한 예약 취소: 100% 환불</p>
                <p>
                  숙소 사정으로 인한 예약 취소: 100% 환불 또는 대체 숙소 제공
                </p>
              </div>
            </div>
          </div>
        </section>
      </div>
    </section>
    <!-- 숙소 정보 끝 -->

    <!-- 푸터 인클루드 -->
    <jsp:include page="../includes/footer.jsp" />

    <!-- 카카오맵 API -->
    <script
      type="text/javascript"
      src="//dapi.kakao.com/v2/maps/sdk.js?appkey=YOUR_APP_KEY"
    ></script>
    <script>
      $(document).ready(function () {
        // 카카오맵 초기화
        var container = document.getElementById("map");
        var options = {
          center: new kakao.maps.LatLng(37.6095, 126.9268), // 은평구 좌표
          level: 3,
        };
        var map = new kakao.maps.Map(container, options);

        // 마커 추가
        var markerPosition = new kakao.maps.LatLng(37.6095, 126.9268);
        var marker = new kakao.maps.Marker({
          position: markerPosition,
        });
        marker.setMap(map);
      });
    </script>
  </body>
</html>
