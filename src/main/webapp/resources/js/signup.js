// 이메일 유효성 검사
function validateEmail(email) {
  const re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
  return re.test(email);
}

// 비밀번호 유효성 검사 (8자 이상, 영문, 숫자, 특수문자 조합)
function validatePassword(password) {
  const re = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
  return re.test(password);
}

// 이름 유효성 검사 (2자 이상, 한글 또는 영문)
function validateName(name) {
  const re = /^[가-힣a-zA-Z]{2,}$/;
  return re.test(name);
}

// 전화번호 유효성 검사 (숫자 10~11자리)
function validatePhone(phone) {
  const re = /^\d{10,11}$/;
  return re.test(phone);
}

// 입력 필드 유효성 검사 함수
function validateField($field, value) {
  const fieldId = $field.attr("id");
  const $errorMessage = $field.siblings(".error-message");
  let isValid = true;
  let errorMessage = "";

  // 필드별 유효성 검사
  if (fieldId === "email") {
    if (!value) {
      errorMessage = "이메일을 입력해주세요.";
      isValid = false;
    } else if (!validateEmail(value)) {
      errorMessage = "유효한 이메일 주소를 입력해주세요.";
      isValid = false;
    }
  } else if (fieldId === "password") {
    if (!value) {
      errorMessage = "비밀번호를 입력해주세요.";
      isValid = false;
    } else if (!validatePassword(value)) {
      errorMessage =
        "비밀번호는 8자 이상, 영문, 숫자, 특수문자를 포함해야 합니다.";
      isValid = false;
    }
  } else if (fieldId === "name") {
    if (!value) {
      errorMessage = "이름을 입력해주세요.";
      isValid = false;
    } else if (!validateName(value)) {
      errorMessage = "이름은 2자 이상의 한글 또는 영문으로 입력해주세요.";
      isValid = false;
    }
  } else if (fieldId === "phone") {
    if (value && !validatePhone(value.replace(/[^0-9]/g, ""))) {
      errorMessage = "유효한 전화번호를 입력해주세요 (숫자 10~11자리).";
      isValid = false;
    }
  }

  // 에러 메시지 표시/숨김 처리
  if (!isValid) {
    $errorMessage.text(errorMessage).show();
  } else {
    $errorMessage.hide();
  }

  return isValid;
}

// 폼 제출 핸들러
function handleSubmit(e) {
  e.preventDefault();

  // 모든 필드 값 가져오기
  const email = $("#email").val().trim();
  const password = $("#password").val().trim();
  const name = $("#name").val().trim();
  const phone = $("#phone").val().trim();

  // 모든 필드 유효성 검사
  const isEmailValid = validateField($("#email"), email);
  const isPasswordValid = validateField($("#password"), password);
  const isNameValid = validateField($("#name"), name);
  const isPhoneValid = phone ? validateField($("#phone"), phone) : true; // 전화번호는 선택사항

  // 모든 유효성 검사 통과 시
  if (isEmailValid && isPasswordValid && isNameValid && isPhoneValid) {
    console.log("회원가입 시도:", { email, name });
    // 실제 서버로 폼을 제출하고 싶을 때 주석 해제
    // e.currentTarget.submit();
  }
}

// 디바운스 함수
function debounce(func, delay) {
  let timeoutId;
  return function () {
    const context = this;
    const args = arguments;
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => {
      func.apply(context, args);
    }, delay);
  };
}

// 디바운싱이 적용된 검증 함수
const debouncedValidate = debounce(function ($field) {
  validateField($field, $field.val());
}, 500);

$(document).ready(function () {
  // 에러 메시지 초기화
  $(".error-message").hide();

  // 전화번호 입력란에 숫자만 입력 가능하도록 처리
  $("#phone").on("input", function () {
    // 숫자 이외의 문자 제거
    $(this).val(
      $(this)
        .val()
        .replace(/[^0-9]/g, "")
    );
  });

  // 입력 필드 이벤트 리스너
  $("#email, #password, #name, #phone").on({
    // 포커스 아웃 시 검증
    blur: function () {
      validateField($(this), $(this).val());
    },
    // 입력 중 디바운싱 적용된 검증
    input: function () {
      const $field = $(this);
      $field.siblings(".error-message").hide();
      debouncedValidate($field);
    },
  });

  // 폼 제출 이벤트
  $(".signup-form").on("submit", handleSubmit);
});
