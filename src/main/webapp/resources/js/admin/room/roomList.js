$(document).ready(function () {
  initializeRoomList();
});

// roomList 초기화 함수
function initializeRoomList() {}

function bindEventListeners() {
  $("#search-btn").on("click", handleSearch);
  $("#room-search").on("keypress", function (e) {
    if (e.which === 13) {
      handleSearch();
    }
  });
}

// 검색 기능 처리 (유효성 검사)
function handleSearch() {
  const searchTerm = $("#room-search").val().trim();

  // 검색어 유효성 검사
  if (searchTerm.length > 0 && searchTerm.length < 2) {
    alert("검색어는 2글자 이상 입력해주세요.");
    $("#room-search").focus();
    return false;
  }

  return true;
}
