package org.zerock.service;

import java.util.List;

import org.zerock.domain.MemberLikeVO;
import org.zerock.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO member);
	public MemberVO read(String userid);
	public void update(MemberVO member);
	public int idCheck(String userid);
	
	
	public List<MemberLikeVO> readlike(String userid);
	public void insertlike(MemberLikeVO memberlikevo);
	
	public void deletelike(MemberLikeVO memberlikevo);
}
