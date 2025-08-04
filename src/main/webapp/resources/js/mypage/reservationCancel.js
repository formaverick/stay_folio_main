$(document).ready(function() {
    $(".cancel-submit").on("click", function (e) {
        e.preventDefault();

        const reason = $("input[name='reason']:checked").val();
        const detailReason = $(".cancel-textarea").val().trim();
        const agreed = $("input[name='agreement']").is(":checked");

        if (!reason) {
            alert("취소 사유를 선택해주세요.");
            return;
        }

        if (reason === 'd' && !detailReason) {
            alert("취소 사유를 입력해주세요.");
            $(".cancel-textarea").focus();
            return;
        }

        if (!agreed) {
            alert("환불 규정에 동의해주세요.");
            return;
        }

        if (confirm("정말 예약을 취소하시겠습니까?")) {
            $("#cancelForm").submit();
        }
    });

    $(".cancel-back").on("click", function () {
        history.back();
    });
});
