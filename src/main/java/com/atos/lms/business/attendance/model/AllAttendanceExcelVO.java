package com.atos.lms.business.attendance.model;


import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
public class AllAttendanceExcelVO {

    private int No;                 // 번호 추가
    private String corpName;        // 소속
    private String title;           // 교육명
    private String lectureTitle;    // 강의 제목
    private String memberId;        // 수강생 ID
    private String name;            // 수강생 이름
    private String status;          // 출석 상태
    private LocalDate attendDate;   // 출석일
    private LocalTime inTime;       // 입실시간
    private LocalTime outTime;      // 퇴실시간
    private String learnStatus;     // 강의 상태


}
