document.addEventListener("DOMContentLoaded", function () {
  const paymentOptions = document.querySelectorAll(".payment-option");
  const srPaymentInput = document.getElementById("srPayment"); // 결제 방법
  const srStatusInput = document.getElementById("srStatus"); // 예약 상태
  const srPaymentstatusInput = document.getElementById("srPaymentstatus"); // 결제 상태

  
  const activePayment = document.querySelector(".payment-option.active");
  if (activePayment) {
    const selectedPayment = activePayment.getAttribute("data-payment");
    srPaymentInput.value = selectedPayment;

    if (selectedPayment === "무통장입금") {
      srStatusInput.value = "d";         // 입금대기
      srPaymentstatusInput.value = "a";  // 결제대기
    } else {
      srStatusInput.value = "a";         // 예약완료
      srPaymentstatusInput.value = "b";  // 결제완료
    }
  }

  //결제 수단 클릭 시 변경 처리
  paymentOptions.forEach((option) => {
    option.addEventListener("click", function () {
      paymentOptions.forEach((opt) => opt.classList.remove("active"));
      this.classList.add("active");

      const selectedPayment = this.getAttribute("data-payment");
      console.log("Selected payment method:", selectedPayment);

      srPaymentInput.value = selectedPayment;
      if (selectedPayment === "무통장입금") {
        srStatusInput.value = "d";         // 입금대기
        srPaymentstatusInput.value = "a";  // 결제대기
      } else {
        srStatusInput.value = "a";         // 예약완료
        srPaymentstatusInput.value = "b";  // 결제완료
      }
    });
  });

  //약관 동의 전체 체크
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

  //필수 약관 체크 확인
  const paymentButton = document.querySelector(".payment-button");
  paymentButton.addEventListener("click", function (event) {
    const requiredCheckboxes = document.querySelectorAll(
      ".sub-checkbox[data-required='true']"
    );
    const allRequiredAgreed = Array.from(requiredCheckboxes).every(
      (cb) => cb.checked
    );

    if (!allRequiredAgreed) {
      event.preventDefault();
      alert("필수 약관에 모두 동의해야 결제를 진행할 수 있습니다.");
    }
  });
});
