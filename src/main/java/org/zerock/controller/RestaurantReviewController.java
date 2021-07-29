package org.zerock.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.Principal;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.RestaurantAttachVO;
import org.zerock.domain.RestaurantReviewAttachVO;
import org.zerock.domain.RestaurantVO;
import org.zerock.domain.Restaurant_reviewVO;
import org.zerock.service.MemberService;
import org.zerock.service.RestaurantService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@RequestMapping("/restaurantreview/*")
@Log4j
@AllArgsConstructor
public class RestaurantReviewController {
	private RestaurantService service;

	private MemberService service1;
	
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/delete")
	public String delete(@RequestParam("cid")Integer cid,@RequestParam("rw") Integer rw, Principal principal, Model model) {
		String id = principal.getName().toString();
		String rid = service.getreview(rw).getUserid().toString();
		if(id.equals(rid)) {
			service.removeReview(rw);
			return "redirect:/restaurant?cid="+cid;
		}else {
			model.addAttribute("error","no");
			return "redirect:/restaurant?cid="+cid;
		}
		
	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/register")
	public void getreviewRegister(@RequestParam("cid") Integer cid, Principal principal, Model model) {
		model.addAttribute("member", service1.read(principal.getName()));
		model.addAttribute("restaurant", service.getRestaurant(cid));

	}

	@PreAuthorize("isAuthenticated()")
	@PostMapping("/register")
	public String reviewRegister(Restaurant_reviewVO reviewvo, RedirectAttributes rttr, HttpServletRequest request) {

		for (int i = 1; i < 6; i++) {
			reviewvo.setRw_rating(0.0);
			if (request.getParameter("rating" + i) == null) {
				break;
			}
			reviewvo.setRw_rating(Double.parseDouble(request.getParameter("rating" + i)));
		}
		
		reviewvo.setUserid(request.getParameter("userid"));
		reviewvo.setCid(Integer.parseInt(request.getParameter("cid")));
		service.registerRestaurantReview(reviewvo);
		log.info("asdfasdf"+service.getReviewAttachList(reviewvo.getRw_no()));
		
		if(service.getReviewAttachList(reviewvo.getRw_no()).isEmpty()) {
			
		
		
			
			service.updatereviewrating(reviewvo.getCid());
			return "redirect:/restaurant?cid=" + reviewvo.getCid();
			}
		else {
			List<RestaurantReviewAttachVO> attach = service.getReviewAttachList(reviewvo.getRw_no());

			RestaurantReviewAttachVO asdf = attach.get(0);

			String ab = asdf.getUploadPath();
			ab = ab.replace("\\", "/");
			String a = "/resources/img/" + ab + "/" + asdf.getUuid() + "_" + asdf.getFileName();

			reviewvo.setRw_photo(a);

			log.info("reviewvo : " + reviewvo);
			service.modifyRestaurantReview(reviewvo);
			return "redirect:/restaurant?cid=" + reviewvo.getCid();
		}
		
	}
	@PreAuthorize("isAuthenticated()")
	@GetMapping("/modify")
	public String getmodify(@RequestParam("cid")Integer cid,@RequestParam("rw") Integer rw, Principal principal, Model model)  {
		String id = principal.getName().toString();
		String rid = service.getreview(rw).getUserid().toString();
		
		if( id.equals(rid)) {
			
			model.addAttribute("member", service1.read(principal.getName()));
			model.addAttribute("restaurant", service.getRestaurant(cid));
			model.addAttribute("review",service.getreview(rw));
			return null;
		}
		else {
			
			


			model.addAttribute("error","no");
			return "redirect:/restaurant?cid="+cid;
		}
		
	}
	@PreAuthorize("isAuthenticated()")
	@PostMapping("/modify")
	public String modify(Restaurant_reviewVO reviewvo, RedirectAttributes rttr, HttpServletRequest request,Principal principal,Model model) {
		reviewvo.setCid(Integer.parseInt(request.getParameter("cid")));
		reviewvo.setRw_no(Integer.parseInt(request.getParameter("rw")));
		String id = principal.getName().toString();
		String rid = reviewvo.getUserid();
		if( id.equals(rid)) {
			for (int i = 1; i < 6; i++) {

				if (request.getParameter("rating" + i) == null) {
					break;
				}
				reviewvo.setRw_rating(Double.parseDouble(request.getParameter("rating" + i)));
			}
			reviewvo.setUserid(request.getParameter("userid"));
			
			service.modifyRestaurantReview(reviewvo);
			log.info("asdfasdf"+service.getReviewAttachList(reviewvo.getRw_no()));
			List<RestaurantReviewAttachVO> attach = service.getReviewAttachList(reviewvo.getRw_no());
			
			if(service.getReviewAttachList(reviewvo.getRw_no()).isEmpty()) {
				
			
			
				
				service.updatereviewrating(reviewvo.getCid());
				return "redirect:/restaurant?cid=" + reviewvo.getCid();
				}
			else {
				RestaurantReviewAttachVO asdf = attach.get(0);

				String ab = asdf.getUploadPath();
				ab = ab.replace("\\", "/");
				String a = "/resources/img/" + ab + "/" + asdf.getUuid() + "_" + asdf.getFileName();

				reviewvo.setRw_photo(a);

				log.info("reviewvo : " + reviewvo);
				service.modifyRestaurantReview(reviewvo);
				return "redirect:/restaurant?cid=" + reviewvo.getCid();
			}
		}
		else {
			
			


			model.addAttribute("error","no");
			
			return "redirect:/restaurant?cid="+reviewvo.getCid();
		}
		
		
	}

}
