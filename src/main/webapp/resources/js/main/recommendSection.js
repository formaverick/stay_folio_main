function loadRecommendations(rc_id) {
  fetch(`/recommend/${rc_id}`)
    .then(res => res.json())
    .then(json => {
      const title = document.getElementById(`title-${rc_id}`);
      const subtitle = document.getElementById(`subtitle-${rc_id}`);
      const track = document.getElementById(`track-${rc_id}`);

      // 제목
      const titleSplit = json.title.split(" - ");
      if (title) title.textContent = titleSplit[0] || "";
      if (subtitle) subtitle.textContent = titleSplit[1] || "";

      track.innerHTML = "";

      const stays = json.stays;
      for (let i = 0; i < stays.length; i += 3) {
        const grid = document.createElement("div");
        grid.className = "stay-grid";

        stays.slice(i, i + 3).forEach(stay => {
          const item = document.createElement("div");
          item.className = "stay-item";
          item.dataset.stayId = stay.siId;

          const discountSection = stay.discount > 0
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

          const promoBadge = stay.discount > 0 ? `<div class="stay-promotion">프로모션</div>` : "";

          item.innerHTML = `
            <div class="stay-image">
              <img src="${stay.spUrl}" alt="${stay.siName}" />
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
      
      initStayCarouselEvents();
      initWishlistEvents();
    });
}

// 실제 호출 rc_id 기준
document.addEventListener("DOMContentLoaded", () => {
  loadRecommendations(1);
});
