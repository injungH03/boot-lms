package com.atos.lms.business.member.model;

import com.atos.lms.common.model.MasterVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class MemberMasterVO extends MasterVO {

    /** 목록 상태 코드 이름 **/
    private String listStatusName = "";

    /** id리스트 */
    private List<String> idlist;

    private String corpBiz;      // 사업자 번호
    private String corpName;     // 사업자 이름
}
