package org.zerock.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.zerock.domain.Criteria;
import org.zerock.domain.RestaurantAttachVO;
import org.zerock.domain.RestaurantReviewAttachVO;
import org.zerock.domain.RestaurantVO;
import org.zerock.domain.Restaurant_menuVO;
import org.zerock.domain.Restaurant_offVO;
import org.zerock.domain.Restaurant_openHourVO;
import org.zerock.domain.Restaurant_reviewVO;
import org.zerock.mapper.RestaurantAttachMapper;
import org.zerock.mapper.RestaurantMapper;
import org.zerock.mapper.RestaurantReviewAttachMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
public class RestaurantServiceImpl implements RestaurantService {

	

	
	
	@Setter(onMethod_ = { @Autowired })
	RestaurantMapper mapper;
	@Setter(onMethod_ = { @Autowired })
	RestaurantAttachMapper attachMapper;
	@Setter(onMethod_ = { @Autowired })
	RestaurantReviewAttachMapper reviewattachMapper;
	@Override
	public boolean removeReview(Integer rw_no) {
		reviewattachMapper.deleteAll(rw_no);
		mapper.deleteRestaurant_review(rw_no);
		return true;
	}
	@Override
	public Restaurant_reviewVO getreview(Integer rw_no) {
		return mapper.readReview(rw_no);
	}

	
	@Override
	public void updatereviewrating(Integer cid) {
		mapper.updaterating(cid);
		
	}
	@Override
	public boolean modifyRestaurantReview(Restaurant_reviewVO reviewvo) {
		mapper.updateRestaurant_review(reviewvo);
		reviewattachMapper.deleteAll(reviewvo.getRw_no());
		mapper.updateRestaurant_review(reviewvo);
		if(reviewvo.getAttachList() != null && reviewvo.getAttachList().size() > 0) {
			reviewvo.getAttachList().forEach(attach -> {
				attach.setRw_no(reviewvo.getRw_no());
				reviewattachMapper.insert(attach);
			});
		}
		return true;
	}
	@Override
	public List<RestaurantReviewAttachVO> getReviewAttachList(Integer rw_no) {
		// TODO Auto-generated method stub
		return reviewattachMapper.findByBno(rw_no);
	}
	@Override
	public void registerRestaurantReview(Restaurant_reviewVO reviewvo) {
		mapper.insertRestaurant_review(reviewvo);
		if(reviewvo.getAttachList() == null || reviewvo.getAttachList().size() <= 0) {
			return;
		}
		reviewvo.getAttachList().forEach(attach -> {
			attach.setRw_no(reviewvo.getRw_no());
			reviewattachMapper.insert(attach);
		});
		
	}
	
	@Override
	public void updatereviewcount(Integer cid) {
		mapper.updatereviewcount(cid);
		
	}
	@Override
	public void updateviewscount(Integer cid) {
		mapper.updateviewscount(cid);
	}
	@Transactional
	@Override
	public void registerRestaurant(RestaurantVO vo) {
		// log.info("vo : "+vo);
		mapper.insertRestaurant(vo);
		if(vo.getAttachList() == null || vo.getAttachList().size() <= 0) {
			return;
		}
		vo.getAttachList().forEach(attach -> {
			attach.setCid(vo.getCid());
			attachMapper.insert(attach);
		});

	}
	@Override
	public List<RestaurantAttachVO> getAttachList(Integer cid) {
		log.info("get Attach list by bno " + cid);
		return attachMapper.findByBno(cid);
	}

	@Override
	public void registerRestaurantOpen(List<Restaurant_openHourVO> openvo) {
		for (int i = 0; i < openvo.size(); i++) {

			mapper.insertRestaurant_open(openvo.get(i));
		}

	}

	@Override
	public void registerRestaurantOff(List<Restaurant_offVO> offvo) {
		for (int i = 0; i < offvo.size(); i++) {
			mapper.insertRestaurant_off(offvo.get(i));
		}
	}

	@Override
	public void registerRestaurantMenu(List<Restaurant_menuVO> menuvo) {
		for (int i = 0; i < menuvo.size(); i++) {
			mapper.insertRestaurant_menu(menuvo.get(i));
		}

	}

	@Override
	public RestaurantVO getRestaurant(Integer cid) {

		return mapper.readRestaurant(cid);
	}

	@Override
	public List<Restaurant_openHourVO> getRestaurantOpen(Integer cid) {
		List<Restaurant_openHourVO> vo = mapper.readRestaurant_open(cid);
		return vo;
	}

	@Override
	public List<Restaurant_offVO> getRestaurantOff(Integer cid) {
		List<Restaurant_offVO> vo = mapper.readRestaurant_off(cid);

		return vo;
	}

	@Override
	public List<Restaurant_menuVO> getRestaurantMenu(Integer cid) {
		List<Restaurant_menuVO> vo = mapper.readRestaurant_menu(cid);

		return vo;
	}

	@Override
	public List<Restaurant_reviewVO> getRestaurantReview(Integer cid) {
		List<Restaurant_reviewVO> vo = mapper.readRestaurant_review(cid);
		return vo;
	}

	@Override
	public boolean modifyRestaurant(RestaurantVO vo) {
		mapper.updateRestaurant(vo);
		attachMapper.deleteAll(vo.getCid());
		mapper.updateRestaurant(vo);
		if(vo.getAttachList() != null && vo.getAttachList().size() > 0) {
			vo.getAttachList().forEach(attach -> {
				attach.setCid(vo.getCid());
				attachMapper.insert(attach);
			});
		}
		return true;
	}

	@Override
	public boolean modifyRestaurantOpen(List<Restaurant_openHourVO> openvo) {
		for (int i = 0; i < openvo.size(); i++) {
			mapper.updateRestaurant_open(openvo.get(i));
		}
		return true;
	}

	@Override
	public boolean modifyRestaurantOff(List<Restaurant_offVO> offvo) {
		for(int i = 0 ; i < offvo.size() ; i++) {
			mapper.updateRestaurant_off(offvo.get(i));
		}	
		return true;
	}

	@Override
	public boolean modifyRestaurantMenu(List<Restaurant_menuVO> menuvo) {
		for (int i = 0; i < menuvo.size(); i++) {
			mapper.updateRestaurant_menu(menuvo.get(i));
		}
		return true;
	}

	@Override
	public boolean removeRestaurant(Integer cid) {
		mapper.deleteRestaurant(cid);
		attachMapper.deleteAll(cid);
		return true;
	}
	@Override
	public List<RestaurantVO>getList() {
		log.info("getList...");
		return mapper.getList();
	}
	
	@Override
	public List<RestaurantVO>topList(String address) {
		log.info("topList...");
		return mapper.topList(address);
	}
	
	@Override
	public List<RestaurantVO>topListcat(String address) {
		log.info("topListcat...");
		return mapper.topListcat(address);
	}
	
	@Override
	public List<RestaurantVO>orderByrating(){
		log.info("orderByrating...");
		return mapper.orderByrating();
	}
	
	@Override
	public List<RestaurantVO>orderByview(){
		log.info("orderByview...");
		return mapper.orderByview();
	}
	
	@Override
	public List<RestaurantVO>orderByreview(){
		log.info("orderByreview...");
		return mapper.orderByreview();
	}
	
	@Override
	public List<RestaurantVO>searchFood(Criteria cri){
		log.info("orderByreview...");
		return mapper.searchFood(cri);		
	}
	@Override
	public int getSearchCount(Criteria cri) {
		log.info("get total count");
		return mapper.getSearchCount(cri);
	}
	

}
