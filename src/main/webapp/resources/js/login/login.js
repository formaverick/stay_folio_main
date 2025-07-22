function validateEmail(email) {
  const re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
  return re.test(email);
}

function validatePassword(password) {
  const re = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
  return re.test(password);
}

function validateField($field, value) {
  const fieldId = $field.attr("id");
  const $errorMessage = $field.siblings(".error-message");
  let isValid = true;

  if (value.trim() === "") {
    $errorMessage
      .text(
        fieldId === "username"
          ? "이메일을 입력해주세요."
          : "비밀번호를 입력해주세요."
      )
      .show();
    isValid = false;
  } else if (fieldId === "username" && !validateEmail(value)) {
    $errorMessage.text("이메일 형식이 올바르지 않습니다.").show();
    isValid = false;
  } else if (fieldId === "password" && !validatePassword(value)) {
    $errorMessage
      .html(
        "8자 이상으로 입력해주세요<br>영문, 숫자, 특수문자를 조합하여 입력해주세요."
      )
      .show();
    isValid = false;
  } else {
    $errorMessage.hide();
  }

  return isValid;
}

function handleSubmit(e) {
  e.preventDefault();

  const $form = $(this);
  const email = $("#username").val().trim();
  const password = $("#password").val().trim();

  const isEmailValid = validateField($("#username"), email);
  const isPasswordValid = validateField($("#password"), password);

  if (isEmailValid && isPasswordValid) {
    console.log("로그인 시도:", email);
    // 실제 서버로 폼을 제출하고 싶을 때 주석 해제
    $form[0].submit();
  }
}

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

const debouncedValidate = debounce(function ($field) {
  validateField($field, $field.val());
}, 500);

$(document).ready(function () {
  $(".error-message").hide();

  $("#username, #password").on({
    blur: function () {
      validateField($(this), $(this).val());
    },
    input: function () {
      const $field = $(this);
      $field.siblings(".error-message").hide();
      debouncedValidate($field);
    },
  });

  // 폼 제출 이벤트
  $(".login-form").on("submit", handleSubmit);

  // 카카오 로그인 버튼 클릭 이벤트
  $(".btn-kakao").on("click", function () {
    console.log("카카오 로그인 클릭");
    // 카카오 로그인 로직 추가
  });

  // 회원가입 버튼 클릭 이벤트
  $(".btn-join").on("click", function () {
    console.log("회원가입 클릭");
  });
});
