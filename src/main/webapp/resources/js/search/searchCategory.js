// 검색 카테고리 기능
$(document).ready(function () {
  // 카테고리 버튼 클릭 이벤트
  $(".category-item").on("click", function () {
    const $this = $(this);
    const category = $this.data("category");

    // 모든 카테고리에서 active 클래스 제거
    $(".category-item").removeClass("active");

    // 클릭된 카테고리에 active 클래스 추가
    $this.addClass("active");

    // 카테고리별 필터링 로직
    filterByCategory(category);

    // 검색 결과 업데이트
    updateSearchResults(category);
  });

  // 카테고리별 필터링 함수
  function filterByCategory(category) {
    console.log("카테고리 필터링:", category);

    // 여기에 실제 필터링 로직 구현
    // 예: API 호출, 결과 필터링 등

    // 임시로 콘솔에 로그 출력
    const categoryNames = {
      all: "모두",
      new: "신규오픈",
      exclusive: "단독소개",
      best: "베스트 스테이",
      steady: "스테디셀러",
      emotional: "감성 숙소",
      nature: "자연속에서",
      ocean: "바다와 함께",
      couple: "연인과 함께",
    };

    console.log(`${categoryNames[category]} 카테고리가 선택되었습니다.`);
  }

  // 검색 결과 업데이트 함수
  function updateSearchResults(category) {
    // 검색 결과 제목 업데이트
    const categoryNames = {
      all: "전체 숙소",
      new: "신규오픈 숙소",
      exclusive: "단독소개 숙소",
      best: "베스트 스테이",
      steady: "스테디셀러",
      emotional: "감성 숙소",
      nature: "자연속 숙소",
      ocean: "바다뷰 숙소",
      couple: "커플 추천 숙소",
    };

    // 검색 결과 제목 변경
    $(".search-results-title").text(categoryNames[category] || "검색 결과");

    // 로딩 효과 (선택사항)
    //showLoadingEffect();

    // 실제 구현에서는 여기서 API 호출하여 결과 업데이트
    setTimeout(() => {
      hideLoadingEffect();
      // updateResultsGrid(filteredResults);
    }, 500);
  }

  // 로딩 효과 표시
  // function showLoadingEffect() {
  //   $(".search-results-grid").css("opacity", "0.5");
  // }

  // // 로딩 효과 숨김
  // function hideLoadingEffect() {
  //   $(".search-results-grid").css("opacity", "1");
  // }

  // 카테고리 스크롤 기능 (모바일에서 유용)
  function initCategoryScroll() {
    const categoryList = $(".category-list")[0];
    let isDown = false;
    let startX;
    let scrollLeft;

    if (categoryList) {
      categoryList.addEventListener("mousedown", (e) => {
        isDown = true;
        startX = e.pageX - categoryList.offsetLeft;
        scrollLeft = categoryList.scrollLeft;
      });

      categoryList.addEventListener("mouseleave", () => {
        isDown = false;
      });

      categoryList.addEventListener("mouseup", () => {
        isDown = false;
      });

      categoryList.addEventListener("mousemove", (e) => {
        if (!isDown) return;
        e.preventDefault();
        const x = e.pageX - categoryList.offsetLeft;
        const walk = (x - startX) * 2;
        categoryList.scrollLeft = scrollLeft - walk;
      });
    }
  }

  // 초기화
  initCategoryScroll();
});
