(function ($) {
  if (!$) return;

  const $input = $("#keyword");
  if ($input.length === 0) return;

  const $wrapper = $input.closest(".keyword-content");
  // 최근 자동완성 요청 질의어 추적 (레이트 응답 무시용)
  let lastSuggestQuery = "";

  // 추천 컨테이너 접근/관리 유틸
  function getSuggestionsContainer() {
    return $wrapper.find("#keywordSuggestions, .keyword-suggestions").first();
  }

  function hideAndDestroySuggestions() {
    const $s = getSuggestionsContainer();
    if ($s.length) {
      $s.hide();
      $s.remove();
    }
  }

  function ensureSuggestionsContainer() {
    let $s = getSuggestionsContainer();
    if (!$s.length) {
      $s = $(
        '<div class="keyword-suggestions" id="keywordSuggestions" aria-label="검색 추천" role="listbox"><ul class="keyword-suggestions-list"></ul></div>'
      );
      $wrapper.append($s);
    }
    // 컨테이너만 있고 UL이 없다면 UL 추가 보장
    if (!$s.find(".keyword-suggestions-list").length) {
      $s.append('<ul class="keyword-suggestions-list"></ul>');
    }
    return $s;
  }

  // 초기 상태: 제안 패널 제거
  hideAndDestroySuggestions();

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

  // 제안 표시 가능 여부 체크
  function canShowSuggestions($list) {
    const now = ($input.val() || "").trim();
    if (!$input.is(":focus")) return false;
    if (now.length === 0) return false;
    if (now !== lastSuggestQuery) return false;
    if (!$list || $list.children().length === 0) return false;
    return true;
  }

  function buildCard(stay) {
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

  // 추천 검색 함수
  function loadSuggestions(keyword) {
    const q = (keyword || "").trim();
    if (q.length === 0) {
      hideAndDestroySuggestions();
      return;
    }

    // 현재 질의어 기록
    lastSuggestQuery = q;

    $.ajax({
      url: ctx + "/search/suggestions",
      method: "GET",
      dataType: "json",
      data: { keyword: q },
    })
      .done(function (results) {
        // 입력 값이 변경되었거나 비었으면 무시 및 숨김
        const now = ($input.val() || "").trim();
        if (
          now.length === 0 ||
          now !== lastSuggestQuery ||
          !$input.is(":focus")
        ) {
          hideAndDestroySuggestions();
          return;
        }
        updateSuggestions(results);
      })
      .fail(function () {
        hideAndDestroySuggestions();
      });
  }

  // 추천 리스트 업데이트
  function updateSuggestions(results) {
    // 입력이 비었거나 결과가 없으면 UI 제거
    const nowVal = ($input.val() || "").trim();
    if (nowVal.length === 0 || !results || results.length === 0) {
      hideAndDestroySuggestions();
      return;
    }

    const $s = ensureSuggestionsContainer();
    const $list = $s.find(".keyword-suggestions-list");
    $list.empty();

    results.forEach(function (stay) {
      const $item = $('<li class="keyword-suggestion-item"></li>')
        .attr("data-stay-id", stay.siId)
        .attr("data-stay-name", stay.siName)
        .attr("data-stay-location", stay.siLoca)
        .css("cursor", "pointer");

      const displayText = stay.siName + " (" + stay.siLoca + ")";
      $item.text(displayText);

      const handleClick = function (e) {
        e.preventDefault();
        e.stopPropagation();
        e.stopImmediatePropagation();

        // 추천 리스트 바로 숨기기
        hideAndDestroySuggestions();

        const stayId = stay.siId;
        if (stayId) {
          // 숙소 상세 페이지 이동
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

          // 즉시 이동 (지연 없이 사용자 제스처 유지)
          window.location.assign(detailUrl);
        }
      };

      $item.on("pointerdown", handleClick);

      $list.append($item);
    });

    // 검색 결과/상태 검사 후에만 표시
    const hasItems = $list.children().length > 0 && nowVal.length > 0;
    if (
      !hasItems ||
      nowVal !== lastSuggestQuery ||
      !canShowSuggestions($list)
    ) {
      hideAndDestroySuggestions();
      return;
    }
    $s.show();
  }

  // 중복 제거를 위한 공통 함수
  function handleInputEvent() {
    const value = $input.val();
    if (value.trim().length > 0) {
      loadSuggestions(value);
    } else {
      hideAndDestroySuggestions();
    }
  }

  $input.on("input", handleInputEvent);

  // 포커스 시: 값 있을 때만 추천 표시, 없으면 숨김
  $input.on("focus", handleInputEvent);

  // 클릭 시도 동일 동작: 빈 값이면 숨김
  $input.on("click", function () {
    const value = $input.val();
    if (value.trim().length === 0) {
      hideAndDestroySuggestions();
    }
  });

  // 포커스 아웃 시에도 항상 숨김 (의도치 않은 잔상 방지)
  $input.on("blur", hideAndDestroySuggestions);

  // 외부 클릭 시 추천 숨기기
  $(document).on("click", function (e) {
    if (!$(e.target).closest(".keyword-content").length) {
      hideAndDestroySuggestions();
    }
  });
})(window.jQuery);
