package com.atos.lms.business.attendance.model;


import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class AllAttendanceExcelVO extends AllAttendanceMasterVO{

    private String corpName;     // 소속
    private String title;        // 교육명칭
    private int enrollID;        // 학생아이디
    private String name;         // 수강생 이름
    private String status;       // 상태명
    private LocalDate attendDate; // 출석일
    private LocalTime inTime;    // 입실시간
    private LocalTime outTime;   // 퇴실시간



}
