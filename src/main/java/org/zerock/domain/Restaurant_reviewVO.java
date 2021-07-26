package org.zerock.domain;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Restaurant_reviewVO {
	private Integer cid;
	private Integer rw_no;
	private String rw_writer;
	private String rw_content;
	private String rw_photo;
	private Date rw_regdate;
	private Date rw_updatedate;
	private Double rw_rating;
	private String userid;
	private List<RestaurantReviewAttachVO> attachList;
}
