// 숙소 카드 캐러셀 전용 JavaScript - 상단 캐러셀과 완전 독립

// DOM 로드 완료 후 실행
document.addEventListener("DOMContentLoaded", function () {
  console.log("숙소 카드 캐러셀 초기화 시작");

  // 숙소 캐러셀 이벤트 리스너 초기화
  initStayCarouselEvents();
  // 찜하기 기능 초기화
  initWishlistEvents();
});

// 숙소 캐러셀 이벤트 리스너 초기화
function initStayCarouselEvents() {
  const stayCarousel = document.querySelector(".stay-carousel");
  const stayTrack = document.querySelector(".stay-carousel-track");
  const prevBtn = document.getElementById("stayPrevBtn");
  const nextBtn = document.getElementById("stayNextBtn");
  const slides = document.querySelectorAll(".stay-grid");

  let currentSlide = 0;
  const maxSlide = slides.length;

  function updateSlidePosition() {
    if (slides.length === 0) return;
    const slideWidth = slides[0].clientWidth;
    stayTrack.style.transform = `translateX(-${slideWidth * currentSlide}px)`;
    updateNavigationButtons();
    console.log(`슬라이드 ${currentSlide + 1}/${maxSlide}로 이동`);
  }

  function updateNavigationButtons() {
    if (prevBtn) {
      prevBtn.style.display = currentSlide === 0 ? "none" : "flex";
      prevBtn.disabled = currentSlide === 0;
    }
    if (nextBtn) {
      nextBtn.style.display = currentSlide === maxSlide - 1 ? "none" : "flex";
      nextBtn.disabled = currentSlide === maxSlide - 1;
    }
  }

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

  // 초기 위치 및 버튼 상태 설정
  updateSlidePosition();

  // 윈도우 리사이즈 시 슬라이드 위치 재조정
  window.addEventListener("resize", () => {
    updateSlidePosition();
  });
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
