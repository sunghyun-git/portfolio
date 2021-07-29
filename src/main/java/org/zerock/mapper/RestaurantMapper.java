package org.zerock.mapper;

import java.util.List;

import org.zerock.domain.Criteria;
import org.zerock.domain.RestaurantVO;
import org.zerock.domain.Restaurant_menuVO;
import org.zerock.domain.Restaurant_offVO;
import org.zerock.domain.Restaurant_openHourVO;
import org.zerock.domain.Restaurant_reviewVO;


import lombok.Data;


public interface RestaurantMapper {
	public int getSearchCount(Criteria cri);
	public List<RestaurantVO>searchFood(Criteria cri);
	// read
	public RestaurantVO readRestaurant(Integer cid);
	public List<Restaurant_openHourVO> readRestaurant_open(Integer cid);
	public List<Restaurant_offVO> readRestaurant_off(Integer cid);
	public List<Restaurant_menuVO> readRestaurant_menu(Integer cid);
	public List<Restaurant_reviewVO> readRestaurant_review(Integer cid);
	public Restaurant_reviewVO readReview(Integer rw_no);
	
	public List<RestaurantVO>getList();		//사실 상 사용안함
	public List<RestaurantVO>topList(String address);	//xml파일의 id가 topList로 설정된 구문을 읽어 옴
	public List<RestaurantVO>topListcat(String address); 
	public List<RestaurantVO>orderByrating();
	public List<RestaurantVO>orderByview();
	public List<RestaurantVO>orderByreview();
	
	// create
	public void insertRestaurant(RestaurantVO vo);
	public void insertRestaurant_open(Restaurant_openHourVO vo);
	public void insertRestaurant_off(Restaurant_offVO vo);
	public void insertRestaurant_menu(Restaurant_menuVO vo);
	public void insertRestaurant_review(Restaurant_reviewVO vo);
	
	
	//update
	public void updateRestaurant(RestaurantVO vo);
	public void updateRestaurant_open(Restaurant_openHourVO vo);
	public void updateRestaurant_off(Restaurant_offVO vo);
	public void updateRestaurant_menu(Restaurant_menuVO vo);
	public void updateRestaurant_review(Restaurant_reviewVO vo);
	
	public void updatereviewcount(Integer cid);
	public void updateviewscount(Integer cid);
	
	public void updaterating(Integer cid);
	
	public void updatelikecount(Integer cid);
	//delete
	
	public void deleteRestaurant(Integer cid);
	public void deleteRestaurant_open(Restaurant_openHourVO vo);
	public void deleteRestaurant_off(Restaurant_offVO vo);
	public void deleteRestaurant_menu(Restaurant_menuVO vo);
	public void deleteRestaurant_review(Integer rw_no);
	
}
