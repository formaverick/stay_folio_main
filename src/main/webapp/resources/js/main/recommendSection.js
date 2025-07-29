function loadRecommendations(rc_id) {
  fetch(`/recommend/${rc_id}`)
    .then((res) => res.json())
    .then((json) => {
      const title = document.getElementById(`title-${rc_id}`);
      const subtitle = document.getElementById(`subtitle-${rc_id}`);
      const track = document.getElementById(`track-${rc_id}`);

      const titleSplit = json.title.split(" - ");
      if (title) title.textContent = titleSplit[0] || "";
      if (subtitle) subtitle.textContent = titleSplit[1] || "";

      track.innerHTML = "";

	  console.log(json);
      const stays = json.stays;
      for (let i = 0; i < stays.length; i += 3) {
        const grid = document.createElement("div");
        grid.className = "stay-grid";

        stays.slice(i, i + 3).forEach((stay) => {
          const item = document.createElement("div");
          item.className = "stay-item";
          item.dataset.stayId = stay.siId;

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

          const promoBadge =
            stay.discount > 0
              ? `<div class="stay-promotion">프로모션</div>`
              : "";

          const imageUrl = stay.spUrl
            ? `https://stayfolio-upload-bucket.s3.us-east-1.amazonaws.com/${stay.spUrl}`
            : "/resources/img/card1.png";

          item.innerHTML = `
            <div class="stay-image">
              <img src="${imageUrl}" alt="${stay.siName}" />

              ${promoBadge}
              <button class="stay-wishlist" data-wishlist="false">
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

          item.addEventListener("click", () => {
            window.location.href = `/stay/${stay.siId}`;
          });

          grid.appendChild(item);
        });

        track.appendChild(grid);
      }

      initStayCarouselEvents(rc_id);
      initWishlistEvents();
    });
}

// 동적 섹션 삽입 및 로딩 자동화
const rcIdList = [1, 2, 3, 4, 5];

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("recommend-container");

  rcIdList.forEach((rc_id) => {
    const section = document.createElement("section");
    section.className = "stay-section";
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

    container.appendChild(section);
    loadRecommendations(rc_id);
  });
});
