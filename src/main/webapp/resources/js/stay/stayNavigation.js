document.addEventListener("DOMContentLoaded", function () {
  // 네비게이션 요소와 섹션 요소들을 가져옵니다
  const navLinks = document.querySelectorAll(".stay-nav a");
  const sections = document.querySelectorAll(".stay-section");
  const navItems = document.querySelectorAll(".stay-nav li");
  const navContainer = document.getElementById("stay-nav-container");
  const header = document.querySelector(".header");

  // 헤더 높이와 네비게이션 컨테이너의 원래 위치를 저장합니다
  let navOriginalTop = 0;
  let headerHeight = 0;

  // 페이지 로드 시 헤더 높이를 계산합니다
  function calculateHeaderHeight() {
    headerHeight = header.offsetHeight;
  }

  // 페이지 로드 및 리사이즈 시 헤더 높이 계산
  window.addEventListener("load", calculateHeaderHeight);
  window.addEventListener("resize", debounce(calculateHeaderHeight, 100));

  // 스크롤 이벤트 리스너 등록
  window.addEventListener("scroll", debounce(onScroll, 10));

  // 초기 로드 시 현재 위치에 맞는 네비게이션 활성화
  setTimeout(onScroll, 100);

  // 네비게이션 클릭 이벤트 리스너 등록
  navLinks.forEach((link) => {
    link.addEventListener("click", function (e) {
      e.preventDefault();

      // 해당 섹션으로 부드럽게 스크롤
      const targetId = this.getAttribute("href");
      const targetSection = document.querySelector(targetId);

      if (targetSection) {
        // 네비게이션 높이를 고려하여 스크롤 위치 조정
        const navHeight = navContainer.offsetHeight;
        const targetPosition = targetSection.offsetTop - navHeight - 50;

        window.scrollTo({
          top: targetPosition,
          behavior: "smooth",
        });

        // 네비게이션 활성화 상태 업데이트
        updateActiveNav(this);
      }
    });
  });

  /**
   * 스크롤 위치에 따라 네비게이션 그림자 효과와 활성화 상태를 업데이트합니다.
   */
  function onScroll() {
    // 현재 스크롤 위치
    const scrollPosition = window.scrollY;

    // 스크롤이 100px 이상 내려가면 그림자 효과 추가
    if (scrollPosition > 100) {
      if (!navContainer.classList.contains("scrolled")) {
        navContainer.classList.add("scrolled");
      }
    } else {
      if (navContainer.classList.contains("scrolled")) {
        navContainer.classList.remove("scrolled");
      }
    }

    // 네비게이션 높이 계산 (헤더 높이 포함)
    const navHeight = navContainer.offsetHeight + headerHeight;

    // 각 섹션을 확인하여 현재 보이는 섹션에 해당하는 네비게이션 활성화
    let currentSection = null;

    sections.forEach((section) => {
      // 섹션의 상단 위치가 현재 스크롤 위치보다 위에 있으면 현재 섹션으로 설정
      const sectionTop = section.offsetTop - navHeight - 20; // 약간의 여유 추가
      if (scrollPosition >= sectionTop) {
        currentSection = section;
      }
    });

    // 현재 섹션이 있으면 해당 네비게이션 활성화
    if (currentSection) {
      const currentId = "#" + currentSection.id;
      const activeLink = document.querySelector(
        `.stay-nav a[href="${currentId}"]`
      );

      if (activeLink) {
        updateActiveNav(activeLink);
      }
    }
  }

  /**
   * 네비게이션 활성화 상태를 업데이트합니다.
   * param {HTMLElement} activeLink - 활성화할 네비게이션 링크
   */
  function updateActiveNav(activeLink) {
    // 모든 네비게이션 아이템에서 active 클래스 제거
    navItems.forEach((item) => item.classList.remove("active"));

    // 현재 링크의 부모 li에 active 클래스 추가
    activeLink.parentElement.classList.add("active");
  }

  /**
   * 디바운스 함수 - 연속적인 이벤트 호출을 제한합니다.
   * param {Function} func - 실행할 함수
   * param {number} wait - 대기 시간(ms)
   * returns {Function} 디바운스된 함수
   */
  function debounce(func, wait) {
    let timeout;
    return function () {
      const context = this;
      const args = arguments;
      clearTimeout(timeout);
      timeout = setTimeout(() => {
        func.apply(context, args);
      }, wait);
    };
  }
});
