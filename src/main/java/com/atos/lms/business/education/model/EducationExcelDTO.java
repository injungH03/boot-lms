package com.atos.lms.business.education.model;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import java.time.LocalDate;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class EducationExcelDTO extends EducationMasterVO {


    private String title; // 명칭
    private String category; // 교육분류
    private String description; // 과정소개
    private String objective; // 과정목표
    private String completionCriteria; // 수료조건
    private String note; // 비고
    private String status; // 상태정보
    private String trainingTime; // 교육시간
    private LocalDate regDate; // 등록일
    private String register; // 등록자



}
