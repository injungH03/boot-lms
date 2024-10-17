package com.atos.lms.common.model;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryVO implements GeneralModel {

	private String code;
	private String mainCode;
	private String subCode;
	private String mainName;
	private String subName;
	private String useYn;
	private String regDate;
	private String register;

	// 검색 조건 부분
	@Builder.Default
	private String checkYn = "Y";
	
	private List<String> mtype;
	private List<String> stype;

}
