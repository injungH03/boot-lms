package com.atos.lms.business.education.model;


import lombok.*;

import java.time.LocalDate;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class EducationVO extends EducationMasterVO {


	// atos_category_detail
	// atos_category_main
    // atos_category_sub
    private String code; // 교육 분류 정보 코드
    private String mainCode; // 대분류 코드
    private String subCode; // 중분류 코드
    private String mainName; // 대분류 명칭
    private String subName; // 중분류 명칭
    private String detailCode; // 소분류 코드
    private String detailName; // 소분류 명칭
    private String use_Yn; // 사용 여부


    // atos_education
    private int eduCode; // 코드
    private String title; // 명칭
    private String category; // 교육분류
    private String description; // 과정소개
    private String objective; // 과정목표
    private String completionCriteria; // 수료조건
    private String note; // 비고
    private String status; // 상태정보
    private int trainingTime; // 교육시간
    private LocalDate regDate; // 등록일
    private String register; // 등록자



}
