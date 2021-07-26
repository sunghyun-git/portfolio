package org.zerock.mapper;

import org.zerock.domain.MemberVO;

public interface MemberMapper {
	public MemberVO read(String userid);
	public void insert(MemberVO membervo);
	public void update(MemberVO membervo);
	public int idCheck(String userid);
}