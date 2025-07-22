// 캐러셀 네임스페이스로 중복 방지
window.StayFolioStayCarousel = window.StayFolioStayCarousel || {};

if (!window.StayFolioStayCarousel.initialized) {
  window.StayFolioStayCarousel.initialized = true;

  $(document).ready(function () {
    const $carousel = $(".carousel");
    const $track = $(".carousel-track");
    const $slides = $(".carousel-slide");
    const $indicators = $(".indicator");
    const $prevBtn = $(".carousel-btn-prev");
    const $nextBtn = $(".carousel-btn-next");

    let currentSlide = 0;
    const totalSlides = $slides.length;
    let isTransitioning = false;

    console.log("Stay Carousel initialized with", totalSlides, "slides");

    // 슬라이드 이동 함수
    function moveToSlide(slideIndex) {
      if (isTransitioning) {
        console.log("Transition in progress, ignoring moveToSlide call");
        return;
      }

      console.log(
        "moveToSlide called with:",
        slideIndex,
        "currentSlide was:",
        currentSlide
      );

      // 인덱스 범위 체크
      if (slideIndex < 0) {
        slideIndex = totalSlides - 1;
      } else if (slideIndex >= totalSlides) {
        slideIndex = 0;
      }

      // 같은 슬라이드면 무시
      if (slideIndex === currentSlide) {
        console.log("Same slide, ignoring");
        return;
      }

      isTransitioning = true;
      currentSlide = slideIndex;

      // 트랙 이동
      const translateX = -slideIndex * 100;
      $track.css("transform", `translateX(${translateX}%)`);

      // 활성 슬라이드 업데이트
      $slides.removeClass("active");
      $slides.eq(slideIndex).addClass("active");

      // 인디케이터 업데이트
      $indicators.removeClass("active");
      $indicators.eq(slideIndex).addClass("active");

      // 트랜지션 완료 후 플래그 해제
      setTimeout(() => {
        isTransitioning = false;
        console.log("Transition completed");
      }, 500);
    }

    // 이전 슬라이드
    function prevSlide() {
      moveToSlide(currentSlide - 1);
    }

    // 다음 슬라이드
    function nextSlide() {
      moveToSlide(currentSlide + 1);
    }

    // 이벤트 리스너 - 간단하고 명확하게
    $prevBtn.off("click.stayCarousel").on("click.stayCarousel", function (e) {
      e.preventDefault();
      e.stopPropagation();
      prevSlide();
    });

    $nextBtn.off("click.stayCarousel").on("click.stayCarousel", function (e) {
      e.preventDefault();
      e.stopPropagation();
      nextSlide();
    });

    // 인디케이터 클릭 이벤트
    $indicators
      .off("click.stayCarousel")
      .on("click.stayCarousel", function (e) {
        e.preventDefault();
        e.stopPropagation();
        const slideIndex = parseInt($(this).data("slide"));
        moveToSlide(slideIndex);
      });

    // 키보드 네비게이션
    $(document)
      .off("keydown.stayCarousel")
      .on("keydown.stayCarousel", function (e) {
        if ($carousel.is(":visible")) {
          switch (e.key) {
            case "ArrowLeft":
              e.preventDefault();
              prevSlide();
              break;
            case "ArrowRight":
              e.preventDefault();
              nextSlide();
              break;
          }
        }
      });

    // 터치/스와이프 지원
    let startX = 0;
    let endX = 0;
    let isDragging = false;

    $carousel.on("touchstart", function (e) {
      startX = e.originalEvent.touches[0].clientX;
      isDragging = true;
    });

    $carousel.on("touchmove", function (e) {
      if (!isDragging) return;
      endX = e.originalEvent.touches[0].clientX;
    });

    $carousel.on("touchend", function (e) {
      if (!isDragging) return;
      isDragging = false;

      const diffX = startX - endX;
      const threshold = 50;

      if (Math.abs(diffX) > threshold) {
        if (diffX > 0) {
          nextSlide();
        } else {
          prevSlide();
        }
      }
    });

    // 이미지 드래그 방지
    $carousel.find("img").on("dragstart", function (e) {
      e.preventDefault();
    });

    // 자동 슬라이드 기능
    let autoSlideInterval;

    function startAutoSlide() {
      autoSlideInterval = setInterval(() => {
        nextSlide();
      }, 5000); // 5초마다 슬라이드 변경
    }

    function stopAutoSlide() {
      clearInterval(autoSlideInterval);
    }

    // 사용자 상호작용 시 자동 슬라이드 일시 중지
    $carousel.on("mouseenter", stopAutoSlide);
    $carousel.on("mouseleave", startAutoSlide);
    $carousel.on("touchstart", stopAutoSlide);

    // 초기 슬라이드 설정 및 자동 슬라이드 시작
    moveToSlide(0);
    startAutoSlide();
  });
}
