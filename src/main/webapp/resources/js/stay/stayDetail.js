$(document).ready(function () {
  $(".accordion-header").on("click", function () {
    const $header = $(this);

    const $content = $header.next(".accordion-content");

    // 현재 아이템이 활성화되어 있는지 확인
    const isActive = $header.closest(".accordion-item").hasClass("active");

    // 모든 아코디언 닫기 (클릭된 아코디언 제외)
    $(".accordion-item.active")
      .not($header.closest(".accordion-item"))
      .removeClass("active");

    // 현재 아이템의 active 클래스 토글
    $header.closest(".accordion-item").toggleClass("active");
  });
});
