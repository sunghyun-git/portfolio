package org.zerock.controller;

import java.security.Principal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.HttpRequest;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.authentication.AnonymousAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.MemberVO;
import org.zerock.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
public class MemberController {
	private MemberService service;
	
	
	
	@ResponseBody 
	@RequestMapping(value = "/idCheck", method = RequestMethod.POST)
	public Integer idChk(HttpServletRequest request) throws Exception {
		
		int result = service.idCheck(request.getParameter("userid"));
		log.info("result : "+ result);
		return result;
	} 
	
	@GetMapping("/join")
	public void join() {
		
	}
	
	@PostMapping("/join")
	public String join(RedirectAttributes rttr,HttpServletRequest request) throws Exception {
		//service.join(member);
		MemberVO vo = new MemberVO();
		vo.setUserid(request.getParameter("userid"));
		int result = service.idCheck(vo.getUserid());
		vo.setPwd(request.getParameter("pwd"));
		vo.setUsername(request.getParameter("username"));
		if(request.getParameter("nickname") != null) {
			vo.setNickname(request.getParameter("nickname"));
		} else {
			vo.setNickname("익명");
		}
		String email1 = request.getParameter("email1");
		
		String email2 = request.getParameter("email2");
		
		String email = email1 +"@"+email2;
		vo.setEmail(email);
		
		String year =request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String birth = year+"-"+month+"-"+day;
		
		SimpleDateFormat DF = new SimpleDateFormat("yyyy-MM-dd");
		Date birthday = new Date(DF.parse(birth).getTime());
		vo.setUserbirthday(birthday);
		
		if(request.getParameter("agree")==null) {
			vo.setAgree(false);
		}else {
			vo.setAgree(true);
		}
		log.info("member : "+vo);
		rttr.addFlashAttribute("result", vo.getUserid());
		
		try {
			if(result==1) {
				return "/member/join";
			}else if(result==0) {
				service.join(vo);
			}
		} catch(Exception e){
			throw new RuntimeException();
		}
		
	
		return "redirect:/member/login";
	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/mypage")
	public void mypage(Principal principal,Model model) {
		
		model.addAttribute("member",service.read(principal.getName()));
	}
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/mypage")
	public String mypage(RedirectAttributes rttr){
		
		return "redirect:/modify";
	}
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public void modify(Principal principal,Model model) {
		model.addAttribute("member",service.read(principal.getName()));
		MemberVO vo = service.read(principal.getName());
		SimpleDateFormat year = new SimpleDateFormat("yyyy");
		SimpleDateFormat month = new SimpleDateFormat("MM");
		SimpleDateFormat day = new SimpleDateFormat("dd");
		model.addAttribute("year", year.format(vo.getUserbirthday()));
		model.addAttribute("month", month.format(vo.getUserbirthday()));
		model.addAttribute("day", day.format(vo.getUserbirthday()));
		String email = vo.getEmail();
		int mailIndex = email.indexOf("@");
		String email1 = email.substring(0,mailIndex);
		String email2 = email.substring(mailIndex+1);
		model.addAttribute("email1",email1);
		model.addAttribute("email2",email2);
		
	}
	
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/modify")
	public String modify(HttpServletRequest request,RedirectAttributes rttr,Principal principal) throws ParseException {
		MemberVO vo = new MemberVO();
		vo = service.read(principal.getName());
		
		vo.setPwd(request.getParameter("pwd"));
		if(request.getParameter("nickname") != null) {
			vo.setNickname(request.getParameter("nickname"));
		} else {
			vo.setNickname("익명");
		}
		String email1 = request.getParameter("email1");
		
		String email2 = request.getParameter("email2");
		
		String email = email1 +"@"+email2;
		vo.setEmail(email);
		
		String year =request.getParameter("year");
		String month = request.getParameter("month");
		String day = request.getParameter("day");
		String birth = year+"-"+month+"-"+day;
		
		SimpleDateFormat DF = new SimpleDateFormat("yyyy-MM-dd");
		Date birthday = new Date(DF.parse(birth).getTime());
		vo.setUserbirthday(birthday);
		
		if(request.getParameter("agree")==null) {
			vo.setAgree(false);
		}else {
			vo.setAgree(true);
		}
		service.update(vo);
		return "redirect:/";
	}
	
	@GetMapping("/login")
	public String login(Model model,String error, String logout) {
		if(isAuthenticated()) {
			return "redirect:/";
		}
		if(error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if(logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		return "/member/login";
	}

	@PreAuthorize("isAuthenticated()")
	@GetMapping("/logout")
	public void logoutGet() {
		log.info("logout");
	}
	private boolean isAuthenticated() {
	    Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
	    if (authentication == null || AnonymousAuthenticationToken.class.
	      isAssignableFrom(authentication.getClass())) {
	        return false;
	    }
	    return authentication.isAuthenticated();
	}
	
}
