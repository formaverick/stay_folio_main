$(document).ready(function() {
  // 토글 박스 클릭 이벤트
  $('.toggle-box').on('click', function(e) {
    // 체크박스 클릭은 기본 동작 유지
    if ($(e.target).is('input[type="checkbox"]')) {
      return;
    }
    
    // 현재 클릭한 토글 박스의 상태를 토글
    $(this).toggleClass('active');
    
    // 다른 열려있는 토글 박스 닫기
    $('.toggle-box').not(this).removeClass('active');
  });

  // 전체 동의 체크박스
  $('#agreeAll').on('change', function() {
    const isChecked = $(this).is(':checked');
    $('.checkbox-group input[type="checkbox"]').prop('checked', isChecked);
  });

  // 개별 체크박스 변경 시 전체 동의 체크박스 상태 업데이트
  $('.checkbox-group:not(:first) input[type="checkbox"]').on('change', function() {
    const allChecked = $('.checkbox-group:not(:first) input[type="checkbox"]:checked').length === 
                      $('.checkbox-group:not(:first) input[type="checkbox"]').length;
    $('#agreeAll').prop('checked', allChecked);
  });

  // 다음 버튼 클릭 시 필수 항목 체크
  $('.btn-next').on('click', function(e) {
    e.preventDefault();
    const requiredChecked = $('.checkbox-group.required input[type="checkbox"]:checked').length === 
                          $('.checkbox-group.required').length;
    
    if (!requiredChecked) {
      alert('필수 약관에 모두 동의해주세요.');
      return;
    }
    
    // 여기에 다음 단계로 넘어가는 로직 추가
    console.log('모든 필수 약관에 동의하셨습니다.');
    // window.location.href = '다음_페이지.html';
  });
});