package org.zerock.controller;


import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.zerock.service.RestaurantService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;


@Controller
@AllArgsConstructor
public class HomeController {
	private RestaurantService service;
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		model.addAttribute("list",service.orderByrating());	//jsp에서 임의의 list 객체를 RestaurantService의  List<RestaurantVO>orderByrating();에 저장
		model.addAttribute("list1",service.orderByview());	
		model.addAttribute("list2",service.orderByreview());
		
		return "main/list";
	}
	
}
