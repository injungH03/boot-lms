package com.atos.lms.business.lecture.model;


import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class LectureMemDTO extends LectureMasterVO {
	
	private String memberId;
	private String memName;
	private String bizRegNo;
	private String corpName;
	private String phoneNo;
	private int lectureCode;
	private int enrollCode;
	private String corpBiz;
	private int enrolled;
	
	private List<String> memberIds;
	private List<Integer> enrollIds;
	
	
}
