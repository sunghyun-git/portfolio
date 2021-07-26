package org.zerock.service;

import org.zerock.domain.MemberVO;

public interface MemberService {
	public void join(MemberVO member);
	public MemberVO read(String userid);
	public void update(MemberVO member);
	public int idCheck(String userid);

}
