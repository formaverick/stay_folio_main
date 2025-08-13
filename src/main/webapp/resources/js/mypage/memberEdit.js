$(document).ready(function () {
  /** ---------------------------
   *  공통: 유효성/포맷 함수
   * -------------------------- */
  function validateName(name) {
    const re = /^[가-힣a-zA-Z]{2,}$/;
    return re.test(name);
  }
  function validatePhone(phone) {
    const re = /^\d{10,11}$/;
    return re.test(phone);
  }
  function formatPhoneNumber(phone) {
    phone = phone.replace(/[^0-9]/g, "");
    if (phone.length < 4) return phone;
    if (phone.length < 8) return phone.slice(0, 3) + "-" + phone.slice(3);
    return phone.slice(0, 3) + "-" + phone.slice(3, 7) + "-" + phone.slice(7, 11);
  }
  function debounce(func, delay) {
    let t;
    return function () {
      const ctx = this, args = arguments;
      clearTimeout(t);
      t = setTimeout(() => func.apply(ctx, args), delay);
    };
  }

  /** ---------------------------
   *  필드 단건 검사
   * -------------------------- */
  function validateField($field, value) {
    const id = $field.attr("id");
    const $err = $field.siblings(".error-message");
    let ok = true, msg = "";

    if (id === "name") {
      if (!value) { msg = "이름을 입력해주세요."; ok = false; }
      else if (!validateName(value)) { msg = "이름은 2자 이상의 한글/영문."; ok = false; }
    } else if (id === "phone") {
      if (!value) { msg = "전화번호를 입력해주세요."; ok = false; }
      else if (!validatePhone(value.replace(/[^0-9]/g, ""))) {
        msg = "숫자 10~11자리(하이픈 가능)."; ok = false;
      }
    } else if (id === "birth") {
      // 선택값: 비워도 허용. 값이 있으면 YYYY-MM-DD 형태만 간단 체크
      if (value && !/^\d{4}-\d{2}-\d{2}$/.test(value)) {
        msg = "생년월일 형식을 확인해주세요(YYYY-MM-DD)."; ok = false;
      }
    }

    if (!ok) $err.text(msg).show(); else $err.hide();
    return ok;
  }

  const debouncedValidate = debounce(function ($f) {
    validateField($f, $f.val());
  }, 400);

  // 전화번호 중복 검사 (중복이면 true 반환)
async function checkPhoneDuplicate(phone) {
  try {
    const res = await fetch(`/api/edit/phone?phone=${encodeURIComponent(phone)}`);
    const text = await res.text();
    return text === "true";
  } catch (e) {
    console.error("phone duplicate check error:", e);
    if (typeof openModal === "function") openModal("서버 통신 중 오류가 발생했습니다.");
    return true; // 에러 시 진행 중단
  }
}

  /** ---------------------------
   *  모달 (회원가입과 동일 UI 재사용)
   * -------------------------- */
  function openModal(text) {
    if (text) $(".modal-message").text(text);
    $("#commonModal").css("display", "flex");
  }
  function closeModal() {
    $("#commonModal").hide();
  }
  $("#commonModal .btn-cancel").on("click", closeModal);

  /** ---------------------------
   *  입력 이벤트 바인딩
   * -------------------------- */
  $("#name, #phone, #birth").each(function () {
    const $this = $(this);

    $this.on("blur", function () {
      validateField($this, $this.val());
    });

    $this.on("input", function () {
      if ($this.attr("id") === "phone") {
        $this.val(formatPhoneNumber($this.val()));
      }
      debouncedValidate($this);
    });
  });

  /** ---------------------------
   *  제출 처리
   *  - 이메일/비밀번호/약관은 편집 화면에서 제외
   *  - 전화번호가 바뀐 경우에만 중복검사
   * -------------------------- */
  let submitting = false;
  $("#member-edit-form").on("submit", async function (e) {
    if (submitting) return;
    e.preventDefault();

    const $name = $("#name");
    const $phone = $("#phone");
    const $birth = $("#birth");

    const name = $name.val().trim();
    const phone = $phone.val().trim();
    const birth = $birth.length ? $birth.val().trim() : "";

    const okName = validateField($name, name);
    const okPhone = validateField($phone, phone);
    const okBirth = $birth.length ? validateField($birth, birth) : true;

    if (!(okName && okPhone && okBirth)) {
      // 첫 오류로 스크롤
      const $firstErr = $(".form-group:has(.error-message:visible):first");
      if ($firstErr.length) $("html, body").animate({ scrollTop: $firstErr.offset().top - 20 }, "slow");
      return;
    }

    // 전화번호가 변경된 경우에만 중복 검사
    const original = ($phone.data("original") || "").toString().replace(/[^0-9]/g, "");
    const current = phone.replace(/[^0-9]/g, "");
    if (original !== current) {
      const dup = await checkPhoneDuplicate(phone);
      if (dup) {
        openModal("이미 사용중인 전화번호입니다.");
        return;
      }
    }

    submitting = true;
    this.submit();
  });
});
