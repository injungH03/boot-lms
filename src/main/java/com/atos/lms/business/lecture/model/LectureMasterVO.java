package com.atos.lms.business.lecture.model;

import com.atos.lms.common.model.MasterVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class LectureMasterVO extends MasterVO {

    /** 카테고리 검색 메인 코드*/
    private String srcMainCode;

    /** 신청시작일 */
    private String srcStartDate;

    /** 신청종료일 */
    private String srcEndDate;

    /** 과정날짜 */
    private String srcLearnDate;
}
