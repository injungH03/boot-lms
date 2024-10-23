package com.atos.lms.business.lecture.model;

import lombok.Data;

@Data
public class LectureExcelVO {

    private String title;
    private String mainName;
    private String subName;
    private String instructorName;
    private String trainingTime;
    private int enrolled;
    private int capacity;
    private String learnDate;
    private String recStartDate;
    private String recEndDate;
    private String manager;
    private String managerContact;
    private String location;

}
