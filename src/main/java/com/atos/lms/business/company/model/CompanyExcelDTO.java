package com.atos.lms.business.company.model;

import com.atos.lms.common.model.GeneralModel;
import lombok.Data;

import java.time.LocalDate;


@Data
public class CompanyExcelDTO implements GeneralModel {

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
