package com.hotel.service;

import java.time.LocalDate;
import java.time.ZoneId;
import java.time.temporal.ChronoUnit;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.hotel.domain.MemberVO;
import com.hotel.domain.ReservationDetailVO;
import com.hotel.domain.ReservationListVO;
import com.hotel.domain.StayVO;
import com.hotel.mapper.CommonMapper;
import com.hotel.mapper.MypageMapper;

@Service
public class MypageServiceImpl implements MypageService {

	@Autowired
	private MypageMapper mypageMapper;
	
	@Autowired
	private CommonMapper commonMapper;

	@Autowired(required = false)
	private BCryptPasswordEncoder passwordEncoder;

	@Override
	public int getCompletedStayCount(String id) {
		return mypageMapper.getCompletedStayCount(id);
	}

	@Override
	public List<ReservationListVO> getUpcomingReservationByMember(String id) {
		List<ReservationListVO> upcomingList = mypageMapper.getUpcomingReservationByMember(id);

		// 체크인 - 체크아웃 날짜 계산
		for (ReservationListVO reserv : upcomingList) {
			LocalDate checkin = reserv.getSrCheckin().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate checkout = reserv.getSrCheckout().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

			long diff = ChronoUnit.DAYS.between(checkin, checkout);
			reserv.setNights((int) diff);
		}

		return upcomingList;
	}

	@Override
	public List<ReservationListVO> getCompletedReservationsByMember(String id) {
		List<ReservationListVO> completedList = mypageMapper.getCompletedReservationsByMember(id);

		// 체크인 - 체크아웃 날짜 계산
		for (ReservationListVO reserv : completedList) {
			LocalDate checkin = reserv.getSrCheckin().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			LocalDate checkout = reserv.getSrCheckout().toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

			long diff = ChronoUnit.DAYS.between(checkin, checkout);
			reserv.setNights((int) diff);
		}

		return completedList;
	}

	@Override
	public ReservationDetailVO getReservationDetail(String id) {
		return mypageMapper.getReservationDetail(id);
	}

	@Override
	public List<StayVO> getBookMarkList(String id) {
		return mypageMapper.getBookMarkList(id);
	}

	@Override
	public MemberVO readMemberById(String miId) {
		return commonMapper.read(miId);
	}

	@Override
	public void updateMemberProfile(MemberVO vo) {
		// 본인 제외 중복 검사 (정규화 기준)
	    if (vo.getMiPhone() != null && !vo.getMiPhone().isEmpty()) {
	        int dup = mypageMapper.countByPhoneNormalizedExceptSelf(vo.getMiPhone(), vo.getMiId());
	        if (dup > 0) {
	            throw new IllegalArgumentException("이미 사용 중인 전화번호입니다.");
	        }
	    }

	    // 업데이트
	    mypageMapper.updateProfile(vo);
	}

	@Transactional
	@Override
	public void changePassword(String miId, String currentPw, String newPw) {
		// 1) 사용자 조회
		MemberVO member = commonMapper.read(miId);
		if (member == null) {
			throw new IllegalArgumentException("회원이 존재하지 않습니다.");
		}

		// 2) 현재 비밀번호 검증 (PasswordEncoder 사용)
		if (!passwordEncoder.matches(currentPw, member.getMiPw())) {
			throw new IllegalArgumentException("현재 비밀번호가 일치하지 않습니다.");
		}
		
		// 3) 새 비밀번호 인코딩 후 저장
		String encoded = passwordEncoder.encode(newPw);
		mypageMapper.updatePassword(miId, encoded);
	}

	@Override
	public int countByPhoneNormalized(String digits) {
		return mypageMapper.countByPhoneNormalized(digits);
	}

	@Override
	public int countByPhoneNormalizedExceptSelf(String digits, String miId) {
		return mypageMapper.countByPhoneNormalizedExceptSelf(digits, miId);
	}
}
