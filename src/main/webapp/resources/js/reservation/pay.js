document.addEventListener("DOMContentLoaded", () => {
  window.requestPay = function () {
    const IMP = window.IMP;
    IMP.init("imp50774123"); // 본인의 imp 키

    const amount = document.querySelector(".payment-price").dataset.amount;
    const srName = document.querySelector("input[name='srName']")?.value || "비회원";
    const srEmail = document.querySelector("input[name='srEmail']")?.value || "noemail@example.com";
    const srPhone = document.querySelector("input[name='srPhone']")?.value || "000-0000-0000";
    
    IMP.request_pay({
      pg: "html5_inicis.INIpayTest", // 테스트용 PG
      pay_method: "card",
      merchant_uid: "order_" + new Date().getTime(),
      name: "stayfolio 결제",
      amount: 100,	//test로 100으로 넣고 사용 원래는 amount
      buyer_email: srEmail,
      buyer_name:  srName,
      buyer_tel:   srPhone
      
    }, function (rsp) {
      if (rsp.success) {
       
     // 보기 좋은 결제 수단명 반환 (테스트 코드여서 카드결제/포인트결제만 가져오기가능)
     const getPaymentLabel = (rsp) => {
 	 const easy_pay = rsp.easy_pay;
 	 const pg = rsp.pg_provider ? rsp.pg_provider.toLowerCase() : "";
  	 const method = rsp.pay_method ? rsp.pay_method.toLowerCase() : "";
  	 const easy = (easy_pay && easy_pay.easy_pay_provider)
    	? easy_pay.easy_pay_provider.toLowerCase()
    	: "";

	  // 간편결제 우선
  	 if (easy === "kakaopay") return method === "point" ? "카카오페이 (포인트)" : "카카오페이";
 	 if (easy === "tosspay") return method === "point" ? "토스페이 (포인트)" : "토스페이";
  	 if (easy === "naverpay") return method === "point" ? "네이버페이 (포인트)" : "네이버페이";

	 // easy_pay 없음 → pg_provider로 추정
  	 if (pg.indexOf("naverpay") !== -1 && method === "point") return "네이버페이 (포인트)";
  	 if (pg.indexOf("kakaopay") !== -1 && method === "point") return "카카오페이 (포인트)";
   	 if (pg.indexOf("tosspay") !== -1 && method === "point") return "토스페이 (포인트)";

	 switch (method) {
     case "card": return "신용카드";
     case "vbank": return "무통장입금";
     case "trans": return "실시간 계좌이체";
     case "phone": return "휴대폰결제";
     case "point": return "포인트결제";
     default: return "기타 결제";
  		}
	}
    	
		console.log("rsp 전체 응답:", JSON.stringify(rsp, null, 2));
        const paymentLabel = getPaymentLabel(rsp);

        const form = document.createElement("form");
        form.method = "POST";
        form.action = "/reservation/submit";

        const addInput = (name, value) => {
          const input = document.createElement("input");
          input.type = "hidden";
          input.name = name;
          input.value = value;
          form.appendChild(input);
        };

        addInput("impUid", rsp.imp_uid);
        addInput("amount", rsp.paid_amount);
        addInput("merchantUid", rsp.merchant_uid);
        addInput("srPayment", paymentLabel);
        addInput("srStatus", "a");
        addInput("srPaymentstatus", "b");
		
        console.log("결제 PG:", rsp.pg_provider);
        console.log("결제 수단:", rsp.pay_method);
        console.log("결제 이름:", rsp.name);
        console.log("결제 PG TID:", rsp.pg_tid);
        console.log("최종 표시용 결제명:", paymentLabel);
		
        addInput("siId", document.querySelector("input[name='siId']").value);
        addInput("riId", document.querySelector("input[name='riId']").value);
        addInput("miId", document.querySelector("input[name='miId']").value);
        addInput("srAdult", document.querySelector("input[name='srAdult']").value);
        addInput("srChild", document.querySelector("input[name='srChild']").value);
        addInput("srCheckin", document.querySelector("input[name='srCheckin']").value);
        addInput("srCheckout", document.querySelector("input[name='srCheckout']").value);
        addInput("srRequest", document.querySelector('textarea[name="srRequest"]')?.value || "");
        addInput("srRoomprice", document.querySelector("input[name='srRoomprice']").value);
        addInput("srDiscount", document.querySelector("input[name='srDiscount']").value);
        addInput("srAddpersonFee", document.querySelector("input[name='srAddpersonFee']").value);
        addInput("srTotalprice", document.querySelector("input[name='srTotalprice']").value);
        addInput("srName", document.querySelector("input[name='srName']").value);
        addInput("srEmail", document.querySelector("input[name='srEmail']").value);
        addInput("srPhone", document.querySelector("input[name='srPhone']").value);

        document.body.appendChild(form);
        form.submit();
      } else {
        alert("결제 실패: " + rsp.error_msg);
      }
    });
  };
});
