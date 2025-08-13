// Stay 캐러셀 네임스페이스로 중복 방지
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

    // 슬라이드가 없으면 초기화하지 않음
    if (totalSlides === 0) {
      return;
    }

    // 슬라이드 이동 함수
    function moveToSlide(slideIndex) {
      if (isTransitioning) {
        return;
      }

      // 인덱스 범위 체크
      if (slideIndex < 0) {
        slideIndex = totalSlides - 1;
      } else if (slideIndex >= totalSlides) {
        slideIndex = 0;
      }

      // 같은 슬라이드면 무시
      if (slideIndex === currentSlide) {
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

      // 트랜지션 완료 후 상태 초기화
      setTimeout(function () {
        isTransitioning = false;
      }, 500); // CSS transition 시간과 동일하게 설정
    }

    // 이전 슬라이드
    function prevSlide() {
      moveToSlide(currentSlide - 1);
    }

    // 다음 슬라이드
    function nextSlide() {
      moveToSlide(currentSlide + 1);
    }

    // 이벤트 리스너
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

    // 이미지 드래그 방지
    $carousel.find("img").on("dragstart", function (e) {
      e.preventDefault();
    });

    // 초기 슬라이드 설정
    moveToSlide(0);
  });
}
