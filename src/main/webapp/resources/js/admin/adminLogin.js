// 유효성 검사 함수들
function validateAdminId(adminId) {
  return adminId.trim().length >= 4;
}

function validateAdminPassword(password) {
  return password.trim().length >= 6;
}

// 필드 유효성 검사 함수
function validateField($field, value) {
  const fieldId = $field.attr("id");
  const $errorMessage = $field.siblings(".error-message");
  let isValid = true;
  let errorMessage = "";

  if (value.trim() === "") {
    errorMessage =
      fieldId === "admin-id"
        ? "아이디를 입력해주세요."
        : "비밀번호를 입력해주세요.";
    isValid = false;
  } else if (fieldId === "admin-id" && !validateAdminId(value)) {
    errorMessage = "아이디는 4자 이상 입력해주세요.";
    isValid = false;
  } else if (fieldId === "admin-password" && !validateAdminPassword(value)) {
    errorMessage = "비밀번호는 6자 이상 입력해주세요.";
    isValid = false;
  }

  if (!isValid) {
    $errorMessage.text(errorMessage).show();
    $field.closest(".form-group").addClass("error");
  } else {
    $errorMessage.hide();
    $field.closest(".form-group").removeClass("error");
  }

  return isValid;
}

// 관리자 계정 정보 (임시)
const ADMIN_CREDENTIALS = {
  id: "admin",
  password: "qwe123!@#"
};

// 폼 제출 핸들러
function handleAdminSubmit(e) {
  e.preventDefault();

  const adminId = $("#admin-id").val().trim();
  const adminPassword = $("#admin-password").val().trim();
  const isIdValid = validateField($("#admin-id"), adminId);
  const isPasswordValid = validateField($("#admin-password"), adminPassword);

  if (isIdValid && isPasswordValid) {
    // 관리자 계정 확인
    if (adminId === ADMIN_CREDENTIALS.id && adminPassword === ADMIN_CREDENTIALS.password) {
      console.log("관리자 로그인 성공:", { adminId });
      alert("관리자 로그인 성공!");
      
      // 관리자 대시보드로 리다이렉트 (임시로 메인 페이지)
      // 실제 관리자 페이지가 있다면 해당 URL로 변경
      window.location.href = "/admin/dashboard";
      
    } else {
      // 로그인 실패
      showLoginError("아이디 또는 비밀번호가 올바르지 않습니다.");
    }
  }
}

// 로그인 실패 시 에러 메시지 표시
function showLoginError(message) {
  // 기존 에러 메시지 제거
  $(".login-error").remove();
  
  // 새 에러 메시지 추가
  const errorHtml = `<div class="login-error" style="
    color: #e53e3e;
    background-color: #fef2f2;
    border: 1px solid #fecaca;
    border-radius: 8px;
    padding: 0.75rem;
    margin-bottom: 1rem;
    font-size: 0.9rem;
    text-align: center;
  ">${message}</div>`;
  
  $(".admin-login-form").prepend(errorHtml);
  
  // 3초 후 에러 메시지 자동 제거
  setTimeout(() => {
    $(".login-error").fadeOut(300, function() {
      $(this).remove();
    });
  }, 3000);
}

// 디바운스 함수
function debounce(func, delay) {
  let timeoutId;
  return function (...args) {
    clearTimeout(timeoutId);
    timeoutId = setTimeout(() => func.apply(this, args), delay);
  };
}

// 디바운싱이 적용된 검증 함수
const debouncedValidate = debounce(function ($field) {
  validateField($field, $field.val());
}, 500);

// DOM 준비 완료 시 실행
$(document).ready(function () {
  // 입력 필드 이벤트 리스너
  $("#admin-id, #admin-password").each(function () {
    const $field = $(this);

    // 포커스 아웃 시 즉시 검증
    $field.on("blur", function () {
      validateField($field, $field.val());
    });

    // 입력 중 디바운싱 적용된 검증
    $field.on("input", function () {
      // 에러 상태인 경우에만 실시간 검증
      if ($field.closest(".form-group").hasClass("error")) {
        debouncedValidate($field);
      }
    });
  });

  // 폼 제출 이벤트
  $(".admin-login-form").on("submit", handleAdminSubmit);

  // Enter 키로 폼 제출
  $("#admin-id, #admin-password").on("keypress", function (e) {
    if (e.which === 13) {
      // Enter 키
      $(".admin-login-form").submit();
    }
  });
});

// 실제 서버 통신 함수 (추후 구현)
async function submitAdminLogin(credentials) {
  try {
    const response = await fetch("/admin/login", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(credentials),
    });

    if (response.ok) {
      const result = await response.json();
      // 성공 시 관리자 대시보드로 리다이렉트
      window.location.href = "/admin/dashboard";
    } else {
      throw new Error("로그인 실패");
    }
  } catch (error) {
    console.error("관리자 로그인 오류:", error);
    alert("로그인에 실패했습니다. 다시 시도해주세요.");
  }
}
