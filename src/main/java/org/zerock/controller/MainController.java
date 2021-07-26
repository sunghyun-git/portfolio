 package org.zerock.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.zerock.domain.Criteria;
import org.zerock.domain.PageDTO;
import org.zerock.domain.RestaurantVO;

import org.zerock.service.RestaurantService;

import com.google.protobuf.Service;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@RequestMapping("/main/")
@AllArgsConstructor
public class MainController {
	private RestaurantService service; //RestaurantService을 사용하기 위함 
	
	
	//메인화면에서 사용하는 컨트롤러
	@GetMapping("/list")	//URL이 list로 요청 받았을 때
	public void list(Model model) {
		log.info("main_view"); //콘솔창에서 보이는 로그
		model.addAttribute("list",service.orderByrating());	//jsp에서 임의의 list 객체를 RestaurantService의  List<RestaurantVO>orderByrating();에 저장
		model.addAttribute("list1",service.orderByview());	
		model.addAttribute("list2",service.orderByreview());
	}
	
	
	//지역별 추천게시판 컨트롤러
	@GetMapping("/toplist")
	public void toplist(HttpServletRequest request, Model model) {
		String address= request.getParameter("address");	//URL에 임의로 address 값으로 설정한 것을 파라미터로 사용하기 위한 코드	
		log.info("toplist");
		model.addAttribute("list", service.topList(address));	
		String place = address.replace("%", "");	//toplistcat페이지에서 장소값 받아오기 위해  사용하는 문장 replace 쓰면 " "에 넣은 글자를 뒤에 ""안에 글자로 바꿀수 잇다.
		model.addAttribute("place",place);			
	}

	//카테고리별 추천 게시판 컨트롤러
	@GetMapping("/toplistcat")
	public void toplistcat(HttpServletRequest request, Model model) {
		String address= request.getParameter("address");
		log.info("toplist");
		model.addAttribute("list", service.topListcat(address));
		String place = address.replace("%", "");
		model.addAttribute("place",place);
	}
	
//	검색관련 컨트롤러
	@GetMapping("/search")
	public void search(HttpServletRequest request, Model model,Criteria cri) {
//		String address=request.getParameter("address");
	
		log.info("search..." + cri.getKeyword());
//		log.info("address..."+address);
		model.addAttribute("list",service.searchFood(cri));
//		keyword.replace("+","");
		int total = service.getSearchCount(cri);
		String place = cri.getKeyword();
		model.addAttribute("place",place);	
		model.addAttribute("count",total);
		model.addAttribute("pageMaker", new PageDTO(cri, total));	
	}
}


