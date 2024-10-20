package com.atos.lms.business.member.model;

import com.atos.lms.common.model.GeneralModel;
import lombok.Data;

@Data
public class MemberDTO implements GeneralModel {

    private String id;
    private String name;
    private String birthdate;
    private String phoneNo;
    private String zipcode;
    private String addr1;
    private String addr2;
    private String bizRegNo;
    private String status;
    private String department;
    private String position;
    private String email;

    private String companybizRegNo; //사업자번호
    private String corpName; //법인명(사업자명)
    private String repName; //대표자명
    private String bizType; //업태
    private String bizItem; //종목
    private String companyPhoneNo; //대표전화번호
    private String companyZipcode; //회사우편번호
    private String companyAddr1; //주소1
    private String companyAddr2; //주소2
}
