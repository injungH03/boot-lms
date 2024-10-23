package com.atos.lms.business.attendance.model;


import lombok.*;

import java.time.LocalDate;
import java.time.LocalTime;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
public class AllAttendanceVO extends AllAttendanceMasterVO {

	/* atos_attendance */
	private int attendCode;        // 출석 코드
	private int enrollID;        // 학생아이디
	private LocalTime inTime;         // 입실시간
	private LocalTime outTime;        // 퇴실시간
	private LocalDate attendDate;  // 출석일
	private String status;         // 상태

	/* atos_member */
	private String memberId;       // 학생아이디
	private String name;          // 이름
	private int lectureId; 		//강의 정보 코드

	/* atos_company */
	private String bizRegNo;      // 사업자등록번호
    private String corpName;      // 법인(단체)명

    /* atos_education */
    private int eduCode;          // 교육 코드
    private String title;         // 교육 명칭


    private int lectureCode;  // 강의 코드


}
