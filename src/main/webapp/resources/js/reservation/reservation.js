document.addEventListener("DOMContentLoaded", function () {
  //1. 약관 전체 동의 체크 처리
  const agreeAllCheckbox = document.getElementById("agree-all");
  const subCheckboxes = document.querySelectorAll(".sub-checkbox");

  agreeAllCheckbox.addEventListener("change", function () {
    const isChecked = this.checked;
    subCheckboxes.forEach((checkbox) => {
      checkbox.checked = isChecked;
    });
  });

  subCheckboxes.forEach((checkbox) => {
    checkbox.addEventListener("change", function () {
      const allChecked = Array.from(subCheckboxes).every((cb) => cb.checked);
      agreeAllCheckbox.checked = allChecked;
    });
  });

  //2. 결제 버튼 클릭 시 유효성 검사
  const paymentButton = document.querySelector(".payment-button");

  paymentButton.addEventListener("click", function () {
    const isLogin = document.getElementById("isLogin")?.value === "true";

    //(1) 이름 입력 확인
    if (!isLogin) {
      const nameInput = document.getElementById("srName");
      if (!nameInput.value.trim()) {
        alert("이름을 입력해주세요.");
        nameInput.focus();
        return;
      }

      //(2) 이메일 입력 및 형식 확인
      const emailInput = document.getElementById("srEmail");
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailInput.value.trim()) {
        alert("이메일을 입력해주세요.");
        emailInput.focus();
        return;
      } else if (!emailRegex.test(emailInput.value)) {
        alert("이메일 형식이 올바르지 않습니다.");
        emailInput.focus();
        return;
      }

      //(3) 전화번호 입력 및 형식 확인
      const phoneInput = document.getElementById("srPhone");
      const phoneRegex = /^010-\d{4}-\d{4}$/;
      if (!phoneInput.value.trim()) {
        alert("전화번호를 입력해주세요.");
        phoneInput.focus();
        return;
      } else if (!phoneRegex.test(phoneInput.value)) {
        alert("전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678");
        phoneInput.focus();
        return;
      }
    }

    //(4) 필수 약관 동의 확인
    const requiredCheckboxes = document.querySelectorAll(".sub-checkbox[data-required='true']");
    const allRequiredAgreed = Array.from(requiredCheckboxes).every((cb) => cb.checked);
    if (!allRequiredAgreed) {
      alert("필수 약관에 모두 동의해야 결제를 진행할 수 있습니다.");
      return; //약관 안 했으면 중단
    }

    //(5) 총 결제 금액이 유효한지 확인
    const totalPriceInput = document.querySelector("input[name='srTotalprice']");
    const price = parseInt(totalPriceInput?.value || "0");
    if (isNaN(price) || price <= 0) {
      alert("결제 금액이 유효하지 않습니다.");
      return;
    }
    
    

    //결제 API 실행
    requestPay();
  });
});