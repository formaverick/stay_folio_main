// 공통 모달 헬퍼
function openModal() {
  const modal = document.getElementById("commonModal");
  if (modal) modal.style.display = "flex";
}

function closeModal() {
  const modal = document.getElementById("commonModal");
  if (modal) modal.style.display = "none";
}

function showModal(message) {
  const msgEl = document.querySelector(".modal-message");
  if (msgEl) msgEl.textContent = message;
  openModal();
}

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
        showModal("이름을 입력해주세요.");
        nameInput.focus();
        return;
      }

      //(2) 이메일 입력 및 형식 확인
      const emailInput = document.getElementById("srEmail");
      const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
      if (!emailInput.value.trim()) {
        showModal("이메일을 입력해주세요.");
        emailInput.focus();
        return;
      } else if (!emailRegex.test(emailInput.value)) {
        showModal("이메일 형식이 올바르지 않습니다.");
        emailInput.focus();
        return;
      }

      //(3) 전화번호 입력 및 형식 확인
      const phoneInput = document.getElementById("srPhone");
      const phoneRegex = /^010-\d{4}-\d{4}$/;
      if (!phoneInput.value.trim()) {
        showModal("전화번호를 입력해주세요.");
        phoneInput.focus();
        return;
      } else if (!phoneRegex.test(phoneInput.value)) {
        showModal("전화번호 형식이 올바르지 않습니다. 예: 010-1234-5678");
        phoneInput.focus();
        return;
      }
    }

    //(4) 필수 약관 동의 확인
    const requiredCheckboxes = document.querySelectorAll(
      ".sub-checkbox[data-required='true']"
    );
    const allRequiredAgreed = Array.from(requiredCheckboxes).every(
      (cb) => cb.checked
    );
    if (!allRequiredAgreed) {
      showModal("필수 약관에 모두 동의해야 결제를 진행할 수 있습니다.");
      return; //약관 안 했으면 중단
    }

    //(5) 총 결제 금액이 유효한지 확인
    const totalPriceInput = document.querySelector(
      "input[name='srTotalprice']"
    );
    const price = parseInt(totalPriceInput?.value || "0");
    if (isNaN(price) || price <= 0) {
      showModal("결제 금액이 유효하지 않습니다.");
      return;
    }
    //(6) 예약 날짜 겹침 체크 (DB 조회)
    const siId = document.querySelector("input[name='siId']").value;
    const riId = document.querySelector("input[name='riId']").value;
    const checkin = document
      .querySelector("input[name='srCheckin']")
      .value.slice(0, 10);
    const checkout = document
      .querySelector("input[name='srCheckout']")
      .value.slice(0, 10);

    fetch(
      `/reservation/check-available?siId=${siId}&riId=${riId}&checkin=${checkin}&checkout=${checkout}`
    )
      .then((res) => res.json())
      .then((data) => {
        if (!data.available) {
          showModal("이미 예약된 날짜입니다. 다른 날짜를 선택해주세요.");
          return;
        }
        // 가능하면 결제 진행
        requestPay();
      })
      .catch((err) => {
        console.error(err);
        showModal("예약 가능 여부 확인 중 오류가 발생했습니다.");
      });
  });

  // 모달 닫기 이벤트
  const closeBtn = document.querySelector("#commonModal .btn-cancel");
  if (closeBtn) {
    closeBtn.addEventListener("click", closeModal);
  }
  const overlay = document.getElementById("commonModal");
  if (overlay) {
    overlay.addEventListener("click", function (e) {
      if (e.target === overlay) closeModal();
    });
  }
});
