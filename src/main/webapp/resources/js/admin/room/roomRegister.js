$(document).ready(function () {
  console.log("숙소 등록 페이지 초기화");
  initializeForm();
  initializeImageUploads();

  // 페이지 로드 시 콘솔 로그
  console.log("폼 분리 구조 초기화: 기본정보, 상세정보, 이미지");
});

// 폼 초기화
function initializeForm() {
  // 기본 정보 폼 제출 이벤트
  $("#basic-info-form").on("submit", function(e) {
    e.preventDefault();
    handleBasicInfoSubmit();
  });
  
  // 상세 정보 폼 제출 이벤트
  $("#detail-info-form").on("submit", function(e) {
    e.preventDefault();
    handleDetailInfoSubmit();
  });
  
  // 이미지 업로드 폼 제출 이벤트
  $("#image-upload-form").on("submit", function(e) {
    e.preventDefault();
    handleImageUploadSubmit();
  });

  // 폼 유효성 검사
  $(".form-input, .form-select, .form-textarea").on("blur", validateField);

  console.log("폼 이벤트 리스너 등록 완료");
}

// 기본 정보 폼 제출 처리
function handleBasicInfoSubmit() {
  console.log("기본 정보 폼 제출 시도");

  // 폼 유효성 검사
  if (!validateBasicInfoForm()) {
    return false;
  }

  // 유효성 검사 통과 시 AJAX로 제출
  const formData = new FormData(document.getElementById("basic-info-form"));
  
  $.ajax({
    url: "/admin/room/saveBasicInfo",
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function(response) {
      console.log("기본 정보 저장 성공:", response);
      alert("기본 정보가 저장되었습니다.");
      
      // 성공 시 숙소 ID를 저장하고 다음 폼에서 사용할 수 있도록 함
      if (response.siId) {
        sessionStorage.setItem("currentSiId", response.siId);
        // 다음 폼으로 자동 스크롤
        $('html, body').animate({
          scrollTop: $("#detail-info-form").offset().top - 50
        }, 500);
      }
    },
    error: function(xhr, status, error) {
      console.error("기본 정보 저장 오류:", error);
      alert("기본 정보 저장 중 오류가 발생했습니다.");
    }
  });
  
  return true;
}

// 상세 정보 폼 제출 처리
function handleDetailInfoSubmit() {
  console.log("상세 정보 폼 제출 시도");

  // 폼 유효성 검사
  if (!validateDetailInfoForm()) {
    return false;
  }

  // 유효성 검사 통과 시 AJAX로 제출
  const formData = new FormData(document.getElementById("detail-info-form"));
  
  // 숙소 ID를 폼데이터에 추가 (기본 정보에서 저장된 ID)
  const siId = sessionStorage.getItem("currentSiId");
  if (siId) {
    formData.append("siId", siId);
  }
  
  // 체크박스 값 처리 (unchecked일 경우 false 값 설정)
  if (!formData.has("siPet")) formData.append("siPet", "false");
  if (!formData.has("siParking")) formData.append("siParking", "false");
  if (!formData.has("siFood")) formData.append("siFood", "false");
  
  $.ajax({
    url: "/admin/room/saveDetailInfo",
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function(response) {
      console.log("상세 정보 저장 성공:", response);
      alert("상세 정보가 저장되었습니다.");
      
      // 다음 폼으로 자동 스크롤
      $('html, body').animate({
        scrollTop: $("#image-upload-form").offset().top - 50
      }, 500);
    },
    error: function(xhr, status, error) {
      console.error("상세 정보 저장 오류:", error);
      alert("상세 정보 저장 중 오류가 발생했습니다.");
    }
  });
  
  return true;
}

// 이미지 업로드 폼 제출 처리
function handleImageUploadSubmit() {
  console.log("이미지 업로드 폼 제출 시도");

  // 이미지 유효성 검사
  if (!validateImages()) {
    return false;
  }

  // 유효성 검사 통과 시 AJAX로 제출
  const formData = new FormData(document.getElementById("image-upload-form"));
  
  // 숙소 ID를 폼데이터에 추가 (기본 정보에서 저장된 ID)
  const siId = sessionStorage.getItem("currentSiId");
  if (siId) {
    formData.append("siId", siId);
  }
  
  $.ajax({
    url: "/admin/room/saveImages",
    type: "POST",
    data: formData,
    processData: false,
    contentType: false,
    success: function(response) {
      console.log("이미지 업로드 성공:", response);
      alert("이미지가 성공적으로 업로드되었습니다.");
      
      // 숙소 등록 완료 후 리스트 페이지로 이동 또는 다른 작업 수행
      if (confirm("숙소 등록이 완료되었습니다. 리스트 페이지로 이동하시겠습니까?")) {
        window.location.href = "/admin/room/list";
      }
    },
    error: function(xhr, status, error) {
      console.error("이미지 업로드 오류:", error);
      alert("이미지 업로드 중 오류가 발생했습니다.");
    }
  });
  
  return true;
}

// 필드 유효성 검사
function validateField(e) {
  const field = $(e.target);
  const value = field.val().trim();
  const fieldName = field.attr("name");

  // 기존 에러 메시지 제거
  field.removeClass("error");
  field.next(".error-message").remove();

  let isValid = true;
  let errorMessage = "";

  // 필수 필드 검사
  if (field.prop("required") && !value) {
    isValid = false;
    errorMessage = "필수 입력 항목입니다.";
  }

  // 특정 필드별 검사
  switch (fieldName) {
    case "siName":
      if (value && value.length < 2) {
        isValid = false;
        errorMessage = "숙소 이름은 2글자 이상 입력해주세요.";
      } else if (value && value.length > 50) {
        isValid = false;
        errorMessage = "숙소 이름은 50글자 이하로 입력해주세요.";
      }
      break;

    case "siDesc":
      if (value && value.length > 200) {
        isValid = false;
        errorMessage = "짧은 설명은 200글자 이하로 입력해주세요.";
      }
      break;

    case "siMinprice":
      if (value && (isNaN(value) || parseInt(value) < 1000)) {
        isValid = false;
        errorMessage = "최소가격은 1,000원 이상 입력해주세요.";
      }
      break;

    case "siExtra":
      if (value && (isNaN(value) || parseInt(value) < 0)) {
        isValid = false;
        errorMessage = "추가인원 금액은 0원 이상 입력해주세요.";
      }
      break;

    case "siMinperson":
      if (
        value &&
        (isNaN(value) || parseInt(value) < 1 || parseInt(value) > 20)
      ) {
        isValid = false;
        errorMessage = "최소인원은 1~20명 사이로 입력해주세요.";
      }
      break;

    case "siMaxperson":
      if (
        value &&
        (isNaN(value) || parseInt(value) < 1 || parseInt(value) > 20)
      ) {
        isValid = false;
        errorMessage = "최대인원은 1~20명 사이로 입력해주세요.";
      }
      // 최소인원보다 최대인원이 작으면 안됨
      const minPerson = parseInt($("#si-minperson").val()) || 0;
      if (value && parseInt(value) < minPerson) {
        isValid = false;
        errorMessage = "최대인원은 최소인원보다 크거나 같아야 합니다.";
      }
      break;
  }

  // 에러 표시
  if (!isValid) {
    field.addClass("error");
    field.after(`<div class="error-message">${errorMessage}</div>`);
  }

  return isValid;
}

// 기본 정보 폼 유효성 검사
function validateBasicInfoForm() {
  console.log("기본 정보 폼 유효성 검사 시작");
  let isValid = true;

  // 기본 정보 폼의 필수 필드 검사
  $("#basic-info-form .form-input[required], #basic-info-form .form-select[required], #basic-info-form .form-textarea[required]").each(function () {
    if (!validateField({ target: this })) {
      isValid = false;
    }
  });

  // 최소/최대 인원 비교 검사
  const minPerson = parseInt($("#si-minperson").val()) || 0;
  const maxPerson = parseInt($("#si-maxperson").val()) || 0;

  if (minPerson > 0 && maxPerson > 0 && minPerson > maxPerson) {
    alert("최소인원이 최대인원보다 클 수 없습니다.");
    $("#si-minperson").focus();
    isValid = false;
  }

  if (!isValid) {
    alert("기본 정보를 다시 확인해주세요.");
  } else {
    console.log("기본 정보 폼 유효성 검사 통과");
  }

  return isValid;
}

// 상세 정보 폼 유효성 검사
function validateDetailInfoForm() {
  console.log("상세 정보 폼 유효성 검사 시작");
  let isValid = true;

  // 상세 정보 폼의 필수 필드 검사
  $("#detail-info-form .form-input[required], #detail-info-form .form-select[required], #detail-info-form .form-textarea[required]").each(function () {
    if (!validateField({ target: this })) {
      isValid = false;
    }
  });
  
  // 사업자번호 형식 검사
  const bizNum = $("#si-biznum").val().trim();
  if (bizNum && !/^\d{10}$/.test(bizNum)) {
    showError($("#si-biznum"), "사업자번호는 10자리 숫자로 입력해주세요.");
    isValid = false;
  }
  
  // 전화번호 형식 검사
  const phone = $("#si-phone").val().trim();
  if (phone && !/^\d{9,11}$/.test(phone)) {
    showError($("#si-phone"), "전화번호는 9~11자리 숫자로 입력해주세요.");
    isValid = false;
  }

  if (!isValid) {
    alert("상세 정보를 다시 확인해주세요.");
  } else {
    console.log("상세 정보 폼 유효성 검사 통과");
  }

  return isValid;
}

// 이미지 업로드 관련 함수
function initializeImageUploads() {
  // 대표 이미지 파일 선택 이벤트
  $("#main-image").on("change", function (e) {
    updateFileUpload(this, "main-upload-status");
  });

  // 추가 이미지 파일 선택 이벤트 (6개 모두에 대해)
  for (let i = 1; i <= 6; i++) {
    $(`#image-${i}`).on("change", function () {
      updateFileUpload(this, `upload-status-${i}`);
    });

    // 초기 상태 설정
    $(`#upload-status-${i}`).find(".file-name").text("선택된 파일이 없습니다");
  }

  // 페이지 로드 시 기존 파일이 있는지 확인
  $('input[type="file"]').each(function () {
    if ($(this).val()) {
      const statusId = $(this)
        .attr("onchange")
        .match(/'([^']+)'/)[1];
      updateFileUpload(this, statusId);
    }
  });
}

// 파일 업로드 상태를 업데이트하는 함수
function updateFileUpload(input, statusId) {
  console.log('updateFileUpload 함수 호출됨', input.id, statusId);
  
  const $status = $(`#${statusId}`);
  const $fileName = $status.find('.file-name');
  const $label = $(input).siblings('.file-upload-label');
  const $wrapper = $(input).closest('.file-upload-wrapper');
  
  if (input.files && input.files[0]) {
    // 파일이 선택된 경우
    console.log('파일 선택됨:', input.files[0].name);
    $fileName.text(input.files[0].name);
    setTimeout(() => {
      $status.addClass('visible');
      console.log('visible 클래스 추가됨', statusId, $status.hasClass('visible'));
    }, 10); // 애니메이션을 위한 지연
    $label.addClass('has-file');
    $wrapper.addClass('file-selected'); // 파일이 선택되면 wrapper에 클래스 추가
  } else {
    // 파일이 선택되지 않은 경우
    console.log('파일 선택되지 않음');
    $fileName.text('선택된 파일이 없습니다');
    $status.removeClass('visible');
    console.log('visible 클래스 제거됨', statusId, $status.hasClass('visible'));
    $label.removeClass('has-file');
    $wrapper.removeClass('file-selected'); // 파일이 선택되지 않으면 wrapper에서 클래스 제거
  }
  
  // 폼 유효성 검사 업데이트
  if (input.hasAttribute('required')) {
    if (input.files && input.files[0]) {
      input.setCustomValidity('');
    } else {
      input.setCustomValidity('파일을 선택해주세요');
    }
  }
}

// 파일 삭제 함수
function removeFile(inputId) {
  console.log('removeFile 함수 호출됨', inputId);
  
  const $input = $(`#${inputId}`);
  const $status = $input.siblings(".file-upload-status");
  const $label = $input.siblings(".file-upload-label");
  const $wrapper = $input.closest('.file-upload-wrapper');

  // 입력 필드 초기화
  $input.val("");
  console.log('파일 입력 초기화됨');

  // 상태 표시 업데이트
  $status.removeClass("visible");
  console.log('visible 클래스 제거됨 (삭제 버튼)', $status.hasClass('visible'));
  $status.find(".file-name").text("선택된 파일이 없습니다");
  $label.removeClass("has-file");
  $wrapper.removeClass("file-selected"); // 파일 삭제 시 file-selected 클래스 제거

  // 폼 유효성 검사 초기화
  if ($input[0].hasAttribute("required")) {
    $input[0].setCustomValidity("");
  }
}

// 이미지 유효성 검사
function validateImages() {
  const mainImage = $("#main-image")[0].files[0];

  // 대표 이미지 필수 체크
  if (!mainImage) {
    showError(
      $("#main-image").closest(".form-group"),
      "대표 이미지는 필수 항목입니다."
    );
    return false;
  }

  // 파일 형식 및 크기 검사
  const validImageTypes = ["image/jpeg", "image/png", "image/gif"];
  const maxSize = 5 * 1024 * 1024; // 5MB

  // 대표 이미지 검사
  if (!validImageTypes.includes(mainImage.type)) {
    showError(
      $("#main-image").closest(".form-group"),
      "유효한 이미지 파일 형식이 아닙니다. (JPEG, PNG, GIF만 가능)"
    );
    return false;
  }

  if (mainImage.size > maxSize) {
    showError(
      $("#main-image").closest(".form-group"),
      "이미지 크기는 5MB를 초과할 수 없습니다."
    );
    return false;
  }

  // 추가 이미지 검사
  for (let i = 1; i <= 6; i++) {
    const input = $(`#image-${i}`)[0];
    if (input.files.length > 0) {
      const file = input.files[0];

      if (!validImageTypes.includes(file.type)) {
        showError(
          $(input).closest(".form-group"),
          `추가 이미지 ${i}: 유효한 이미지 파일 형식이 아닙니다.`
        );
        return false;
      }

      if (file.size > maxSize) {
        showError(
          $(input).closest(".form-group"),
          `추가 이미지 ${i}: 이미지 크기는 5MB를 초과할 수 없습니다.`
        );
        return false;
      }
    }
  }

  return true;
}

// 에러 메시지 표시
function showError(element, message) {
  // 기존 에러 메시지 제거
  element.find(".error-message").remove();

  // 에러 메시지 추가
  element.append(
    `<div class="error-message" style="color: #e74c3c; font-size: 0.8rem; margin-top: 0.25rem;">${message}</div>`
  );

  // 스크롤 이동
  $("html, body").animate(
    {
      scrollTop: element.offset().top - 100,
    },
    300
  );
}

// CSS 에러 스타일 추가
$(document).ready(function () {
  $("<style>")
    .prop("type", "text/css")
    .html(
      `
      .form-input.error,
      .form-select.error,
      .form-textarea.error {
        border-color: #dc3545 !important;
        box-shadow: 0 0 0 3px rgba(220, 53, 69, 0.1) !important;
      }
      
      .error-message {
        color: #dc3545;
        font-size: 0.8rem;
        margin-top: 0.25rem;
        font-weight: 500;
      }
    `
    )
    .appendTo("head");
});
