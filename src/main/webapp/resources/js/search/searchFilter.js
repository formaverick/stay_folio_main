$(document).ready(function () {
  // 초기값 설정
  let selectedRegion = "all";
  let adultCount = 2;
  let childCount = 0;

  // 날짜 관련 변수
  let startDate = new Date();
  let endDate = new Date();
  startDate.setDate(startDate.getDate()); // 내일
  endDate.setDate(endDate.getDate() + 1); // 모레

  // 임시 날짜 변수 (적용 버튼 누르기 전까지 실제로 적용되지 않음)
  let tempStartDate = new Date(startDate);
  let tempEndDate = new Date(endDate);

  // 날짜 포맷 함수
  function formatDate(date) {
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const day = String(date.getDate()).padStart(2, "0");
    return `${year}-${month}-${day}`;
  }

  // 날짜 표시 함수
  function updateDateDisplay() {
    $("#startDate").text(formatDate(startDate));
    $("#endDate").text(formatDate(endDate));
  }

  // 날짜 유효성 검사 함수
  function validateDateSelection(start, end) {
    // 오늘 날짜 (시간 제외)
    const today = new Date();
    today.setHours(0, 0, 0, 0);

    // 시작일이 오늘보다 이전인지 확인
    if (start < today) {
      return "체크인 날짜는 오늘 이후여야 합니다.";
    }

    // 종료일이 시작일보다 이전인지 확인
    if (end < start) {
      return "체크아웃 날짜는 체크인 날짜 이후여야 합니다.";
    }

    // 30일 이상 예약 불가
    const dayDiff = Math.ceil((end - start) / (1000 * 60 * 60 * 24));
    if (dayDiff > 30) {
      return "최대 30일까지만 예약 가능합니다.";
    }

    return null; // 유효성 검사 통과
  }

  // 초기 날짜 표시
  updateDateDisplay();

  // 플랫피커 초기화
  const datePicker = flatpickr("#datePicker", {
    mode: "range",
    dateFormat: "Y-m-d",
    defaultDate: [startDate, endDate],
    minDate: "today",
    inline: true,
    showMonths: 2,
    onChange: function (selectedDates) {
      if (selectedDates.length === 2) {
        tempStartDate = selectedDates[0];
        tempEndDate = selectedDates[1];

        // 유효성 검사
        const errorMsg = validateDateSelection(tempStartDate, tempEndDate);
        if (errorMsg) {
          $("#dateError").text(errorMsg).show();
          $("#dateApply").prop("disabled", true).css("opacity", 0.5);
        } else {
          $("#dateError").hide();
          $("#dateApply").prop("disabled", false).css("opacity", 1);
        }
      }
    },
  });

  // 드롭다운 토글 함수
  function toggleDropdown(element) {
    // 다른 모든 드롭다운 닫기
    $(".filter-content").not(element).removeClass("active");
    $(
      ".dropdown-container, .date-picker-container, .people-selector-container"
    ).hide();

    // 현재 드롭다운 토글
    $(element).toggleClass("active");
    $(element)
      .find(
        ".dropdown-container, .date-picker-container, .people-selector-container"
      )
      .toggle();
  }

  // 날짜 선택 클릭 이벤트
  $("#dateSelect").on("click", function (e) {
    e.stopPropagation();
    toggleDropdown(this);

    // 플랫피커 날짜 초기화 (현재 선택된 날짜로)
    datePicker.setDate([startDate, endDate]);
    tempStartDate = new Date(startDate);
    tempEndDate = new Date(endDate);
    $("#dateError").hide();
    $("#dateApply").prop("disabled", false).css("opacity", 1);
  });

  // 날짜 취소 버튼 클릭 이벤트
  $("#dateCancel").on("click", function (e) {
    e.stopPropagation();
    $("#dateSelect").removeClass("active");
    $(".date-picker-container").hide();
  });

  // 날짜 적용 버튼 클릭 이벤트
  $("#dateApply").on("click", function (e) {
    e.stopPropagation();

    // 유효성 검사
    const errorMsg = validateDateSelection(tempStartDate, tempEndDate);
    if (errorMsg) {
      $("#dateError").text(errorMsg).show();
      return;
    }

    // 날짜 적용
    startDate = tempStartDate;
    endDate = tempEndDate;
    updateDateDisplay();

    // 드롭다운 닫기
    $("#dateSelect").removeClass("active");
    $(".date-picker-container").hide();
  });

  // 인원 선택 드롭다운 토글
  $("#peopleSelect").on("click", function (e) {
    e.stopPropagation();
    const peopleSelector = $(this).find(".people-selector-container");

    // 다른 드롭다운 닫기
    $(".dropdown-container, .date-picker-container, .people-selector-container")
      .not(peopleSelector)
      .hide();
    $(".filter-content").not($(this)).removeClass("active");

    peopleSelector.toggle();
    $(this).toggleClass("active");
  });

  // 지역 옵션 선택 이벤트
  $(".dropdown-options .option").on("click", function () {
    const value = $(this).data("value");
    const text = $(this).text();
    selectedRegion = value;

    $("#regionSelect .selected-option span").text(text);
    $(".dropdown-options .option").removeClass("selected");
    $(this).addClass("selected");

    // 드롭다운 닫기
    $("#regionSelect").removeClass("active");
    $(".dropdown-container").hide();
  });

  // 인원 증감 버튼 이벤트
  $(".counter-btn").on("click", function (e) {
    e.stopPropagation();

    const type = $(this).data("type");
    const isIncrease = $(this).hasClass("increase");

    if (type === "adult") {
      if (isIncrease) {
        if (adultCount < 10) adultCount++;
      } else {
        if (adultCount > 1) adultCount--;
      }
      $("#adultCount").text(adultCount);
    } else if (type === "child") {
      if (isIncrease) {
        if (childCount < 6) childCount++;
      } else {
        if (childCount > 0) childCount--;
      }
      $("#childCount").text(childCount);
    }

    // 인원 정보 업데이트
    updatePeopleDisplay();
  });

  // 인원 표시 업데이트
  function updatePeopleDisplay() {
    let displayText = `성인 ${adultCount}명`;
    if (childCount > 0) {
      displayText += `, 아동 ${childCount}명`;
    }
    $("#peopleDisplay").text(displayText);

    // 버튼 비활성화 처리
    if (adultCount <= 1) {
      $('.counter-btn.decrease[data-type="adult"]').addClass("disabled");
    } else {
      $('.counter-btn.decrease[data-type="adult"]').removeClass("disabled");
    }

    if (adultCount >= 10) {
      $('.counter-btn.increase[data-type="adult"]').addClass("disabled");
    } else {
      $('.counter-btn.increase[data-type="adult"]').removeClass("disabled");
    }

    if (childCount <= 0) {
      $('.counter-btn.decrease[data-type="child"]').addClass("disabled");
    } else {
      $('.counter-btn.decrease[data-type="child"]').removeClass("disabled");
    }

    if (childCount >= 6) {
      $('.counter-btn.increase[data-type="child"]').addClass("disabled");
    } else {
      $('.counter-btn.increase[data-type="child"]').removeClass("disabled");
    }
  }

  // 초기 인원 표시 업데이트
  updatePeopleDisplay();

  // 검색 버튼 클릭 이벤트
  $("#searchButton").on("click", function () {
    // URL 파라미터 생성
    const params = new URLSearchParams();
    params.append("region", selectedRegion);
    params.append("checkIn", formatDate(startDate));
    params.append("checkOut", formatDate(endDate));
    params.append("adult", adultCount);
    params.append("child", childCount);

    // 검색 페이지로 이동
    window.location.href = `search.jsp?${params.toString()}`;
  });

  // 바깥 영역 클릭 시 드롭다운 닫기
  $(document).on("click", function (e) {
    if (!$(e.target).closest(".filter-content").length) {
      $(".filter-content").removeClass("active");
      $(
        ".dropdown-container, .date-picker-container, .people-selector-container"
      ).hide();
    }
  });

  // URL 파라미터 파싱 함수
  function getUrlParams() {
    const params = new URLSearchParams(window.location.search);
    const result = {};

    for (const [key, value] of params) {
      result[key] = value;
    }

    return result;
  }

  // URL 파라미터 적용
  function applyUrlParams() {
    const params = getUrlParams();

    if (params.region) {
      selectedRegion = params.region;
      const regionText = $(
        `.dropdown-options .option[data-value="${params.region}"]`
      ).text();
      $("#regionSelect .selected-option").text(regionText || "전국");
    }

    if (params.checkIn && params.checkOut) {
      startDate = new Date(params.checkIn);
      endDate = new Date(params.checkOut);
      updateDateDisplay();
      datePicker.setDate([startDate, endDate]);
    }

    if (params.adult) {
      adultCount = parseInt(params.adult);
    }

    if (params.child) {
      childCount = parseInt(params.child);
    }

    updatePeopleDisplay();
  }

  // URL 파라미터 적용
  applyUrlParams();
});
