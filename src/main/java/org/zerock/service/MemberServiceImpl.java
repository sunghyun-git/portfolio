package org.zerock.service;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.mail.HtmlEmail;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.zerock.domain.AuthVO;
import org.zerock.domain.MemberLikeVO;
import org.zerock.domain.MemberVO;
import org.zerock.mapper.MemberAuthMapper;
import org.zerock.mapper.MemberMapper;
import lombok.AllArgsConstructor;
import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = { @Autowired })
	private MemberMapper mapper;

	@Setter(onMethod_ = { @Autowired })
	private MemberAuthMapper authMapper;
	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@Override
	public List<MemberLikeVO> readlike(String userid) {
		return mapper.readlike(userid);

	}
	// 아이디 찾기 
	@Override
	public String findid(MemberVO vo,HttpServletResponse response) throws Exception{
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		MemberVO ck= mapper.findid(vo);
		String userid = ck.getUserid();
		if (userid == null) {
			out.println("<script>");
			out.println("alert('가입된 아이디가 없습니다.');");
			out.println("history.go(-1);");
			out.println("</script>");
			out.close();
			return null;
		} else {
			return userid;
		}




	}
	// 이메일발송
	@Override
	public void sendEmail(MemberVO vo, String div) throws Exception {
		String charSet = "utf-8";
		String hostSMTP = "smtp.gmail.com"; 
		String hostSMTPid = "eatchelin@gmail.com";
		String hostSMTPpwd = "eat12345";
		
		String fromEmail = "eatchelin@gmail.com";
		String fromName = "eatchelin";
		String subject = "";
		String msg = "";
		
		if(div.equals("findpw")) {
			subject = "잇 슐랭 임시 비밀번호 입니다.";
			msg += "<div align='center' style='border:1px solid black; font-family:verdana'>";
			msg += "<h3 style='color: blue;'>";
			msg += vo.getUserid() + "님의 임시 비밀번호 입니다. 비밀번호를 변경하여 사용하세요.</h3>";
			msg += "<p>임시 비밀번호 : ";
			msg += vo.getPwd() + "</p></div>";
		}
		
		String mail = vo.getEmail();
		String name = vo.getUsername();
		try {
			HtmlEmail email = new HtmlEmail();
			email.setDebug(true);
			email.setCharset(charSet);
			email.setSSL(true);
			email.setHostName(hostSMTP);
			email.setSmtpPort(587); //네이버 이용시 587

			email.setAuthentication(hostSMTPid, hostSMTPpwd);
			email.setTLS(true);
			email.addTo(mail, name,charSet);
			email.setFrom(fromEmail, fromName, charSet);
			email.setSubject(subject);
			email.setHtmlMsg(msg);
			email.send();
		}catch(Exception e) {
			log.info("메일발송 실패 : "+e);
		}
	}

	// 비밀번호 찾기
	@Override
	public void findPw(MemberVO vo,HttpServletResponse response) throws Exception {
		MemberVO ck = mapper.read(vo.getUserid());
		response.setContentType("text/html; charset=UTF-8");

		PrintWriter out = response.getWriter();
		// 가입된 아이디가 없으면
		if(mapper.idCheck(vo.getUserid())==0) {
			out.print("<script>alert('등록되지 않은 아이디입니다.'); location.href='/member/findpw';</script>");
			out.close();
		} else if(!vo.getEmail().equals(ck.getEmail())) {
			out.print("<script>alert('등록되지 않은 이메일입니다.'); location.href='/member/findpw';</script>");
			out.close();
		}else {
			String pw = "";
			for (int i = 0; i < 12; i++) {
				pw += (char) ((Math.random() * 26) + 97);
			}
			vo=ck;
			vo.setPwd(pw);
			sendEmail(vo, "findpw");

			// 비밀번호 변경
			update(vo);
			// 비밀번호 변경 메일 발송
			
			out.print("<script>alert('이메일로 임시 비밀번호를 발송하였습니다.'); location.href='/member/login';</script>");
			out.close();
		}
	}

	@Override
	public void insertlike(MemberLikeVO memberlikevo) {
		List<MemberLikeVO> List = mapper.readlike(memberlikevo.getUserid());
		for (int i = 0; i < List.size(); i++) {
			MemberLikeVO vo = List.get(i);
			if (vo.equals(memberlikevo)) {
				mapper.deletelike(memberlikevo);

			}
		}
		mapper.insertlike(memberlikevo);
	}

	@Override
	public void deletelike(MemberLikeVO memberlikevo) {
		mapper.deletelike(memberlikevo);

	}

	@Transactional
	@Override
	public void join(MemberVO member) {
		log.info("MemberService:join()");

		String encPw = pwencoder.encode(member.getPwd());
		member.setPwd(encPw);

		mapper.insert(member);
		// 디폴트로 ROLE_USER 부여 : 추후 권한 부여에 대한 기능 검토 필요
		AuthVO auth = new AuthVO();
		auth.setUserid(member.getUserid());
		auth.setAuth("ROLE_USER");
		authMapper.insert(auth);
	}

	@Override
	public MemberVO read(String userid) {

		return mapper.read(userid);
	}

	@Override
	public void update(MemberVO member) {
		String encPw = pwencoder.encode(member.getPwd());
		member.setPwd(encPw);
		mapper.update(member);

	}

	@Override
	public int idCheck(String userid) {
		int Count = mapper.idCheck(userid);

		return Count;
	}

}
