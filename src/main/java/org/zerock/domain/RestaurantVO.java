package org.zerock.domain;

import java.util.List;

import lombok.Data;

@Data
public class RestaurantVO {
	private Integer cid;
	private String address;
	private String cate1name;
	private String catename;
	private String parking;
	private String placename;
	private String phonenum;
	private String mainphotourl;
	private int reviewcount;
	private int views;
	private double rating;
	private List<RestaurantAttachVO> attachList;

	
	
}
