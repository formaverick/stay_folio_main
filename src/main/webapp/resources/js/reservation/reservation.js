document.addEventListener("DOMContentLoaded", function () {
  const paymentOptions = document.querySelectorAll(".payment-option");

  paymentOptions.forEach((option) => {
    option.addEventListener("click", function () {
      paymentOptions.forEach((opt) => opt.classList.remove("active"));
      this.classList.add("active");
      const selectedPayment = this.getAttribute("data-payment");
      console.log("Selected payment method:", selectedPayment);
    });
  });

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
