package org.zerock.mapper;

import java.util.List;


import org.zerock.domain.RestaurantAttachVO;

public interface RestaurantAttachMapper {
	public void insert(RestaurantAttachVO vo);
	
	public int delete(String uuid);
	
	public List<RestaurantAttachVO> findByBno(Integer cid);
	
	public void deleteAll(Integer cid);
	
	public List<RestaurantAttachVO> getOldFiles();
}
