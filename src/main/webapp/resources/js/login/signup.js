$(document).ready(function () {
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

  // 전화번호 자동 하이픈 추가
  function formatPhoneNumber(phone) {
    phone = phone.replace(/[^0-9]/g, "");
    if (phone.length < 4) return phone;
    if (phone.length < 8) return phone.slice(0, 3) + "-" + phone.slice(3);
    return (
      phone.slice(0, 3) + "-" + phone.slice(3, 7) + "-" + phone.slice(7, 11)
    );
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
      if (!value) {
        errorMessage = "전화번호를 입력해주세요.";
        isValid = false;
      } else if (!validatePhone(value.replace(/[^0-9]/g, ""))) {
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

  // 회원 정보 폼 유효성 검사
  function validateInfoForm() {
    // 모든 필드 값 가져오기
    const email = $("#email").val().trim();
    const password = $("#password").val().trim();
    const name = $("#name").val().trim();
    const phone = $("#phone").val().trim();

    // 모든 필드 유효성 검사
    const isEmailValid = validateField($("#email"), email);
    const isPasswordValid = validateField($("#password"), password);
    const isNameValid = validateField($("#name"), name);
    const isPhoneValid = validateField($("#phone"), phone); // 전화번호는 필수항목

    // 모든 유효성 검사 통과 시
    return isEmailValid && isPasswordValid && isNameValid && isPhoneValid;
  }

  // 약관 동의 폼 유효성 검사
  function validateTermsForm() {
    const requiredChecked =
      $('.checkbox-group.required input[type="checkbox"]:checked').length ===
      $(".checkbox-group.required").length;

    if (!requiredChecked) {
      alert("필수 약관에 모두 동의해주세요.");
      return false;
    }

    return true;
  }

  // 디바운스 함수
  function debounce(func, delay) {
    let timeout;
    return function () {
      const context = this;
      const args = arguments;
      clearTimeout(timeout);
      timeout = setTimeout(() => func.apply(context, args), delay);
    };
  }

  // 디바운싱이 적용된 검증 함수
  const debouncedValidate = debounce(function ($field) {
    validateField($field, $field.val());
  }, 500);

  // 입력 필드 이벤트 리스너
  $("#combined-form input[type='text'], #combined-form input[type='email'], #combined-form input[type='password'], #combined-form input[type='tel']").each(function () {
    // 포커스 아웃 시 검증
    $(this).on("blur", function () {
      validateField($(this), $(this).val());
    });

    // 입력 중 디바운싱 적용된 검증
    $(this).on("input", function () {
      debouncedValidate($(this));

      // 전화번호 자동 포맷팅
      if ($(this).attr("id") === "phone") {
        const formatted = formatPhoneNumber($(this).val());
        $(this).val(formatted);
      }
    });
  });

  // 스크롤 이동 함수
  function scrollToSection(sectionId) {
    const section = $(sectionId);
    if (section.length) {
      $("html, body").animate({ scrollTop: section.offset().top - 20 }, "slow");
    }
  }

  // 토글 박스 클릭 이벤트
  $(".toggle-box").on("click", function (e) {
    // 체크박스 클릭은 기본 동작 유지
    if ($(e.target).is('input[type="checkbox"]')) {
      return;
    }

    // 현재 클릭한 토글 박스의 상태를 토글
    $(this).toggleClass("active");

    // 다른 열려있는 토글 박스 닫기
    $(".toggle-box").not(this).removeClass("active");
  });

  // 전체 동의 체크박스
  $("#agreeAll").on("change", function () {
    const isChecked = $(this).is(":checked");
    $('.checkbox-group input[type="checkbox"]').prop("checked", isChecked);
  });

  // 개별 체크박스 변경 시 전체 동의 체크박스 상태 업데이트
  $('.checkbox-group:not(:first) input[type="checkbox"]').on(
    "change",
    function () {
      const allChecked =
        $('.checkbox-group:not(:first) input[type="checkbox"]:checked')
          .length ===
        $('.checkbox-group:not(:first) input[type="checkbox"]').length;
      $("#agreeAll").prop("checked", allChecked);
    }
  );

  // 회원가입 폼 제출
  $("#signup-submit-btn").on("click", async function (e) {
    e.preventDefault();

    // 회원 정보 검증
    if (!validateInfoForm()) {
      scrollToSection(".form-group:has(.error-message:visible):first");
      return;
    }

    // 약관 동의 검증
    if (!validateTermsForm()) {
      scrollToSection(".checkbox-group.required:first");
      return;
    }

    // 회원 정보 폼에서 데이터 수집
    const userData = {
      email: $("#email").val().trim(),
      password: $("#password").val().trim(),
      name: $("#name").val().trim(),
      phone: $("#phone").val().trim(),
      isad: $("#terms4").is(":checked") ? "1" : "0",
    };

    console.log("회원가입 데이터:", userData);
    
    try {	// 이메일 전화번호 중복검사
      const emailRes = await fetch("/api/check/email?email=" + userData.email);
      const emailText = await emailRes.text();
      if (emailText === "true") {
        console.log(emailText);
        alert("이미 사용중인 이메일입니다.");
        return;
      }
      
      const phoneRes = await fetch("/api/check/phone?phone=" + userData.phone);
      const phoneText = await phoneRes.text();
      if (phoneText === "true") {
        alert("이미 사용중인 전화번호입니다.");
        return;
      }
    } catch (error) {
      console.error(error);
      alert("서버와 통신 중 오류가 발생했습니다.");
    }
    
    // 폼 제출
    $("#combined-form").submit();
    // 로그인 성공 페이지로 이동
    // window.location.href = "signupSuccess.html";
  });
});
