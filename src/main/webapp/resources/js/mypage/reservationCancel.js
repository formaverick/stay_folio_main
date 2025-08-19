$(document).ready(function() {
    $(".cancel-submit").on("click", function (e) {
        e.preventDefault();

        const reason = $("input[name='reason']:checked").val();
        const detailReason = $(".cancel-textarea").val().trim();
        const agreed = $("input[name='agreement']").is(":checked");

        if (!reason) {
        	$(".modal-message").text("취소 사유를 선택해주세요.");
        	openModal();
            return;
        }

        if (reason === 'd' && !detailReason) {
        	$(".modal-message").text("취소 사유를 입력해주세요.");
        	openModal();
            $(".cancel-textarea").focus();
            return;
        }

        if (!agreed) {
        	$(".modal-message").text("환불 규정에 동의해주세요.");
        	openModal();
            return;
        }

        if (confirm("정말 예약을 취소하시겠습니까?")) {
            $("#cancelForm").submit();
        }
    });

    $(".cancel-back").on("click", function () {
        history.back();
    });
    
	function openModal() {
		document.getElementById("commonModal").style.display = "flex";
	}
	
	$(".btn-cancel").on("click", function() {
		document.getElementById("commonModal").style.display = "none";
	});
});
