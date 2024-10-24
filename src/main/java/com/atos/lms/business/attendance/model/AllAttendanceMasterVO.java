package com.atos.lms.business.attendance.model;


import com.atos.lms.common.model.MasterVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class AllAttendanceMasterVO extends MasterVO {


    /** 신청시작일 */
    private String srcStartDate;

    /** 신청종료일 */
    private String srcEndDate;

    /** 과정날짜 */
    private String srcLearnDate;

    /** 강의상태 */
    private String learnStatus;



}
