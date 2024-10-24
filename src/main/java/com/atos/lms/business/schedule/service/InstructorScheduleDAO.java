package com.atos.lms.business.schedule.service;


import com.atos.lms.business.schedule.model.InstructorScheduleVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface InstructorScheduleDAO {


    // 모든 강사의 스케줄 조회
    List<InstructorScheduleVO> selectAllSchedules(InstructorScheduleVO scheduleVO);

    // 강사별 스케줄 조회
    List<InstructorScheduleVO> selectScheduleByInstructor(InstructorScheduleVO scheduleVO);

    // 스케줄 총 개수 조회
    int selectScheduleCountByInstructor(InstructorScheduleVO scheduleVO);

    // 모든 강사 목록 조회
    List<InstructorScheduleVO> selectAllInstructors(InstructorScheduleVO scheduleVO);

    // 새로운 스케줄 등록
    void insertSchedule(InstructorScheduleVO scheduleVO);

    // 스케줄 수정
    void updateSchedule(InstructorScheduleVO scheduleVO);

    // 스케줄 삭제
    void deleteSchedule(InstructorScheduleVO scheduleVO);



}
