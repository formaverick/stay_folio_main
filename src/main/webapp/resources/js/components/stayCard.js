// 숙소 카드 JavaScript - 캐러셀 기능

// 캐러셀 상태 관리
let currentSlide = 0;
const totalSlides = 3; // 9개 데이터를 3개씩 3페이지
let allStays = [];

// DOM 로드 완료 후 실행
document.addEventListener('DOMContentLoaded', function() {
  console.log('숙소 카드 캐러셀 초기화');
  
  // JSON 데이터로 캐러셀 로드
  loadStayCardsFromJSON();
  
  // 캐러셀 이벤트 리스너 초기화
  initializeCarouselEventListeners();
});

// 캐러셀 이벤트 리스너 초기화
function initializeCarouselEventListeners() {
  // 이전 버튼 이벤트
  document.querySelector('.carousel-prev').addEventListener('click', function() {
    navigateToPreviousSlide();
  });
  
  // 다음 버튼 이벤트
  document.querySelector('.carousel-next').addEventListener('click', function() {
    navigateToNextSlide();
  });
}

// 이전 슬라이드로 이동
function navigateToPreviousSlide() {
  if (currentSlide > 0) {
    currentSlide--;
    renderCurrentSlide();
  }
}

// 다음 슬라이드로 이동
function navigateToNextSlide() {
  if (currentSlide < totalSlides - 1) {
    currentSlide++;
    renderCurrentSlide();
  }
}

// 현재 슬라이드 렌더링
function renderCurrentSlide() {
  const currentStays = allStays.slice(currentSlide * 3, (currentSlide + 1) * 3);
  renderStayCards(currentStays);
  
  // 더보기 버튼 이벤트
  initializeMoreButton();
}

// 찜하기 버튼 초기화
function initializeWishlistButtons() {
  $('.stay-card-wishlist').on('click', function(e) {
    e.stopPropagation(); // 카드 클릭 이벤트 방지
    
    const $button = $(this);
    const $icon = $button.find('i');
    const isWishlisted = $button.data('wishlist');
    const stayId = $button.closest('.stay-card').data('stay-id');
    
    if (isWishlisted) {
      // 찜하기 해제
      $button.data('wishlist', false);
      $button.removeClass('active');
      $icon.removeClass('ph-heart-fill').addClass('ph-heart');
      
      console.log(`숙소 ${stayId} 찜하기 해제`);
      showWishlistMessage('찜하기가 해제되었습니다.', 'remove');
      
      // 서버에 찜하기 해제 요청
      removeFromWishlist(stayId);
      
    } else {
      // 찜하기 추가
      $button.data('wishlist', true);
      $button.addClass('active');
      $icon.removeClass('ph-heart').addClass('ph-heart-fill');
      
      console.log(`숙소 ${stayId} 찜하기 추가`);
      showWishlistMessage('찜 목록에 추가되었습니다.', 'add');
      
      // 서버에 찜하기 추가 요청
      addToWishlist(stayId);
    }
  });
}

// 카드 클릭 이벤트 초기화
function initializeCardClickEvents() {
  $('.stay-card').on('click', function() {
    const stayId = $(this).data('stay-id');
    const stayTitle = $(this).find('.stay-card-title').text();
    
    console.log(`숙소 카드 클릭: ${stayTitle} (ID: ${stayId})`);
    
    // 숙소 상세 페이지로 이동
    // 실제 구현시에는 적절한 URL로 변경
    window.location.href = `/stay/detail/${stayId}`;
  });
}

// 더보기 버튼 초기화
function initializeMoreButton() {
  $('.btn-more').on('click', function(e) {
    e.preventDefault();
    
    console.log('더 많은 숙소 보기 클릭');
    
    // 숙소 목록 페이지로 이동
    // 실제 구현시에는 적절한 URL로 변경
    window.location.href = '/stays';
  });
}

// 찜하기 추가 (서버 통신)
async function addToWishlist(stayId) {
  try {
    const response = await fetch('/api/wishlist/add', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ stayId: stayId })
    });
    
    if (!response.ok) {
      throw new Error('찜하기 추가 실패');
    }
    
    const result = await response.json();
    console.log('찜하기 추가 성공:', result);
    
  } catch (error) {
    console.error('찜하기 추가 오류:', error);
    // 에러 발생시 UI 상태 되돌리기
    revertWishlistState(stayId, false);
  }
}

// 찜하기 해제 (서버 통신)
async function removeFromWishlist(stayId) {
  try {
    const response = await fetch('/api/wishlist/remove', {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
      },
      body: JSON.stringify({ stayId: stayId })
    });
    
    if (!response.ok) {
      throw new Error('찜하기 해제 실패');
    }
    
    const result = await response.json();
    console.log('찜하기 해제 성공:', result);
    
  } catch (error) {
    console.error('찜하기 해제 오류:', error);
    // 에러 발생시 UI 상태 되돌리기
    revertWishlistState(stayId, true);
  }
}

// 찜하기 상태 되돌리기 (에러 발생시)
function revertWishlistState(stayId, wasWishlisted) {
  const $card = $(`.stay-card[data-stay-id="${stayId}"]`);
  const $button = $card.find('.stay-card-wishlist');
  const $icon = $button.find('i');
  
  if (wasWishlisted) {
    $button.data('wishlist', true);
    $button.addClass('active');
    $icon.removeClass('ph-heart').addClass('ph-heart-fill');
  } else {
    $button.data('wishlist', false);
    $button.removeClass('active');
    $icon.removeClass('ph-heart-fill').addClass('ph-heart');
  }
}

// 찜하기 메시지 표시
function showWishlistMessage(message, type) {
  // 기존 메시지가 있다면 제거
  $('.wishlist-message').remove();
  
  const messageClass = type === 'add' ? 'wishlist-message-add' : 'wishlist-message-remove';
  const $message = $(`
    <div class="wishlist-message ${messageClass}">
      <i class="ph ph-heart${type === 'add' ? '-fill' : ''}"></i>
      <span>${message}</span>
    </div>
  `);
  
  // 메시지를 body에 추가
  $('body').append($message);
  
  // 애니메이션으로 표시
  setTimeout(() => {
    $message.addClass('show');
  }, 100);
  
  // 3초 후 자동 제거
  setTimeout(() => {
    $message.removeClass('show');
    setTimeout(() => {
      $message.remove();
    }, 300);
  }, 3000);
}

// JSON 파일에서 숙소 카드 데이터 로드 및 렌더링
async function loadStayCardsFromJSON() {
  try {
    console.log('샘플 JSON 데이터 로드 시작');
    
    const response = await fetch('../../resources/data/stays-sample.json');
    
    if (!response.ok) {
      throw new Error('JSON 데이터 로드 실패');
    }
    
    const jsonData = await response.json();
    console.log('JSON 데이터 로드 성공:', jsonData);
    
    if (jsonData.success && jsonData.data && jsonData.data.stays) {
      // 기존 정적 카드들 제거
      $('.stay-cards-grid').empty();
      
      // JSON 데이터로 카드 렌더링 (처음 6개만)
      const staysToShow = jsonData.data.stays.slice(0, 6);
      renderStayCards(staysToShow);
      
      // 이벤트 리스너 초기화
      initializeStayCards();
    } else {
      console.error('JSON 데이터 구조 오류');
      // 실패시 기본 정적 카드 유지
    }
    
  } catch (error) {
    console.error('JSON 데이터 로드 오류:', error);
    console.log('정적 카드로 폴백');
    // 에러 발생시 기존 정적 카드 사용
    initializeStayCards();
  }
}

// 숙소 카드 렌더링
function renderStayCards(stays) {
  const $grid = $('.stay-cards-grid');
  
  stays.forEach(stay => {
    const cardHTML = createStayCardHTML(stay);
    $grid.append(cardHTML);
  });
  
  console.log(`${stays.length}개 숙소 카드 렌더링 완료`);
}

// 숙소 카드 데이터 로드 (실제 API용 - 추후 사용)
async function loadStayCards(page = 1, limit = 6) {
  try {
    const response = await fetch(`/api/stays?page=${page}&limit=${limit}`);
    
    if (!response.ok) {
      throw new Error('숙소 데이터 로드 실패');
    }
    
    const data = await response.json();
    console.log('숙소 데이터 로드 성공:', data);
    
    return data;
    
  } catch (error) {
    console.error('숙소 데이터 로드 오류:', error);
    return null;
  }
}

// 숙소 카드 HTML 생성 (동적 생성용)
function createStayCardHTML(stay) {
  // 프로모션 태그
  const promotionTag = stay.isPromotion ? `<div class="stay-card-promotion">프로모션</div>` : '';
  
  // 원래 가격 (할인이 있을 때만 표시)
  const originalPrice = stay.originalPrice ? `<span class="stay-card-price-original">₩${stay.originalPrice.toLocaleString()}</span>` : '';
  
  // 할인율 (할인이 있을 때만 표시)
  const discountText = stay.discount ? `<span class="stay-card-price-discount">${stay.discount}%</span>` : '';
  
  // 찜하기 아이콘 (상태에 따라)
  const heartIcon = stay.isWishlisted ? 'ph-heart-fill' : 'ph-heart';
  const wishlistClass = stay.isWishlisted ? 'active' : '';
  
  return `
    <div class="stay-card" data-stay-id="${stay.id}">
      <div class="stay-card-image">
        <img src="${stay.imageUrl}" alt="${stay.title}" />
        ${promotionTag}
        <button class="stay-card-wishlist ${wishlistClass}" data-wishlist="${stay.isWishlisted}">
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
          ${originalPrice}
          <div class="stay-card-price-main">
            ${discountText}
            <span class="stay-card-price-current">₩${stay.currentPrice.toLocaleString()}~</span>
          </div>
        </div>
      </div>
    </div>
  `;
}
