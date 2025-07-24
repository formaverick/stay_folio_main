$(document).ready(function () {
  // 초기값 설정
  let selectedRegion = "all";
  let adultCount = 2;
  let childCount = 0;

  // 날짜 관련 변수
  let startDate = new Date();
  let endDate = new Date();
  startDate.setDate(startDate.getDate()); // 오늘
  endDate.setDate(endDate.getDate() + 1); // 내일

  // 임시 날짜 변수 (적용 버튼 누르기 전까지 실제로 적용되지 않음)
  let tempStartDate = new Date(startDate);
  let tempEndDate = new Date(endDate);

  // 요일 이름 배열
  const weekdays = ["일", "월", "화", "수", "목", "금", "토"];

  // 날짜 포맷 함수 (MM.DD 요일 형식)
  function formatDate(date) {
    const month = String(date.getMonth() + 1).padStart(2, "0");
    const day = String(date.getDate()).padStart(2, "0");
    const weekday = weekdays[date.getDay()];
    return `${month}.${day} ${weekday}`;
  }

  // 날짜 포맷 함수 (서버 전송용 YYYY-MM-DD 형식)
  function formatDateForServer(date) {
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
    maxDate: new Date().fp_incr(365), // 1년 후까지만 선택 가능
    inline: true,
    showMonths: 2,
    monthSelectorType: "static", // 월 선택 방식 개선
    enableTime: false,
    animate: true,
    onDayCreate: function(dObj, dStr, fp, dayElem) {
      // 첫 번째 날짜가 선택된 경우, 그 이전 날짜들을 비활성화
      if (fp.selectedDates.length === 1) {
        const firstSelectedDate = fp.selectedDates[0];
        const dayDate = dayElem.dateObj;
        
        if (dayDate < firstSelectedDate) {
          dayElem.classList.add('flatpickr-disabled');
          dayElem.setAttribute('aria-disabled', 'true');
        }
      }
    },
    locale: {
      firstDayOfWeek: 1, // 월요일부터 시작
      weekdays: {
        shorthand: ["일", "월", "화", "수", "목", "금", "토"],
        longhand: [
          "일요일",
          "월요일",
          "화요일",
          "수요일",
          "목요일",
          "금요일",
          "토요일",
        ],
      },
      months: {
        shorthand: [
          "1월",
          "2월",
          "3월",
          "4월",
          "5월",
          "6월",
          "7월",
          "8월",
          "9월",
          "10월",
          "11월",
          "12월",
        ],
        longhand: [
          "1월",
          "2월",
          "3월",
          "4월",
          "5월",
          "6월",
          "7월",
          "8월",
          "9월",
          "10월",
          "11월",
          "12월",
        ],
      },
    },
    onChange: function (selectedDates) {
      if (selectedDates.length === 2) {
        tempStartDate = selectedDates[0];
        tempEndDate = selectedDates[1];

        // 유효성 검사
        const errorMsg = validateDateSelection(tempStartDate, tempEndDate);
        if (errorMsg) {
          $("#dateError").text(errorMsg).show().addClass("shake");
          $("#dateApply").prop("disabled", true).css("opacity", 0.5);
          setTimeout(() => $("#dateError").removeClass("shake"), 500);
        } else {
          $("#dateError").hide();
          $("#dateApply").prop("disabled", false).css("opacity", 1);
        }
      } else if (selectedDates.length === 1) {
        // 시작일만 선택된 경우
        tempStartDate = selectedDates[0];
        $("#dateError").hide();
        $("#dateApply").prop("disabled", true).css("opacity", 0.5);
        
        // 첫 번째 날짜 선택 후 달력 다시 렌더링하여 이전 날짜들 비활성화
        setTimeout(() => {
          this.redraw();
        }, 10);
      }
    },
    onReady: function (selectedDates, dateStr, instance) {
      // 월 네비게이션 버튼 강제 활성화
      setTimeout(() => {
        const prevButton = instance.prevMonthNav;
        const nextButton = instance.nextMonthNav;

        if (prevButton) {
          prevButton.style.pointerEvents = "auto";
          prevButton.style.cursor = "pointer";
          prevButton.style.zIndex = "1000";
          prevButton.style.position = "absolute";
          prevButton.removeAttribute("tabindex");

          // 기존 이벤트 리스너 제거 후 새로 추가
          prevButton.onclick = null;
          prevButton.addEventListener("click", function (e) {
            e.preventDefault();
            e.stopPropagation();
            instance.changeMonth(-1);
          });
        }

        if (nextButton) {
          nextButton.style.pointerEvents = "auto";
          nextButton.style.cursor = "pointer";
          nextButton.style.zIndex = "1000";
          nextButton.style.position = "absolute";
          nextButton.removeAttribute("tabindex");

          // 기존 이벤트 리스너 제거 후 새로 추가
          nextButton.onclick = null;
          nextButton.addEventListener("click", function (e) {
            e.preventDefault();
            e.stopPropagation();
            instance.changeMonth(1);
          });
        }
      }, 100);
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

    // 월 네비게이션 버튼 이벤트 재설정 (fallback)
    setTimeout(() => {
      $(document)
        .off("click.monthNav")
        .on(
          "click.monthNav",
          ".flatpickr-prev-month, .flatpickr-next-month",
          function (e) {
            e.preventDefault();
            e.stopPropagation();

            const isPrev = $(this).hasClass("flatpickr-prev-month");
            if (isPrev) {
              datePicker.changeMonth(-1);
            } else {
              datePicker.changeMonth(1);
            }
          }
        );
    }, 200);
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

  // 검색 버튼 클릭 시만 폼 제출 처리
  $("#searchButton").on("click", function (e) {
    e.preventDefault();

    // 현재 필터 값들을 숨겨진 입력 필드에 설정 (서버용 포맷)
    $("#regionInput").val(selectedRegion);
    $("#startDateInput").val(formatDateForServer(startDate));
    $("#endDateInput").val(formatDateForServer(endDate));
    $("#adultsInput").val(adultCount);
    $("#childrenInput").val(childCount);

    console.log("검색 버튼 클릭 - 폼 제출:", {
      region: selectedRegion,
      startDate: formatDateForServer(startDate),
      endDate: formatDateForServer(endDate),
      adults: adultCount,
      children: childCount,
    });

    // 폼 제출
    $("#searchForm").submit();
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

  // 외부 클릭 시 모든 드롭다운 닫기
  $(document).on("click", function (e) {
    if (
      !$(e.target).closest(
        ".dropdown-container, .date-picker-container, .people-selector-container"
      ).length
    ) {
      $(
        ".dropdown-container, .date-picker-container, .people-selector-container"
      ).hide();
    }
  });

  // 안내사항 아코디언 기능
  $(".guideline-header").on("click", function () {
    const $header = $(this);
    const target = $header.data("target");
    const $content = $("#" + target);
    const $icon = $header.find("i");

    // 현재 아이템이 활성화되어 있는지 확인
    const isActive = $header.hasClass("active");

    // 모든 아코디언 닫기
    $(".guideline-header").removeClass("active");
    $(".guideline-content").removeClass("active").slideUp(300);

    // 현재 아이템이 비활성화 상태였다면 열기
    if (!isActive) {
      $header.addClass("active");
      $content.addClass("active").slideDown(300);
    }
  });
});
