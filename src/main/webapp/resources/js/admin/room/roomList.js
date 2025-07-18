// 관리자 roomList 페이지 JavaScript

// 페이지 로드 시 초기화
$(document).ready(function () {
  initializeRoomList();
});

// roomList 초기화 함수
function initializeRoomList() {
  console.log("관리자 숙소 목록 페이지 초기화");

  // 이벤트 리스너 등록
  bindEventListeners();

  console.log("초기화 완료");
}

// 이벤트 리스너 등록
function bindEventListeners() {
  // 검색 기능 유효성 검사
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

  if (searchTerm.length > 50) {
    alert("검색어는 50글자 이하로 입력해주세요.");
    $("#room-search").focus();
    return false;
  }

  console.log("검색 실행:", searchTerm);
  // 실제 검색 로직은 백엔드에서 처리
  return true;
}
