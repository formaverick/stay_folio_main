// 숙소 카드 캐러셀 전용 JavaScript - 상단 캐러셀과 완전 독립

// DOM 로드 완료 후 실행
//document.addEventListener("DOMContentLoaded", function () {
//  console.log("숙소 카드 캐러셀 초기화 시작");

//  숙소 캐러셀 이벤트 리스너 초기화
//  initStayCarouselEvents();
//  찜하기 기능 초기화
//  initWishlistEvents();
//});

function initStayCarouselEvents(rc_id) {
  const track = document.getElementById(`track-${rc_id}`);
  const prevBtn = document.getElementById(`stayPrevBtn-${rc_id}`);
  const nextBtn = document.getElementById(`stayNextBtn-${rc_id}`);
  const slides = track.querySelectorAll(".stay-grid");

  if (!track || slides.length === 0) {
    console.warn(`캐러셀 초기화 실패: track-${rc_id} 또는 슬라이드 없음`);
    return;
  }

  let currentSlide = 0;
  let maxSlide = slides.length;

  function updateSlidePosition() {
    const slideWidth = slides[0]?.clientWidth || 0;
    track.style.transform = `translateX(-${slideWidth * currentSlide}px)`;

    // 이전 버튼
    if (prevBtn) {
      prevBtn.style.display = currentSlide === 0 ? "none" : "flex";
      prevBtn.disabled = currentSlide === 0;
    }

    // 다음 버튼
    if (nextBtn) {
      nextBtn.style.display = currentSlide >= maxSlide - 1 ? "none" : "flex";
      nextBtn.disabled = currentSlide >= maxSlide - 1;
    }
  }

  // 버튼 이벤트 연결
  if (prevBtn) {
    prevBtn.addEventListener("click", () => {
      if (currentSlide > 0) {
        currentSlide--;
        updateSlidePosition();
      }
    });
  }

  if (nextBtn) {
    nextBtn.addEventListener("click", () => {
      if (currentSlide < maxSlide - 1) {
        currentSlide++;
        updateSlidePosition();
      }
    });
  }

  // 창 크기 바뀔 때 위치 재조정
  window.addEventListener("resize", updateSlidePosition);

  // 초기 위치 설정
  updateSlidePosition();
}

// 찜하기 기능 초기화 - 검색 페이지와 동일한 방식으로 간소화
function initWishlistEvents() {
  const wishlistButtons = document.querySelectorAll(".stay-wishlist");
  console.log("찜하기 버튼 개수:", wishlistButtons.length);

  wishlistButtons.forEach((button) => {
    button.addEventListener("click", function (e) {
      e.preventDefault();
      e.stopPropagation();

      const isWishlisted = this.getAttribute("data-wishlist") === "true";
      
      // 상태 토글
      this.setAttribute("data-wishlist", !isWishlisted);
      
      // 간단한 피드백
      if (!isWishlisted) {
        console.log("찜 목록에 추가되었습니다.");
      } else {
        console.log("찜 목록에서 제거되었습니다.");
      }
    });
  });

  // 카드 클릭 이벤트 (상세 페이지로 이동)
  const stayItems = document.querySelectorAll(".stay-item");
  stayItems.forEach((item) => {
    item.addEventListener("click", function() {
      const stayId = this.getAttribute("data-stay-id");
      console.log(`숙소 ${stayId} 상세 페이지로 이동`);
      // window.location.href = `/stay/detail/${stayId}`;
    });
  });
}
