$(document).ready(function () {
  $(".category-item").on("click", function () {
    const $this = $(this);
    const category = $this.data("category");
    $(".category-item").removeClass("active");
    $this.addClass("active");
    updateSearchResults(category);
  });

  function updateSearchResults(category) {
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

    $(".search-results-title").text(categoryNames[category] || "검색 결과");
  }

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
});
