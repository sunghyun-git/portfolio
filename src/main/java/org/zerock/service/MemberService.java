package org.zerock.service;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.zerock.domain.MemberLikeVO;
import org.zerock.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO member);
	public MemberVO read(String userid);
	public void update(MemberVO member);
	
	public int idCheck(String userid);
	public int emailCheck(String email);
	public List<String> emailcertification(String email) throws Exception;
	
	public List<MemberLikeVO> readlike(String userid);
	public void insertlike(MemberLikeVO memberlikevo);
	
	public void deletelike(MemberLikeVO memberlikevo);
	//이메일발송
	public void sendEmail(MemberVO vo,String div,String check) throws Exception;
	//비밀번호 찾기
	public void findPw(MemberVO vo,HttpServletResponse response) throws Exception;
	
	public String findid(MemberVO vo,HttpServletResponse response) throws Exception;
}
