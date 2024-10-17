package com.atos.lms.business.lecture.model;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class LectureEnrollDTO extends LectureMasterVO {
	
    private int enrollCode;          // 강의 배정 코드
    private String memberId;         // 수강생 아이디
    private int lectureId;           // 강의 코드
    private int lectureCode;         // 강의 검색 코드
    private String learnDate;        // 강의 날짜
    private String appDate;          // 배정 날짜
    private String title;            // 강의 이름
    private String memName;             // 수강생 이름
    private String phoneNo;          // 전화번호
    private String email;            // 이메일
    private String corpName;         // 소속 회사명
    private String issueDate;        // 수료증 발급 날짜
    private String certStatus;       // 수료 여부 Y, N
}
