(function ($) {
  if (!$) return;

  const $input = $("#keyword");
  if ($input.length === 0) return;

  const $grid = $("#searchResultsGrid");
  const $count = $("#resultsCount");
  const $title = $("#searchTitle");
  const $suggestions = $("#keywordSuggestions");

  const apiUrl =
    $input.data("api") || window.KEYWORD_SEARCH_API || "/search/keyword";
  const ctx =
    $input.data("context") ||
    (typeof window !== "undefined" && window.APP_CONTEXT) ||
    "";

  function readFilters() {
    const checkin = $("#checkin").val() || $("#startDateInput").val() || "";
    const checkout = $("#checkout").val() || $("#endDateInput").val() || "";
    const adult = $("#adult").val() || $("#adultsInput").val() || 2;
    const child = $("#child").val() || $("#childrenInput").val() || 0;
    const region = $("#regionInput").val() || "all";
    return { checkin, checkout, adult, child, region };
  }

  function debounce(fn, delay) {
    let t;
    return function (...args) {
      clearTimeout(t);
      t = setTimeout(() => fn.apply(this, args), delay);
    };
  }

  function sanitize(str) {
    if (str == null) return "";
    return String(str)
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")
      .replace(/"/g, "&quot;")
      .replace(/'/g, "&#39;");
  }

  function pick(obj, keys, fallback = null) {
    for (const k of keys) {
      if (obj && obj[k] != null) return obj[k];
    }
    return fallback;
  }

  function formatPrice(num) {
    if (num == null || isNaN(num)) return "";
    try {
      return Number(num).toLocaleString("ko-KR");
    } catch (e) {
      return String(num);
    }
  }

  function buildCard(stay, filters) {
    const siId = pick(stay, ["siId", "id", "stayId"], "");
    const name = sanitize(pick(stay, ["siName", "name", "title"], ""));
    const loca = sanitize(pick(stay, ["siLoca", "location"], ""));

    const origin =
      typeof window !== "undefined" && window.location && window.location.origin
        ? window.location.origin
        : "";
    const href = siId ? `${origin}${ctx}/stay/${siId}` : "#";

    return `
      <a href="${href}" class="search-min-item">
        <div class="search-min-row" data-stay-id="${siId}">
          <i class="fas fa-home" style="font-size:18px;color:#444;margin-right:10px;"></i>
          <div class="search-min-text">
            <div class="search-min-name" style="font-weight:600;color:#111;">${name}</div>
            <div class="search-min-loca" style="font-size:13px;color:#666;">${loca}</div>
          </div>
        </div>
      </a>`;
  }

  function setLoading(on) {
    if (!$grid.length) return;
    if (on) {
      $grid.css("opacity", 0.5);
    } else {
      $grid.css("opacity", 1);
    }
  }

  function renderResults(results, keyword) {
    if (!$grid.length) return;
    const filters = readFilters();
    if (!Array.isArray(results)) results = [];
    const html = results.map((s) => buildCard(s, filters)).join("");
    $grid.html(html || `<div class="search-empty">검색 결과가 없습니다.</div>`);
    if ($count.length) $count.text(results.length);
    if ($title.length)
      $title.text(keyword ? `${keyword} 검색 결과` : "검색 결과");

    if (typeof window.wishEvent === "function") {
      try {
        window.wishEvent();
      } catch (e) {}
    }
  }

  function search(keyword) {
    const q = (keyword || "").trim();
    if (q.length === 0) {
      if ($suggestions.length) $suggestions.hide();
      return;
    }
    const filters = readFilters();
    setLoading(true);

    $.ajax({
      url: apiUrl,
      method: "GET",
      dataType: "json",
      data: {
        keyword: q,
        checkin: filters.checkin,
        checkout: filters.checkout,
        adult: filters.adult,
        child: filters.child,
        region: filters.region,
      },
    })
      .done(function (res) {
        renderResults(res, q);
      })
      .fail(function () {
        renderResults([], q);
      })
      .always(function () {
        setLoading(false);
        if ($suggestions.length) $suggestions.hide();
      });
  }

  // 추천 검색 함수
  function loadSuggestions(keyword) {
    const q = (keyword || "").trim();
    if (q.length === 0) {
      if ($suggestions.length) $suggestions.hide();
      return;
    }

    $.ajax({
      url: ctx + "/search/suggestions",
      method: "GET",
      dataType: "json",
      data: { keyword: q },
    })
      .done(function (results) {
        updateSuggestions(results);
      })
      .fail(function () {
        if ($suggestions.length) $suggestions.hide();
      });
  }

  // 추천 리스트 업데이트
  function updateSuggestions(results) {
    if (!$suggestions.length) return;

    const $list = $suggestions.find(".keyword-suggestions-list");
    $list.empty();

    if (!results || results.length === 0) {
      $suggestions.hide();
      return;
    }

    results.forEach(function (stay) {
      const $item = $('<li class="keyword-suggestion-item"></li>')
        .attr("data-stay-id", stay.siId)
        .attr("data-stay-name", stay.siName)
        .attr("data-stay-location", stay.siLoca)
        .css("cursor", "pointer");

      // 숙소명과 지역을 구분해서 표시
      const displayText = stay.siName + " (" + stay.siLoca + ")";
      $item.text(displayText);

      // 다중 이벤트 바인딩으로 확실한 클릭 처리
      const handleClick = function (e) {
        e.preventDefault();
        e.stopPropagation();
        e.stopImmediatePropagation();

        console.log("클릭됨:", stay.siName, stay.siId); // 디버깅용

        // 추천 리스트 즉시 숨기기
        if ($suggestions.length) $suggestions.hide();

        const stayId = stay.siId;
        if (stayId) {
          // 숙소 상세 페이지로 이동
          const filters = readFilters();
          const detailUrl =
            ctx +
            "/stay/" +
            stayId +
            "?checkin=" +
            encodeURIComponent(filters.checkin) +
            "&checkout=" +
            encodeURIComponent(filters.checkout) +
            "&adult=" +
            encodeURIComponent(filters.adult) +
            "&child=" +
            encodeURIComponent(filters.child);

          console.log("이동할 URL:", detailUrl); // 디버깅용

          // 즉시 이동
          setTimeout(function () {
            window.location.href = detailUrl;
          }, 50);
        }
      };

      // 여러 이벤트에 바인딩
      $item.on("click", handleClick);
      $item.on("mousedown", handleClick);
      $item.on("touchstart", handleClick);

      $list.append($item);
    });

    $suggestions.show();
  }

  const debouncedSearch = debounce(function () {
    search($input.val());
  }, 300);

  $input.on("input", function () {
    const value = $(this).val();
    if (value.trim().length > 0) {
      // debounce 없이 즉시 API 호출
      loadSuggestions(value);
    } else {
      debouncedSearch();
      if ($suggestions.length) $suggestions.hide();
    }
  });

  $input.on("keydown", function (e) {
    if (e.key === "Enter") {
      e.preventDefault();
      search($input.val());
      if ($suggestions.length) $suggestions.hide();
    } else if (e.key === "Escape") {
      if ($suggestions.length) $suggestions.hide();
    }
  });

  // 포커스 시 추천 표시
  $input.on("focus", function () {
    const value = $(this).val();
    if (value.trim().length > 0) {
      loadSuggestions(value);
    }
  });

  // 기존 이벤트 위임 방식 제거 - 이제 직접 바인딩 방식 사용

  // 외부 클릭 시 추천 숨기기
  $(document).on("click", function (e) {
    if (!$(e.target).closest(".keyword-content").length) {
      if ($suggestions.length) $suggestions.hide();
    }
  });
})(window.jQuery);
