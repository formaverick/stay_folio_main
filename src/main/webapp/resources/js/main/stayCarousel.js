// 숙소 카드 캐러셀 JavaScript

// 캐러셀 상태 관리
let currentSlide = 0;
const totalSlides = 3; // 9개 데이터를 3개씩 3페이지
let allStays = [];

// DOM 로드 완료 후 실행
document.addEventListener("DOMContentLoaded", function () {
  console.log("숙소 카드 캐러셀 초기화");

  // JSON 데이터로 캐러셀 로드
  loadStayCardsFromJSON();

  // 캐러셀 이벤트 리스너 초기화
  initializeCarouselEventListeners();
});

// JSON 데이터로 숙소 카드 로드
async function loadStayCardsFromJSON() {
  try {
    console.log("JSON 데이터 로드 시작...");

    const response = await fetch("../../resources/data/stays-sample.json");
    if (!response.ok) {
      throw new Error(`HTTP error! status: ${response.status}`);
    }

    const jsonData = await response.json();
    console.log("로드된 데이터:", jsonData);

    if (jsonData.success && jsonData.data && jsonData.data.stays) {
      allStays = jsonData.data.stays;

      // 섹션 제목 업데이트
      const sectionTitle = document.querySelector(".section-title");
      if (sectionTitle && jsonData.data.title) {
        sectionTitle.textContent = jsonData.data.title;
      }

      // 모든 슬라이드 렌더링
      renderAllSlides();
      updateNavigationButtons();

      console.log(`${allStays.length}개 숙소 데이터로 캐러셀 초기화 완료`);
    } else {
      console.error("잘못된 JSON 데이터 구조:", jsonData);
    }
  } catch (error) {
    console.error("JSON 데이터 로드 실패:", error);
  }
}

// 캐러셀 이벤트 리스너 초기화
function initializeCarouselEventListeners() {
  const prevBtn = document.getElementById("prevBtn");
  const nextBtn = document.getElementById("nextBtn");

  if (prevBtn) {
    prevBtn.addEventListener("click", () => {
      if (currentSlide > 0) {
        currentSlide--;
        renderCurrentSlide();
        updateNavigationButtons();
        console.log(`이전 슬라이드로 이동: ${currentSlide + 1}/${totalSlides}`);
      }
    });
  }

  if (nextBtn) {
    nextBtn.addEventListener("click", () => {
      if (currentSlide < totalSlides - 1) {
        currentSlide++;
        renderCurrentSlide();
        updateNavigationButtons();
        console.log(`다음 슬라이드로 이동: ${currentSlide + 1}/${totalSlides}`);
      }
    });
  }
}

// 모든 슬라이드 렌더링
function renderAllSlides() {
  const container = document.querySelector(".stay-cards-container");
  if (!container) {
    console.error(".stay-cards-container를 찾을 수 없습니다.");
    return;
  }

  // 기존 내용 제거
  container.innerHTML = "";

  // 3개씩 나눠서 각 슬라이드 생성
  for (let i = 0; i < totalSlides; i++) {
    const startIndex = i * 3;
    const endIndex = startIndex + 3;
    const slideStays = allStays.slice(startIndex, endIndex);

    const slideHTML = createSlideHTML(slideStays);
    container.insertAdjacentHTML("beforeend", slideHTML);
  }

  // 초기 위치 설정
  updateCarouselPosition();

  // 카드 이벤트 리스너 초기화
  initializeCardEventListeners();
}

// 슬라이드 HTML 생성
function createSlideHTML(stays) {
  const cardsHTML = stays.map((stay) => createStayCardHTML(stay)).join("");

  return `
    <div class="stay-cards-grid">
      ${cardsHTML}
    </div>
  `;
}

// 캐러셀 위치 업데이트
function updateCarouselPosition() {
  const container = document.querySelector(".stay-cards-container");
  if (container) {
    const translateX = -currentSlide * 100;
    container.style.transform = `translateX(${translateX}%)`;
  }
}

// 개별 숙소 카드 HTML 생성
function createStayCardHTML(stay) {
  const hasDiscount = stay.originalPrice && stay.discount;
  const promotionTag = stay.isPromotion
    ? '<div class="stay-card-promotion">프로모션</div>'
    : "";
  const heartIcon = stay.isWishlisted ? "ph-heart-fill" : "ph-heart";

  const priceHTML = hasDiscount
    ? `
    <span class="stay-card-price-original">₩${stay.originalPrice.toLocaleString()}</span>
    <div class="stay-card-price-main">
      <span class="stay-card-price-discount">${stay.discount}%</span>
      <span class="stay-card-price-current">₩${stay.currentPrice.toLocaleString()}~</span>
    </div>
  `
    : `
    <div class="stay-card-price-main">
      <span class="stay-card-price-current">₩${stay.currentPrice.toLocaleString()}~</span>
    </div>
  `;

  return `
    <div class="stay-card" data-stay-id="${stay.id}">
      <div class="stay-card-image">
        <img src="${stay.imageUrl}" alt="${stay.title}" />
        ${promotionTag}
        <button class="stay-card-wishlist" data-wishlist="${stay.isWishlisted}">
          <i class="ph ${heartIcon}"></i>
        </button>
      </div>
      <div class="stay-card-content">
        <h3 class="stay-card-title">${stay.title}</h3>
        <div class="stay-card-location">
          <i class="ph ph-map-pin"></i>
          ${stay.location}
        </div>
        <div class="stay-card-price">
          ${priceHTML}
        </div>
      </div>
    </div>
  `;
}

// 네비게이션 버튼 상태 업데이트
function updateNavigationButtons() {
  const prevBtn = document.getElementById("prevBtn");
  const nextBtn = document.getElementById("nextBtn");

  if (prevBtn) {
    prevBtn.disabled = currentSlide === 0;
  }

  if (nextBtn) {
    nextBtn.disabled = currentSlide === totalSlides - 1;
  }
}

// 카드 이벤트 리스너 초기화
function initializeCardEventListeners() {
  // 찜하기 버튼 이벤트
  const wishlistButtons = document.querySelectorAll(".stay-card-wishlist");
  wishlistButtons.forEach((button) => {
    button.addEventListener("click", handleWishlistToggle);
  });

  // 카드 클릭 이벤트
  const stayCards = document.querySelectorAll(".stay-card");
  stayCards.forEach((card) => {
    card.addEventListener("click", handleCardClick);
  });
}

// 찜하기 토글 처리
function handleWishlistToggle(event) {
  event.stopPropagation();

  const button = event.currentTarget;
  const icon = button.querySelector("i");
  const isWishlisted = button.dataset.wishlist === "true";
  const stayId = button.closest(".stay-card").dataset.stayId;

  // 상태 토글
  const newWishlistState = !isWishlisted;
  button.dataset.wishlist = newWishlistState;

  // 아이콘 변경
  if (newWishlistState) {
    icon.className = "ph ph-heart-fill";
    console.log(`숙소 ID ${stayId} 찜하기 추가`);
    showWishlistMessage("찜하기에 추가되었습니다! ❤️");
  } else {
    icon.className = "ph ph-heart";
    console.log(`숙소 ID ${stayId} 찜하기 제거`);
    showWishlistMessage("찜하기에서 제거되었습니다.");
  }

  // 원본 데이터도 업데이트
  const stay = allStays.find((s) => s.id == stayId);
  if (stay) {
    stay.isWishlisted = newWishlistState;
  }
}

// 카드 클릭 처리
function handleCardClick(event) {
  if (event.target.closest(".stay-card-wishlist")) {
    return;
  }

  const stayId = event.currentTarget.dataset.stayId;
  console.log(`숙소 ID ${stayId} 상세 페이지로 이동`);

  // 상세 페이지로 이동 (시뮬레이션)
  // window.location.href = `/stays/${stayId}`;
}

// 찜하기 메시지 표시
function showWishlistMessage(message) {
  const existingMessage = document.querySelector(".wishlist-message");
  if (existingMessage) {
    existingMessage.remove();
  }

  const messageDiv = document.createElement("div");
  messageDiv.className = "wishlist-message";
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
