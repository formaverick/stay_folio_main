// 캐러셀 네임스페이스로 중복 방지
window.StayFolioCarousel = window.StayFolioCarousel || {};

if (!window.StayFolioCarousel.initialized) {
  window.StayFolioCarousel.initialized = true;

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

    console.log("Carousel initialized with", totalSlides, "slides");

    // 슬라이드 이동 함수
    function moveToSlide(slideIndex) {
      if (isTransitioning) {
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

      // 진행률 텍스트 업데이트
      const currentNumber = String(slideIndex + 1).padStart(2, "0");
      $(".current-slide").text(currentNumber);

      // 트랜지션 완료 후 플래그 해제
      setTimeout(() => {
        isTransitioning = false;
        console.log("Transition completed");
      }, 300);
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
    $prevBtn.off("click.carousel").on("click.carousel", function (e) {
      e.preventDefault();
      e.stopPropagation();
      prevSlide();
    });

    $nextBtn.off("click.carousel").on("click.carousel", function (e) {
      e.preventDefault();
      e.stopPropagation();
      nextSlide();
    });

    // 인디케이터 클릭 이벤트
    $indicators.off("click.carousel").on("click.carousel", function (e) {
      e.preventDefault();
      e.stopPropagation();
      const slideIndex = parseInt($(this).data("slide"));
      moveToSlide(slideIndex);
    });

    // 키보드 네비게이션
    $(document)
      .off("keydown.carousel")
      .on("keydown.carousel", function (e) {
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

    // 초기 슬라이드 설정
    moveToSlide(0);
  });
}
