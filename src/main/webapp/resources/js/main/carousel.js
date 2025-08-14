// 캐러셀 네임스페이스로 중복 방지
window.StayFolioCarousel = window.StayFolioCarousel || {};

// 캐러셀이 초기화되지 않았다면 초기화 진행
if (!window.StayFolioCarousel.initialized) {
  window.StayFolioCarousel.initialized = true;

  // 문서 준비 완료 시 실행
  $(document).ready(function () {
    // DOM 요소 선택
    const $carousel = $(".carousel");
    const $track = $(".carousel-track");
    const $slides = $(".carousel-slide");
    const $indicators = $(".indicator");
    const $prevBtn = $(".carousel-btn-prev");
    const $nextBtn = $(".carousel-btn-next");

    // 상태 변수 초기화
    let currentSlide = 0;
    const totalSlides = $slides.length;
    let isTransitioning = false;

    /**
     * description 특정 슬라이드로 이동시키는 함수
     * param {number} slideIndex - 이동할 슬라이드의 인덱스
     */
    function moveToSlide(slideIndex) {
      // 전환 중이면 함수 실행 중단
      if (isTransitioning) {
        return;
      }

      // 인덱스 범위 체크 및 순환
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

      // 전환 시작 플래그 설정
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

    function prevSlide() {
      moveToSlide(currentSlide - 1);
    }

    /**
     * function nextSlide
     * description 다음 슬라이드로 이동시키는 함수
     */
    function nextSlide() {
      moveToSlide(currentSlide + 1);
    }

    // 이벤트 리스너 설정
    // 이전 버튼 이벤트
    $prevBtn.off("click.carousel").on("click.carousel", function (e) {
      e.preventDefault();
      e.stopPropagation();
      prevSlide();
    });

    // 다음 버튼 이벤트
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

    // 이미지 드래그 방지
    $carousel.find("img").on("dragstart", function (e) {
      e.preventDefault();
    });

    // 초기 슬라이드 설정
    moveToSlide(0);
  });
}
