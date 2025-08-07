function initStayCarouselEvents(rc_id) {
  const track = document.getElementById(`track-${rc_id}`);
  const prevBtn = document.getElementById(`stayPrevBtn-${rc_id}`);
  const nextBtn = document.getElementById(`stayNextBtn-${rc_id}`);
  const slides = track.querySelectorAll(".stay-grid");

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
