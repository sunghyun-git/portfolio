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
	
	
}