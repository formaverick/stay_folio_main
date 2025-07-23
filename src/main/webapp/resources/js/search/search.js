// 검색 결과 페이지 JavaScript - 하드코딩된 카드용 간소화 버전

$(document).ready(function () {
  // 카드 이벤트 바인딩
  function bindCardEvents() {
    // 찜하기 버튼 이벤트
    $(".search-stay-wishlist").on("click", function (e) {
      e.stopPropagation();
      const $this = $(this);
      const isWishlisted = $this.attr("data-wishlist") === "true";

      $this.attr("data-wishlist", !isWishlisted);

      // 간단한 피드백
      if (!isWishlisted) {
        console.log("찜 목록에 추가되었습니다.");
      } else {
        console.log("찜 목록에서 제거되었습니다.");
      }
    });

    // 카드 클릭 이벤트 (상세 페이지로 이동)
    $(".search-stay-item").on("click", function () {
      const stayId = $(this).attr("data-stay-id");
      console.log(`숙소 ${stayId} 상세 페이지로 이동`);
      // window.location.href = `/stay/detail/${stayId}`;
    });
  }

  // 초기화
  bindCardEvents();
});
