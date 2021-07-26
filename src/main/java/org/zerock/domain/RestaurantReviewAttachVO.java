package org.zerock.domain;

import lombok.Data;

@Data
public class RestaurantReviewAttachVO {
	private String uuid;
	private String uploadPath;
	private String fileName;
	private boolean fileType;
	private Integer rw_no;
}
