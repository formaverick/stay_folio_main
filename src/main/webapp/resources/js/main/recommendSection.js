function loadRecommendations(rc_id) {
  fetch(`/recommend/${rc_id}`)
    .then((res) => res.json())
    .then((json) => {
      // 제목 영역 요소 가져오기
      const title = document.getElementById(`title-${rc_id}`);
      const subtitle = document.getElementById(`subtitle-${rc_id}`);
      const track = document.getElementById(`track-${rc_id}`);

	  // 제목과 부제목 분리
      const titleSplit = json.title.split(" - ");
      if (title) title.textContent = titleSplit[0] || "";
      if (subtitle) subtitle.textContent = titleSplit[1] || "";

	  // 기존 캐러셀 내용 초기화
      track.innerHTML = "";

      const stays = json.stays;
      // 3개 단위로 하나의 grid 생성
      for (let i = 0; i < stays.length; i += 3) {
        const grid = document.createElement("div");
        grid.className = "stay-grid";
		
		// 3개씩 끊어서 렌더링
        stays.slice(i, i + 3).forEach((stay) => {
          const item = document.createElement("div");
          item.className = "stay-item";
          item.dataset.stayId = stay.siId;
		
		  // 할인 정보 구성
          const discountSection =
            stay.discount > 0
              ? `
              <span class="stay-price-original">₩${stay.siMinprice.toLocaleString()}</span>
              <div class="stay-price-main">
                <span class="stay-price-discount">${stay.discount}%</span>
                <span class="stay-price-current">₩${stay.discountedPrice.toLocaleString()}~</span>
              </div>`
              : `
              <div class="stay-price-main">
                <span class="stay-price-current">₩${stay.siMinprice.toLocaleString()}~</span>
              </div>`;

          // 프로모션 배지 유무
          const promoBadge =
            stay.discount > 0
              ? `<div class="stay-promotion">프로모션</div>`
              : "";

		  // 이미지 URL (없으면 기본 이미지)
          const imageUrl = stay.spUrl
            ? `https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/${stay.spUrl}`
            : "/resources/img/card1.png";

  		  // 각 숙소 카드 HTML 구성
          item.innerHTML = `
            <div class="stay-image">
              <img src="${imageUrl}" alt="${stay.siName}" />

              ${promoBadge}
              <button class="stay-wishlist" data-wishlist="${stay.bookmarked}">
                <i class="ph ph-heart"></i>
              </button>
            </div>
            <div class="stay-content">
              <h3 class="stay-name">${stay.siName}</h3>
              <div class="stay-location">
                <i class="ph ph-map-pin"></i>
                ${stay.siLoca}
              </div>
              <div class="stay-price">${discountSection}</div>
            </div>
          `;

		  // 현재 grid에 카드 추가
          grid.appendChild(item);
        });

		// 전체 캐러셀 트랙에 grid 추가
        track.appendChild(grid);
      }

	  // 캐러셀 기능, 찜 기능 활성화
      initStayCarouselEvents(rc_id);
      wishEvent();
    });
}

// 동적 섹션 삽입 및 로딩 자동화(추천 영역 rc_id 리스트)
const rcIdList = [1, 2, 3, 4, 5];

// 페이지 로드 후 추천 섹션 생성 및 데이터 로드
document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("recommend-container");

  rcIdList.forEach((rc_id) => {
  	// 각 추천 ID별 섹션 생성
    const section = document.createElement("section");
    section.className = "stay-section";
    
    // 섹션 내부 구조 (제목 + 캐러셀 영역)
    section.innerHTML = `
      <div class="stay-container">
        <div class="stay-header">
          <div class="stay-title-area">
            <h2 class="stay-main-title" id="title-${rc_id}"></h2>
            <p class="stay-sub-title" id="subtitle-${rc_id}"></p>
          </div>
        </div>
      </div>
      <div class="stay-carousel-wrapper">
        <button class="stay-nav-btn stay-nav-prev" id="stayPrevBtn-${rc_id}">
          <i class="ph ph-caret-left"></i>
        </button>
        <div class="stay-carousel">
          <div class="stay-carousel-track" id="track-${rc_id}"></div>
        </div>
        <button class="stay-nav-btn stay-nav-next" id="stayNextBtn-${rc_id}">
          <i class="ph ph-caret-right"></i>
        </button>
      </div>
    `;

	// 추천 섹션을 DOM에 추가
    container.appendChild(section);
    
    // 해당 추천 ID에 맞는 숙소 리스트 로드
    loadRecommendations(rc_id);
  });
});
