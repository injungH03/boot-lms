package com.atos.lms.business.lecture.model;

import lombok.Data;
import lombok.EqualsAndHashCode;

import java.util.List;

@EqualsAndHashCode(callSuper = true)
@Data
public class LectureAttendDTO extends LectureMasterVO {


    private int attendCode;
    private int enrollId;
    private String inTime;
    private String outTime;
    private String attendDate;
    private String status;
    private String memberId;
    private String name;
    private String corpName;
    private int lectureId;

    private String inTimeFormat;
    private String outTimeFormat;

    private int lectureCode; // 공용 파라미터
    private List<Integer> attendCodeList;

}
