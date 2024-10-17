package com.atos.lms.business.lecture.model;


import com.atos.lms.common.model.GeneralModel;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class LectureVO extends LectureMasterVO {
	
    private int lectureCode;         // 강의정보코드
    private int education;           // 교육정보코드
    private String instructor;       // 강사
    private String location;         // 교육장소
    private String locationDetail;   // 교육장소 상세
    private String atchFileId;       // 파일아이디
    private String recStartDate;     // 접수시작일
    private String recEndDate;       // 접수종료일
    private String status;           // 상태정보
    private String cancelStartDate;  // 취소기간시작일
    private String cancelEndDate;    // 취소기간종료일
    private String learnDate;        // 강의일자
    private String learnEndDate;     // 학습종료일
    private String startTime;        // 시작시간
    private String endTime;          // 종료시간
    private String manager;          // 담당자
    private String managerContact;   // 담당자연락처
    private String lectureMethod;    // 방식(방문, 온라인, 교육장)
    private int capacity;            // 수용가능인원수
    private int enrolled;            // 등록된인원수
    private String regDate;          // 등록일
    private String register;         // 등록자
    
    private String startTimeFormat;  // 시작시간 포멧
    private String endTimeFormat;    // 종료시간 포멧
    
    private String learnStatus;      // 강의상태
    
    /**### atos_instructor ###*/
    private String instructorName;   // 강사 이름
    
    /**### atos_education ###*/
    private int eduCode;         // 교육코드
    private String title;        // 교육제목
    private String category;     // 카테고리상세코드
    private String description;  // 교육소개
    private String objective;    // 교육목표
    private String completionCriteria; // 수료조건
    private String note;         // 비고
    private String trainingTime; // 교육 총시간
    private String eStatus;      // 교육 상태 정보
    
    /**### atos_category_* ### */
    private String mainCode;     // 카테고리 메인 코드
    private String subCode;      // 카테고리 서브 코드
    private String useYn;        // 카테고리 사용 여부
    private String mainName;     // 카테고리 메인 이름
    private String subName;      // 카테고리 서브 이름

}
