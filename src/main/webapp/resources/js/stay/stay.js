$(document).ready(function () {
  $(".accordion-header").on("click", function () {
    const $header = $(this);

    const $content = $header.next(".accordion-content");

    // 현재 아이템이 활성화되어 있는지 확인
    const isActive = $header.closest(".accordion-item").hasClass("active");

    // 모든 아코디언 닫기
    $(".accordion-item").removeClass("active");
    $(".accordion-content").hide();

    // 현재 아이템이 비활성화 상태였다면 열기
    if (!isActive) {
      $header.closest(".accordion-item").addClass("active");
      $content.show();
    }
  });
  
  wishEvent();
});
