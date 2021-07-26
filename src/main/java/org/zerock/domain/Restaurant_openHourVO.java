package org.zerock.domain;

import lombok.Data;

@Data
public class Restaurant_openHourVO {
	private Integer cid;
	private Integer openHourindex;
	private String openhourDisplayText;
	private String periodName;
	private String timeName;
	private String timeSE;
	private String dayOfWeek;
}
