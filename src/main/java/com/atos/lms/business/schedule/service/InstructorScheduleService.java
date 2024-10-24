package com.atos.lms.business.schedule.service;


import com.atos.lms.business.schedule.model.InstructorScheduleVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InstructorScheduleService {

private final InstructorScheduleDAO instructorScheduleDAO;

    @Autowired
    public InstructorScheduleService(InstructorScheduleDAO instructorScheduleDAO) {
        this.instructorScheduleDAO = instructorScheduleDAO;
    }

    // 모든 강사의 스케줄 조회
    public List<InstructorScheduleVO> getAllSchedules(InstructorScheduleVO scheduleVO) {
        return instructorScheduleDAO.selectAllSchedules(scheduleVO);
    }

    // 강사별 스케줄 조회
    public List<InstructorScheduleVO> getSchedulesByInstructor(InstructorScheduleVO scheduleVO) {
        return instructorScheduleDAO.selectScheduleByInstructor(scheduleVO);
    }

    // 스케줄 총 개수 조회
    public int getScheduleCountByInstructor(InstructorScheduleVO scheduleVO) {
        return instructorScheduleDAO.selectScheduleCountByInstructor(scheduleVO);
    }

    // 모든 강사 목록 조회
    public List<InstructorScheduleVO> getAllInstructors(InstructorScheduleVO scheduleVO) {
        return instructorScheduleDAO.selectAllInstructors(scheduleVO);
    }

    // 스케줄 등록
    public void addSchedule(InstructorScheduleVO scheduleVO) {
        instructorScheduleDAO.insertSchedule(scheduleVO);
    }

    // 스케줄 수정
    public void updateSchedule(InstructorScheduleVO scheduleVO) {
        instructorScheduleDAO.updateSchedule(scheduleVO);
    }

    // 스케줄 삭제
    public void deleteSchedule(InstructorScheduleVO scheduleVO) {
        instructorScheduleDAO.deleteSchedule(scheduleVO);
    }



}
