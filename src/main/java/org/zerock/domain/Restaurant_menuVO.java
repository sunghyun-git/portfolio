package org.zerock.domain;

import lombok.Data;

@Data
public class Restaurant_menuVO {
	private Integer cid;
	private Integer menuindex; 
	private String menu;
	private String price;
}
