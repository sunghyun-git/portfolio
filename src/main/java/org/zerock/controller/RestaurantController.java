package org.zerock.controller;

import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.domain.RestaurantAttachVO;
import org.zerock.domain.RestaurantVO;
import org.zerock.domain.Restaurant_menuVO;
import org.zerock.domain.Restaurant_offVO;
import org.zerock.domain.Restaurant_openHourVO;
import org.zerock.domain.Restaurant_reviewVO;
import org.zerock.service.RestaurantService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Controller
@Log4j
@AllArgsConstructor
public class RestaurantController {
	private RestaurantService service;
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/register")
	public void getregister() {

	}
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/register")
	public String postregister(RestaurantVO vo, RedirectAttributes rttr, HttpServletRequest request) {
		log.info("================================");
		log.info("register: " + vo);
		service.registerRestaurant(vo);
		log.info("asdfasdf"+service.getAttachList(vo.getCid()));
		if (service.getAttachList(vo.getCid()).isEmpty()) {
			
		} else {
			List<RestaurantAttachVO> attach = service.getAttachList(vo.getCid());
			RestaurantAttachVO asdf = attach.get(0);

			String ab = asdf.getUploadPath();
			ab = ab.replace("\\", "/");
			String a = "/resources/img/" + ab + "/" + asdf.getUuid() + "_" + asdf.getFileName();

			vo.setMainphotourl(a);
			service.modifyRestaurant(vo);
		}
		
		String[] periodName = request.getParameterValues("periodName");
		String[] timeName = request.getParameterValues("timeName");
		String[] timeSE = request.getParameterValues("timeSE");
		String[] dayOfWeek = request.getParameterValues("dayOfWeek");

		List<Restaurant_openHourVO> openvoList = new ArrayList<>();
		for (int i = 0; i < timeName.length; i++) {
			Restaurant_openHourVO openvo = new Restaurant_openHourVO();
			openvo.setCid(vo.getCid());
			if (periodName[i] == "") {
				periodName[i] = "영업기간";
			}
			openvo.setPeriodName(periodName[i]);
			openvo.setTimeName(timeName[i]);
			openvo.setTimeSE(timeSE[i]);
			openvo.setDayOfWeek(dayOfWeek[i]);
			openvoList.add(openvo);
		}

		service.registerRestaurantOpen(openvoList);

		String[] holydayName = request.getParameterValues("holydayName");
		String[] offdate = request.getParameterValues("offdate");

		List<Restaurant_offVO> offvoList = new ArrayList<>();
		for (int i = 0; i < holydayName.length; i++) {
			if (holydayName[i].equals("")) {
				holydayName[i] = null;
			}
			if (offdate[i].equals("")) {
				offdate[i] = null;
			}
			Restaurant_offVO offvo = new Restaurant_offVO();
			offvo.setHolydayName(holydayName[i]);
			offvo.setCid(vo.getCid());
			offvo.setOffdate(offdate[i]);
			offvoList.add(offvo);
		}
		service.registerRestaurantOff(offvoList);

		String[] menu = request.getParameterValues("menu");
		String[] price = request.getParameterValues("price");
		List<Restaurant_menuVO> menuvoList = new ArrayList<Restaurant_menuVO>();
		if (menu != null) {
			for (int i = 0; i < menu.length; i++) {
				Restaurant_menuVO menuvo = new Restaurant_menuVO();
				menuvo.setMenu(menu[i]);
				menuvo.setPrice(price[i]);
				menuvo.setCid(vo.getCid());
				menuvoList.add(menuvo);
			}
			service.registerRestaurantMenu(menuvoList);
		}

		return "redirect:/restaurant?cid=" + vo.getCid();
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/modify")
	public void getmodify(@RequestParam("cid") Integer cid, Model model) {
		log.info("cid : " + cid);
		model.addAttribute("cid", cid);
		model.addAttribute("Restaurant", service.getRestaurant(cid));

		model.addAttribute("open", service.getRestaurantOpen(cid));

		model.addAttribute("off", service.getRestaurantOff(cid));

		model.addAttribute("menu", service.getRestaurantMenu(cid));

		log.info("open : " + service.getRestaurantOpen(cid));
		log.info("off : " + service.getRestaurantOff(cid));
		log.info("menu : " + service.getRestaurantMenu(cid));

	}

	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@PostMapping("/modify")
	public String postmodify(RestaurantVO vo, HttpServletRequest request) {
		vo.setCid(Integer.parseInt(request.getParameter("cid")));
		if (service.getAttachList(vo.getCid()).isEmpty()) {
			
		} else {
			List<RestaurantAttachVO> attach = service.getAttachList(vo.getCid());
			RestaurantAttachVO asdf = attach.get(0);

			String ab = asdf.getUploadPath();
			ab = ab.replace("\\", "/");
			String a = "/resources/img/" + ab + "/" + asdf.getUuid() + "_" + asdf.getFileName();

			vo.setMainphotourl(a);
			service.modifyRestaurant(vo);
		}
		
		String[] periodName = request.getParameterValues("periodName");
		String[] timeName = request.getParameterValues("timeName");
		String[] timeSE = request.getParameterValues("timeSE");
		String[] dayOfWeek = request.getParameterValues("dayOfWeek");

		List<Restaurant_openHourVO> openvoList = new ArrayList<>();
		for (int i = 0; i < timeName.length; i++) {
			Restaurant_openHourVO openvo = new Restaurant_openHourVO();
			openvo.setCid(vo.getCid());
			if (periodName[i] == "") {
				periodName[i] = "영업기간";
			}
			openvo.setPeriodName(periodName[i]);
			openvo.setTimeName(timeName[i]);
			openvo.setTimeSE(timeSE[i]);
			openvo.setDayOfWeek(dayOfWeek[i]);
			openvoList.add(openvo);
		}

		service.modifyRestaurantOpen(openvoList);

		String[] holydayName = request.getParameterValues("holydayName");
		String[] offdate = request.getParameterValues("offdate");

		List<Restaurant_offVO> offvoList = new ArrayList<>();
		for (int i = 0; i < holydayName.length; i++) {
			if (holydayName[i].equals("")) {
				holydayName[i] = null;
			}
			if (offdate[i].equals("")) {
				offdate[i] = null;
			}
			Restaurant_offVO offvo = new Restaurant_offVO();
			offvo.setHolydayName(holydayName[i]);
			offvo.setCid(vo.getCid());
			offvo.setOffdate(offdate[i]);
			offvoList.add(offvo);
		}
		service.registerRestaurantOff(offvoList);

		String[] menu = request.getParameterValues("menu");
		String[] price = request.getParameterValues("price");
		List<Restaurant_menuVO> menuvoList = new ArrayList<Restaurant_menuVO>();
		if (menu != null) {
			for (int i = 0; i < menu.length; i++) {
				Restaurant_menuVO menuvo = new Restaurant_menuVO();
				menuvo.setMenu(menu[i]);
				menuvo.setPrice(price[i]);
				menuvo.setCid(vo.getCid());
				menuvoList.add(menuvo);
			}
			service.registerRestaurantMenu(menuvoList);
		}

		return "redirect:/restaurant?cid=" + vo.getCid();
	}
	
	@GetMapping("/restaurant")
	public void jsonParse(String error,Model model, HttpServletRequest request) {
		model.addAttribute("error",error);
		SimpleDateFormat DF = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Integer cid = Integer.parseInt(request.getParameter("cid"));
		// service.getRestaurant(2030217673);
		service.updateviewscount(cid);
		model.addAttribute("Restaurant", service.getRestaurant(cid));

		model.addAttribute("open", service.getRestaurantOpen(cid));

		model.addAttribute("off", service.getRestaurantOff(cid));

		model.addAttribute("menu", service.getRestaurantMenu(cid));

		model.addAttribute("review", service.getRestaurantReview(cid));
		List<Restaurant_reviewVO> reviewVO = service.getRestaurantReview(cid);
		for (int i = 0; i < reviewVO.size(); i++) {
			Date A = reviewVO.get(i).getRw_updatedate();
			model.addAttribute("reviewa", DF.format(A));

		}
	}
	
	@PreAuthorize("hasAnyRole('ROLE_ADMIN', 'ROLE_MEMBER')")
	@GetMapping("/delete")
	public String delete(@RequestParam("cid") Integer cid, RedirectAttributes rttr) {
		List<RestaurantAttachVO> attachList = service.getAttachList(cid);
		if (service.removeRestaurant(cid)) {
			deleteFiles(attachList);

		}

		return "redirect:/";
	}
	
	// 파일 삭제 함수
		private void deleteFiles(List<RestaurantAttachVO> attachList) {
			if (attachList == null || attachList.size() == 0) {
				return;
			}

			log.info("delete attach files...................");
			log.info(attachList);

			attachList.forEach(attach -> {
				try {
					Path file = Paths.get("D:\\spring\\swork\\ex1234\\src\\main\\webapp\\resources\\img\\"
							+ attach.getUploadPath() + "\\" + attach.getUuid() + "_" + attach.getFileName());
					Files.deleteIfExists(file);
					if (Files.probeContentType(file).startsWith("image")) {
						Path thumbNail = Paths.get("D:\\spring\\swork\\ex1234\\src\\main\\webapp\\resources\\img\\"
								+ attach.getUploadPath() + "\\s_" + attach.getUuid() + "_" + attach.getFileName());
						Files.delete(thumbNail);
					}
				} catch (Exception e) {
					log.error("delete file error" + e.getMessage());
				} // end catch
			});// end foreachd
		}
}
