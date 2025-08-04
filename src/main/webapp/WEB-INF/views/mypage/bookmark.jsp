document.addEventListener("DOMContentLoaded", () => { window.requestPay =
function () { const IMP = window.IMP; IMP.init("imp50774123"); // 본인의 imp 키
const amount = document.querySelector(".payment-price").dataset.amount;
IMP.request_pay({ pg: "html5_inicis.INIpayTest", // 테스트용 PG사 pay_method:
"card", merchant_uid: "order_" + new Date().getTime(), name: "숙소 결제",
amount: 100, buyer_email: "test@example.com", buyer_name: "윤단비", buyer_tel:
"01012345678" }, function (rsp) { if (rsp.success) { console.log("🔥 rsp 전체
응답:", rsp); // 결제 수단 보기 좋게 변환 const getPaymentLabel = (rsp) => {
const { pg_provider, pay_method } = rsp; // ✅ 포인트라도 카카오페이 UI였을
가능성 if (pay_method === "point") return "카카오페이 (포인트)"; if (pg_provider
=== "kakaopay") return "카카오페이"; if (pg_provider === "tosspay") return
"토스페이"; if (pg_provider?.includes("inicis")) return "신용카드"; switch
(pay_method) { case "card": return "신용카드"; case "vbank": return
"무통장입금"; case "trans": return "실시간 계좌이체"; case "phone": return
"휴대폰결제"; default: return "기타 결제"; } }; // ✅ 이 줄이 빠졌었음! 꼭
넣어줘야 한다! const paymentLabel = getPaymentLabel(rsp); const form =
document.createElement("form"); form.method = "POST"; form.action =
"/reservation/submit"; const addInput = (name, value) => { const input =
document.createElement("input"); input.type = "hidden"; input.name = name;
input.value = value; form.appendChild(input); }; addInput("impUid",
rsp.imp_uid); addInput("amount", rsp.paid_amount); addInput("merchantUid",
rsp.merchant_uid); addInput("srPayment", paymentLabel); // ✅ 제대로 들어간다!
addInput("srStatus", "a"); addInput("srPaymentstatus", "b"); console.log("결제
PG:", rsp.pg_provider); console.log("결제 수단:", rsp.pay_method);
console.log("결제 이름:", rsp.name); console.log("결제 PG TID:", rsp.pg_tid);
console.log("➡️ 최종 표시용 결제명:", paymentLabel); addInput("siId",
document.querySelector("input[name='siId']").value); addInput("riId",
document.querySelector("input[name='riId']").value); addInput("miId",
document.querySelector("input[name='miId']").value); addInput("srAdult",
document.querySelector("input[name='srAdult']").value); addInput("srChild",
document.querySelector("input[name='srChild']").value); addInput("srCheckin",
document.querySelector("input[name='srCheckin']").value); addInput("srCheckout",
document.querySelector("input[name='srCheckout']").value);
addInput("srRoomPrice",
document.querySelector("input[name='srRoomPrice']").value);
addInput("srDiscount",
document.querySelector("input[name='srDiscount']").value);
addInput("srAddpersonFee",
document.querySelector("input[name='srAddpersonFee']").value);
addInput("srTotalprice",
document.querySelector("input[name='srTotalprice']").value); addInput("srName",
document.querySelector("input[name='srName']").value); addInput("srEmail",
document.querySelector("input[name='srEmail']").value); addInput("srPhone",
document.querySelector("input[name='srPhone']").value);
document.body.appendChild(form); form.submit(); } else { alert("결제 실패: " +
rsp.error_msg); } }); }; });
