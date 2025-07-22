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

// 찜하기 기능 초기화
function initWishlistEvents() {
  const wishlistButtons = document.querySelectorAll(".stay-wishlist");
  console.log("찜하기 버튼 개수:", wishlistButtons.length);

  wishlistButtons.forEach((button, index) => {
    // 초기 상태 설정
    const icon = button.querySelector("i");
    const isWishlisted = button.getAttribute("data-wishlist") === "true";

    if (isWishlisted) {
      icon.className = "ph ph-heart-fill";
    } else {
      icon.className = "ph ph-heart";
    }

    button.addEventListener("click", function (e) {
      e.preventDefault();
      e.stopPropagation();

      console.log(`버튼 ${index} 클릭됨`);

      const icon = this.querySelector("i");
      const isWishlisted = this.getAttribute("data-wishlist") === "true";

      console.log("아이콘:", icon);
      console.log("현재 찜하기 상태:", isWishlisted);
      console.log("현재 아이콘 클래스:", icon.className);

      if (!icon) {
        console.error("아이콘을 찾을 수 없습니다!");
        return;
      }

      if (isWishlisted) {
        // 찜하기 해제
        icon.className = "ph ph-heart";
        this.setAttribute("data-wishlist", "false");
        console.log("찜하기 해제 완료 - 빈 하트로 변경");
      } else {
        // 찜하기 추가
        icon.className = "ph ph-heart-fill";
        this.setAttribute("data-wishlist", "true");
        console.log("찜하기 추가 완료 - 채워진 하트로 변경");
      }

      // 변경 후 상태 확인
      console.log("변경 후 아이콘 클래스:", icon.className);
      console.log("변경 후 data-wishlist:", this.getAttribute("data-wishlist"));
    });
  });
}
