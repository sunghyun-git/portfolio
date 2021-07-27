package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.MemberLikeVO;
import org.zerock.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid);
	public void insert(MemberVO membervo);
	public void update(MemberVO membervo);
	public int idCheck(String userid);
	
	public List<MemberLikeVO> readlike(String userid);
	public void insertlike(MemberLikeVO memberlikevo);
	
	public void deletelike(MemberLikeVO memberlikevo);
	//비밀번호 찾기 (바꾸기)
	public void updatePw(MemberVO vo) throws Exception;
	public MemberVO findid(MemberVO vo) throws Exception;
}