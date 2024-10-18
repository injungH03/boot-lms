package com.atos.lms.business.education.model;

import com.atos.lms.common.model.MasterVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;


@EqualsAndHashCode(callSuper = true)
@Data
public class EducationMasterVO extends MasterVO {


    private List<Integer> eduCodeList;  // 여러 개의 교육 코드 처리


    // 수료 조건 관련 필드
    private String completionCode; // 수료 조건 코드
    private String completionRate; // 진도율
    private String completionScore; // 시험 점수
    private String completionSurvey; // 설문 유무

    // 강의 정보 코드
    private int lectureCode;


}
