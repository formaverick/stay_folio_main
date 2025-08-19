$(document).ready(function () {
  console.log("roomRegister.js 기본 유효성 검사만 활성화");

  // 파일 클릭 시 siId 검사
  $(".file-input").on("click", function (e) {
    const siId = $("#image-siId").val();

    if (!siId || siId.trim() === "") {
      openModalAndRedirect("⚠️ 숙소 정보를 먼저 등록해주세요.");
      e.preventDefault();
      return false;
    }
  });

  $(".room-file-input").on("click", function (e) {
    const riId = $("#image-riId").val();

    if (!riId || riId.trim() === "") {
      openModalAndRedirect("⚠️ 객실 정보를 먼저 등록해주세요.");
      e.preventDefault();
      return false;
    }
  });

  // 파일 선택 시 파일명 표시
  $(".file-input").on("change", function () {
    const fileName = this.files[0]?.name || "파일을 선택해주세요.";
    const inputId = $(this).attr("id");
    const label = $(`label[for="${inputId}"]`).find(".file-text");
    label.text(fileName);
  });

  // blur 이벤트로만 필드 유효성 검사
  $(".form-input, .form-select, .form-textarea").on("blur", validateField);

  // 에러 스타일 적용
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
    case "siMaxperson":
      if (
        value &&
        (isNaN(value) || parseInt(value) < 1 || parseInt(value) > 20)
      ) {
        isValid = false;
        errorMessage = "인원은 1~20명 사이로 입력해주세요.";
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
