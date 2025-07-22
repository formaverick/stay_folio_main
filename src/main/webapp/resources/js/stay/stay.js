document.addEventListener("DOMContentLoaded", function () {
  // 아코디언 기능 구현
  const accordionItems = document.querySelectorAll(".accordion-item");

  accordionItems.forEach((item) => {
    const header = item.querySelector(".accordion-header");

    header.addEventListener("click", () => {
      // 현재 아이템의 활성화 상태 토글
      const isActive = item.classList.contains("active");

      // 모든 아이템 비활성화
      accordionItems.forEach((otherItem) => {
        otherItem.classList.remove("active");
      });

      // 클릭한 아이템이 이미 활성화되어 있지 않았다면 활성화
      if (!isActive) {
        item.classList.add("active");
      }
    });
  });
});
