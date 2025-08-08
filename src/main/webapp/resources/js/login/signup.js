$(document).ready(function () {
  /**
   * 이메일 유효성 검사 함수
   */
  function validateEmail(email) {
    const re = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,6}$/;
    return re.test(email);
  }

  /**
   * 비밀번호 유효성 검사 함수수
   */
  function validatePassword(password) {
    const re = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$/;
    return re.test(password);
  }

  /**
   * 이름 유효성 검사 함수
   */
  function validateName(name) {
    const re = /^[가-힣a-zA-Z]{2,}$/;
    return re.test(name);
  }

  /**
   * 전화번호 유효성 검사 함수
   */
  function validatePhone(phone) {
    const re = /^\d{10,11}$/;
    return re.test(phone);
  }

  /**
   * 전화번호 내 하이픈 추가 함수
   */
  function formatPhoneNumber(phone) {
    phone = phone.replace(/[^0-9]/g, ""); // 숫자 이외의 문자 제거
    if (phone.length < 4) return phone;
    if (phone.length < 8) return phone.slice(0, 3) + "-" + phone.slice(3);
    return (
      phone.slice(0, 3) + "-" + phone.slice(3, 7) + "-" + phone.slice(7, 11)
    );
  }

  /**
   * 입력 필드 유효성 검사 함수
   */
  function validateField($field, value) {
    const fieldId = $field.attr("id");
    const $errorMessage = $field.siblings(".error-message");
    let isValid = true;
    let errorMessage = "";

    // 필드 ID에 따른 유효성 검사
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

    // 유효성 검사 결과에 따라 에러 메시지 표시 또는 숨김
    if (!isValid) {
      $errorMessage.text(errorMessage).show();
    } else {
      $errorMessage.hide();
    }

    return isValid;
  }

  /**
   * 회원 정보 입력 폼의 모든 필드 유효성 검사 함수
   */
  function validateInfoForm() {
    // 각 필드의 현재 값 가져오기
    const email = $("#email").val().trim();
    const password = $("#password").val().trim();
    const name = $("#name").val().trim();
    const phone = $("#phone").val().trim();

    // 모든 필드에 대해 validateField 함수 호출하여 유효성 검사 수행
    const isEmailValid = validateField($("#email"), email);
    const isPasswordValid = validateField($("#password"), password);
    const isNameValid = validateField($("#name"), name);
    const isPhoneValid = validateField($("#phone"), phone); // 전화번호는 필수 항목

    // 모든 필드가 유효한 경우에만 true 반환
    return isEmailValid && isPasswordValid && isNameValid && isPhoneValid;
  }

  /**
   * 약관 동의 유효성 검사 함수
   */
  function validateTermsForm() {
    // 필수 약관 체크박스 모두 체크되었는지 확인
    const requiredChecked =
      $('.checkbox-group.required input[type="checkbox"]:checked').length ===
      $(".checkbox-group.required").length;

    if (!requiredChecked) {
      alert("필수 약관에 모두 동의해주세요.");
      return false;
    }

    return true;
  }

  /**
   * 함수를 일정 시간 내에 한 번만 실행되도록 지연시키는 디바운스 함수
   */
  function debounce(func, delay) {
    let timeout;
    return function () {
      const context = this;
      const args = arguments;
      clearTimeout(timeout);
      timeout = setTimeout(() => func.apply(context, args), delay);
    };
  }

  /**
   * 입력 필드 유효성 검사에 디바운싱 적용
   */
  const debouncedValidate = debounce(function ($field) {
    validateField($field, $field.val());
  }, 500);
  
  /* 모달 창 열고 닫기 */
  function openModal() {
    document.getElementById("commonModal").style.display = "flex";
  }

  function closeModal() {
    document.getElementById("commonModal").style.display = "none";
  }

  /**
   * 이메일 및 전화번호 중복 검사 함수
   */
  async function checkDuplicate(type, value) {
    try {
      const response = await fetch(`/api/check/${type}?${type}=${value}`);
      const result = await response.text();
      if (result === "true") {
      	$(".modal-message").text(`이미 사용중인 ${type === "email" ? "이메일" : "전화번호"}입니다.`);
        openModal();
        return true; // 중복됨
      }
      return false; // 중복 아님
    } catch (error) {
      console.error(`Error checking duplicate ${type}:`, error);
      alert("서버와 통신 중 오류가 발생했습니다.");
      return true; // 에러 발생 시 중복으로 간주하여 진행 방지
    }
  }

  /**
   * 입력 필드에 대한 이벤트 리스너 설정
   */
  $(
    "#combined-form input[type='text'], #combined-form input[type='email'], #combined-form input[type='password'], #combined-form input[type='tel']"
  ).each(function () {
    const $this = $(this);
    // 포커스를 벗어났을 때 유효성 검사
    $this.on("blur", function () {
      validateField($this, $this.val());
    });

    // 입력 이벤트 실행 시 디바운싱된 유효성 검사 및 전화번호 포맷팅
    $this.on("input", function () {
      debouncedValidate($this);

      // 전화번호 필드인 경우 자동 포맷팅 적용
      if ($this.attr("id") === "phone") {
        const formatted = formatPhoneNumber($this.val());
        $this.val(formatted);
      }
    });
  });

  /**
   * 페이지 내 특정 섹션으로 부드럽게 스크롤 이동
   */
  function scrollToSection(sectionId) {
    const section = $(sectionId);
    if (section.length) {
      $("html, body").animate({ scrollTop: section.offset().top - 20 }, "slow");
    }
  }

  /**
   * 약관 토글 박스 클릭 이벤트
   */
  $(".toggle-box").on("click", function (e) {
    // 체크박스 자체를 클릭한 경우에는 기본 동작을 유지
    if ($(e.target).is('input[type="checkbox"]')) {
      return;
    }

    // 현재 클릭한 토글 박스의 활성화/비활성화 상태를 토글
    $(this).toggleClass("active");

    // 다른 열려있는 토글 박스는 모두 닫기
    $(".toggle-box").not(this).removeClass("active");
  });

  /**
   * '모두 동의' 체크박스 변경 이벤트
   */
  $("#agreeAll").on("change", function () {
    const isChecked = $(this).is(":checked");
    // 모든 약관 체크박스의 상태를 '모두 동의' 체크박스와 동일하게 설정
    $('.checkbox-group input[type="checkbox"]').prop("checked", isChecked);
  });

  /**
   * 개별 약관 체크박스 변경 이벤트
   */
  $('.checkbox-group:not(:first) input[type="checkbox"]').on(
    "change",
    function () {
      // '모두 동의' 체크박스를 제외한 모든 필수 약관이 체크되었는지 확인
      const allChecked =
        $('.checkbox-group:not(:first) input[type="checkbox"]:checked')
          .length ===
        $('.checkbox-group:not(:first) input[type="checkbox"]').length;
      // '모두 동의' 체크박스의 상태를 업데이트
      $("#agreeAll").prop("checked", allChecked);
    }
  );

  /**
   * 회원가입 제출 버튼 클릭 이벤트
   */
  $("#signup-submit-btn").on("click", async function (e) {
    e.preventDefault(); // 폼의 기본 제출 동작 방지

    // 회원 정보 유효성 검사
    if (!validateInfoForm()) {
      // 첫 번째 에러 메시지가 보이는 필드로 스크롤 이동
      scrollToSection(".form-group:has(.error-message:visible):first");
      return;
    }

    // 약관 동의 유효성 검사
    if (!validateTermsForm()) {
      // 필수 약관 섹션으로 스크롤 이동
      scrollToSection(".checkbox-group.required:first");
      return;
    }

    // 회원 정보 데이터 수집
    const userData = {
      email: $("#email").val().trim(),
      password: $("#password").val().trim(),
      name: $("#name").val().trim(),
      phone: $("#phone").val().trim(),
      isad: $("#terms4").is(":checked") ? "1" : "0", // 광고성 정보 수신 동의 여부
    };

    console.log("회원가입 데이터:", userData);

    // 이메일 및 전화번호 중복 검사
    const isEmailDuplicate = await checkDuplicate("email", userData.email);
    if (isEmailDuplicate) return; // 중복이면 함수 종료

    const isPhoneDuplicate = await checkDuplicate("phone", userData.phone);
    if (isPhoneDuplicate) return; // 중복이면 함수 종료

    // 폼 제출
    $("#combined-form").submit();
  });

  // 로그인 버튼 클릭 이벤트
  $(".btn-login").on("click", function () {
    window.location.href = "login.html"; // 로그인 페이지로 이동
  });
  
  // 모달 닫기
  $("#commonModal .btn-cancel").on("click", closeModal);
});
