// 숙소 카드 캐러셀 전용 JavaScript - 상단 캐러셀과 완전 독립

// 숙소 캐러셀 상태 관리
let stayCurrentSlide = 0;
const stayTotalSlides = 3; // 9개 데이터를 3개씩 3페이지
let stayData = [];

// DOM 로드 완료 후 실행
document.addEventListener("DOMContentLoaded", function () {
  console.log("숙소 카드 캐러셀 초기화 시작");

  // JSON 데이터로 숙소 캐러셀 로드
  loadStayData();

  // 숙소 캐러셀 이벤트 리스너 초기화
  initStayCarouselEvents();
});

// JSON 데이터로 숙소 카드 로드
async function loadStayData() {
  try {
    console.log("숙소 데이터 로드 시작...");

    const response = await fetch("../../resources/data/stays-sample.json");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const jsonData = await response.json();
    console.log("로드된 숙소 데이터:", jsonData);

    if (jsonData.success && jsonData.data && jsonData.data.stays) {
      stayData = jsonData.data.stays;

      // 섹션 제목 업데이트
      const mainTitle = document.querySelector(".stay-main-title");
      if (mainTitle && jsonData.data.title) {
        mainTitle.textContent = jsonData.data.title;
      }

      // 모든 숙소 슬라이드 렌더링
      renderAllStaySlides();
      updateStayNavigation();

      console.log(`${stayData.length}개 숙소 데이터로 캐러셀 초기화 완료`);
    } else {
      console.error("잘못된 숙소 데이터 구조:", jsonData);
    }
  } catch (error) {
    console.error("숙소 데이터 로드 실패:", error);
  }
}

// 숙소 캐러셀 이벤트 리스너 초기화
function initStayCarouselEvents() {
  const prevBtn = document.getElementById("stayPrevBtn");
  const nextBtn = document.getElementById("stayNextBtn");

  if (prevBtn) {
    prevBtn.addEventListener("click", () => {
      if (stayCurrentSlide > 0) {
        stayCurrentSlide--;
        updateStayCarouselPosition();
        updateStayNavigation();
        console.log(
          `숙소 이전 슬라이드: ${stayCurrentSlide + 1}/${stayTotalSlides}`
        );
      }
    });
  }

  if (nextBtn) {
    nextBtn.addEventListener("click", () => {
      if (stayCurrentSlide < stayTotalSlides - 1) {
        stayCurrentSlide++;
        updateStayCarouselPosition();
        updateStayNavigation();
        console.log(
          `숙소 다음 슬라이드: ${stayCurrentSlide + 1}/${stayTotalSlides}`
        );
      }
    });
  }
}

// 모든 숙소 슬라이드 렌더링
function renderAllStaySlides() {
  const track = document.querySelector(".stay-carousel-track");
  if (!track) {
    console.error(".stay-carousel-track을 찾을 수 없습니다.");
    return;
  }

  // 기존 내용 제거
  track.innerHTML = "";

  // 3개씩 나눠서 각 슬라이드 생성
  for (let i = 0; i < stayTotalSlides; i++) {
    const startIndex = i * 3;
    const endIndex = startIndex + 3;
    const slideStays = stayData.slice(startIndex, endIndex);

    const slideHTML = createStaySlideHTML(slideStays);
    track.insertAdjacentHTML("beforeend", slideHTML);
  }

  // 초기 위치 설정
  updateStayCarouselPosition();

  // 카드 이벤트 리스너 초기화
  initStayCardEvents();
}

// 숙소 슬라이드 HTML 생성
function createStaySlideHTML(stays) {
  const cardsHTML = stays.map((stay) => createStayCardHTML(stay)).join("");

  return `
    <div class="stay-grid">
      ${cardsHTML}
    </div>
  `;
}

// 개별 숙소 카드 HTML 생성
function createStayCardHTML(stay) {
  const hasDiscount = stay.originalPrice && stay.discount;
  const promotionTag = stay.isPromotion
    ? '<div class="stay-promotion">프로모션</div>'
    : "";
  const bookmarkIcon = stay.isWishlisted
    ? "ph-bookmark-simple-fill"
    : "ph-bookmark-simple";

  const priceHTML = hasDiscount
    ? `
    <span class="stay-price-original">₩${stay.originalPrice.toLocaleString()}</span>
    <div class="stay-price-main">
      <span class="stay-price-discount">${stay.discount}%</span>
      <span class="stay-price-current">₩${stay.currentPrice.toLocaleString()}~</span>
    </div>
  `
    : `
    <div class="stay-price-main">
      <span class="stay-price-current">₩${stay.currentPrice.toLocaleString()}~</span>
    </div>
  `;

  return `
    <div class="stay-item" data-stay-id="${stay.id}">
      <div class="stay-image">
        <img src="${stay.imageUrl}" alt="${stay.title}" />
        ${promotionTag}
        <button class="stay-wishlist" data-wishlist="${stay.isWishlisted}">
          <i class="ph ${bookmarkIcon}"></i>
        </button>
      </div>
      <div class="stay-content">
        <h3 class="stay-name">${stay.title}</h3>
        <div class="stay-location">
          <i class="ph ph-map-pin"></i>
          ${stay.location}
        </div>
        <div class="stay-price">
          ${priceHTML}
        </div>
      </div>
    </div>
  `;
}

// 숙소 캐러셀 위치 업데이트
function updateStayCarouselPosition() {
  const track = document.querySelector(".stay-carousel-track");
  if (track) {
    // 각 슬라이드가 33.333% 너비를 가지므로 33.333% 단위로 이동
    const translateX = -stayCurrentSlide * 33.333;
    track.style.transform = `translateX(${translateX}%)`;
    console.log(
      `슬라이드 ${stayCurrentSlide}로 이동: translateX(${translateX}%)`
    );
  }
}

// 숙소 네비게이션 버튼 상태 업데이트
function updateStayNavigation() {
  const prevBtn = document.getElementById("stayPrevBtn");
  const nextBtn = document.getElementById("stayNextBtn");

  // 데이터가 3개 이하면 모든 버튼 숨김
  if (stayData.length <= 3) {
    if (prevBtn) prevBtn.style.display = "none";
    if (nextBtn) nextBtn.style.display = "none";
    return;
  }

  // 이전 버튼 처리
  if (prevBtn) {
    if (stayCurrentSlide === 0) {
      prevBtn.style.display = "none";
    } else {
      prevBtn.style.display = "flex";
      prevBtn.disabled = false;
    }
  }

  // 다음 버튼 처리
  if (nextBtn) {
    if (stayCurrentSlide === stayTotalSlides - 1) {
      nextBtn.style.display = "none";
    } else {
      nextBtn.style.display = "flex";
      nextBtn.disabled = false;
    }
  }
}

// 숙소 카드 이벤트 리스너 초기화
function initStayCardEvents() {
  // 찜하기 버튼 이벤트
  const wishlistButtons = document.querySelectorAll(".stay-wishlist");
  wishlistButtons.forEach((button) => {
    button.addEventListener("click", handleStayWishlistToggle);
  });

  // 카드 클릭 이벤트
  const stayCards = document.querySelectorAll(".stay-item");
  stayCards.forEach((card) => {
    card.addEventListener("click", handleStayCardClick);
  });
}

// 숙소 북마크 토글 처리
function handleStayWishlistToggle(event) {
  event.stopPropagation();

  const button = event.currentTarget;
  const icon = button.querySelector("i");
  const isBookmarked = button.dataset.wishlist === "true";
  const stayId = button.closest(".stay-item").dataset.stayId;

  // 상태 토글
  const newBookmarkState = !isBookmarked;
  button.dataset.wishlist = newBookmarkState;

  // 아이콘 변경 (북마크)
  if (newBookmarkState) {
    icon.className = "ph ph-bookmark-simple-fill";
    console.log(`숙소 ID ${stayId} 북마크 추가`);
    showStayWishlistMessage("북마크에 추가되었습니다! 🔖");
  } else {
    icon.className = "ph ph-bookmark-simple";
    console.log(`숙소 ID ${stayId} 북마크 제거`);
    showStayWishlistMessage("북마크에서 제거되었습니다.");
  }

  // 원본 데이터도 업데이트
  const stay = stayData.find((s) => s.id == stayId);
  if (stay) {
    stay.isWishlisted = newBookmarkState;
  }
}

// 숙소 카드 클릭 처리
function handleStayCardClick(event) {
  if (event.target.closest(".stay-wishlist")) {
    return;
  }

  const stayId = event.currentTarget.dataset.stayId;
  console.log(`숙소 ID ${stayId} 상세 페이지로 이동`);

  // 상세 페이지로 이동 (시뮬레이션)
  // window.location.href = `/stays/${stayId}`;
}

// 숙소 찜하기 메시지 표시
function showStayWishlistMessage(message) {
  const existingMessage = document.querySelector(".stay-wishlist-message");
  if (existingMessage) {
    existingMessage.remove();
  }

  const messageDiv = document.createElement("div");
  messageDiv.className = "stay-wishlist-message";
  messageDiv.textContent = message;
  messageDiv.style.cssText = `
    position: fixed;
    top: 20px;
    right: 20px;
    background: #333;
    color: white;
    padding: 12px 20px;
    border-radius: 8px;
    z-index: 1000;
    font-size: 14px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.15);
  `;

  document.body.appendChild(messageDiv);

  // 3초 후 자동 제거
  setTimeout(() => {
    messageDiv.remove();
  }, 3000);
}
