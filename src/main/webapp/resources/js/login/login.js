// 이메일 유효성을 검사하는 함수
function validateEmail(email) {
  // 이메일 형식을 확인하는 정규식
  // 예: user@example.com
  const re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
  return re.test(email);
}

// 비밀번호 유효성을 검사하는 함수
function validatePassword(password) {
  // 비밀번호가 최소 8자 이상이며, 영문, 숫자, 특수문자를 포함하는지 확인하는 정규식
  const re = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
  return re.test(password);
}

// 입력 필드의 유효성을 검사, 에러 메시지를 표시하는 함수
function validateField($field, value) {
  const fieldId = $field.attr("id");
  const $errorMessage = $field.siblings(".error-message");
  let isValid = true;

  // 값이 없는경우
  if (value.trim() === "") {
    $errorMessage.text(
        fieldId === "username" ? "이메일을 입력해주세요." : "비밀번호를 입력해주세요."
      )
      .show();
    isValid = false;
  } // 이메일 형식이 유효하지 않은 경우
  else if (fieldId === "username" && !validateEmail(value)) {
    $errorMessage.text("이메일 형식이 올바르지 않습니다.").show();
    isValid = false;
  } // 비밀번호 형식이 유효하지 않은 경우
  else if (fieldId === "password" && !validatePassword(value)) {
    $errorMessage
      .html(
        "8자 이상으로 입력해주세요<br>영문, 숫자, 특수문자를 조합하여 입력해주세요."
      )
      .show();
    isValid = false;
  } // 유효성 검사 통과
  else {
    $errorMessage.hide();
  }

  return isValid;
}

// 폼 제출을 처리 함수
function handleSubmit(e) {
  e.preventDefault(); // 기본 폼 제출 방지

  const $form = $(this);
  const email = $("#username").val().trim();
  const password = $("#password").val().trim();

  // 이메일과 비밀번호 필드의 유효성 검사
  const isEmailValid = validateField($("#username"), email);
  const isPasswordValid = validateField($("#password"), password);

  // 유효하면 로그인 시도
  if (isEmailValid && isPasswordValid) {
    console.log("로그인 시도:", email);
    // 실패 시에도 아이디가 유지되도록 저장 (리다이렉트 대비)
    try {
      sessionStorage.setItem("login_last_username", email);
    } catch (e) {
      // storage가 막힌 환경은 무시
    }
    // 실제 서버로 폼 제출
    $form[0].submit();
  }
}

// 함수를 일정 시간 내에 한 번만 실행되도록 지연시키는 디바운스 함수
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

// 필드 유효성 검사를 디바운스하여 불필요한 호출을 줄임 (예: 입력 중 실시간 검사)
const debouncedValidate = debounce(function ($field) {
  validateField($field, $field.val());
}, 500);

// DOM이 완전히 로드된 후 실행되는 함수
$(document).ready(function () {
  // 모든 에러 메시지를 초기에는 숨김
  $(".error-message").hide();

  // 서버에서 값이 오지 않는 경우(리다이렉트 등) sessionStorage에서 아이디 복원
  try {
    const saved = sessionStorage.getItem("login_last_username");
    const $username = $("#username");
    if ($username.val().trim() === "" && saved) {
      $username.val(saved);
    }
  } catch (e) {
    // storage가 막힌 환경은 무시
  }

  // 사용자 이름(이메일)과 비밀번호 필드 이벤트 리스너 등록
  $("#username, #password").on({
    // 필드에서 포커스를 잃었을 때 (blur 이벤트)
    blur: function () {
      validateField($(this), $(this).val());
    },
    // 필드에 입력이 발생했을 때 (input 이벤트)
    input: function () {
      const $field = $(this);
      // 입력 시 에러 메시지를 숨기고 디바운스된 유효성 검사 실행
      $field.siblings(".error-message").hide();
      debouncedValidate($field);
    },
  });

  // 로그인 폼 제출 이벤트 리스너 등록
  $(".login-form").on("submit", handleSubmit);

  // 카카오 로그인 버튼 클릭 이벤트 리스너 등록
  // $(".btn-kakao").on("click", function () {
  //   // 카카오 로그인 추가 시 구현
  // });

  // 로그인 실패 모달 닫기 처리
  const $modal = $("#commonModal");
  $("#modalCloseBtn").on("click", function () {
    $modal.hide();
  });
  // 오버레이 배경 클릭 시 닫기
  $modal.on("click", function (e) {
    if (e.target === this) {
      $modal.hide();
    }
  });
});
