package com.atos.lms.business.company.model;

import com.atos.lms.common.model.GeneralModel;
import lombok.Data;

import java.time.LocalDate;

@Data
public class CompanyExcelDTO implements GeneralModel {

	private String bizRegNo; // 사업자등록번호
	private String corpName; // 업체명(법인명)
	private String repName; // 대표자명
	private String bizType; // 업태
	private String bizItem; // 종목
	private String phoneNo; // 전화번호
	private String faxNo; // 팩스번호
	private String taxInvoice; // 세금계산서(이메일)
	private int empCount; // 직원수
	private int trainCount; // 교육인원수
	private String trainManager; // 교육담당자명
	private String trainEmail; // 교육담당자(이메일)
	private String trainPhone; // 교육담당자(전화번호)
	private String taxManager; // 세금계산서담당자명
	private String taxEmail; // 세금계산서담당자(이메일)
	private String taxPhone; // 세금계산서담당자(전화번호)
	private LocalDate regDate; // 등록일
	private String zipcode; // 우편번호
	private String addr1; // 주소
	private String addr2; // 상세주소




}
