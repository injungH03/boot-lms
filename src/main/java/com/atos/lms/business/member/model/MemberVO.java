package com.atos.lms.business.member.model;

import com.atos.lms.common.model.GeneralModel;
import com.atos.lms.common.model.MasterVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class MemberVO extends MemberMasterVO {

    private String id;           // 회원 ID
    private String password;     // 회원 비밀번호
    private String name;         // 회원 이름
    private String gender;       // 성별 (M: 남성, F: 여성)
    private String birthdate;    // 생년월일
    private String phoneNo;      // 전화번호
    private String zipcode;      // 우편번호
    private String addr1;        // 주소 1
    private String addr2;        // 주소 2
    private String status;       // 계정 상태 (활성/비활성 등)
    private String email;        // 이메일 주소
    private boolean enabled;     // 계정 활성화 여부
    private String department;   // 회원 부서
    private String position;     // 회원 직책

    private String roleId;       // 권한
    private String roleName;     // 권한 이름



}
