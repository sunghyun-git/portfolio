package org.zerock.mapper;

import java.util.List;


import org.zerock.domain.RestaurantAttachVO;
import org.zerock.domain.RestaurantReviewAttachVO;

public interface RestaurantReviewAttachMapper {
	public void insert(RestaurantReviewAttachVO vo);
	
	public int delete(String uuid);
	
	public List<RestaurantReviewAttachVO> findByBno(Integer rw_no);
	
	public void deleteAll(Integer rw_no);
	
	public List<RestaurantReviewAttachVO> getOldFiles();
}
