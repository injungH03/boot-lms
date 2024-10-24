package com.atos.lms.business.schedule.controller;


import com.atos.lms.business.schedule.model.InstructorScheduleVO;
import com.atos.lms.business.schedule.service.InstructorScheduleService;
import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.utl.ResponseHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

@Controller
@RequestMapping("/admin/education")
public class InstructorScheduleController {

 private static final Logger LOGGER = LoggerFactory.getLogger(InstructorScheduleController.class);

 private final InstructorScheduleService instructorScheduleService;

 @Autowired
 public InstructorScheduleController(InstructorScheduleService instructorScheduleService) {
  this.instructorScheduleService = instructorScheduleService;
 }



    @RequestMapping("/ischeduleList")
    public String scheduleList(@ModelAttribute("scheduleSearchVO") InstructorScheduleVO scheduleVO, ModelMap model) throws Exception {
       // 강사 목록 조회
        List<InstructorScheduleVO> instructorList = instructorScheduleService.getAllInstructors(scheduleVO);
        model.addAttribute("instructorList", instructorList);

        LOGGER.info("Instructor list size: {}", instructorList.size());

        List<InstructorScheduleVO> scheduleList;

        // 강사 선택 여부 확인
        if (scheduleVO.getInstructor() != null && !scheduleVO.getInstructor().isEmpty()) {
            LOGGER.info("Selected instructor ID: {}", scheduleVO.getInstructor());

            // 선택된 강사의 스케줄 리스트 조회
            scheduleList = instructorScheduleService.getSchedulesByInstructor(scheduleVO);

            LOGGER.info("Schedule list size: {}", scheduleList.size());
        } else {
            LOGGER.info("No instructor selected, displaying all schedules.");

            // 전체 강사의 스케줄 리스트 조회
            scheduleList = instructorScheduleService.getAllSchedules(scheduleVO);

            LOGGER.info("All schedules list size: {}", scheduleList.size());
        }

        model.addAttribute("scheduleList", scheduleList);

        return "atos/schedule/instructorSchedule";  // JSP 경로에 맞게 수정 필요
    }

    // 새로운 스케줄 저장 요청을 처리
    @RequestMapping("/registerSchedule")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> registerSchedule(@RequestBody InstructorScheduleVO scheduleVO) throws Exception {
        LOGGER.info("===== Register Schedule Endpoint Reached =====");
        LOGGER.info("Schedule registration request received for: {}", scheduleVO);

        instructorScheduleService.addSchedule(scheduleVO);

        ResponseVO<Void> response = ResponseHelper.success("스케줄 등록 완료");

        return new ResponseEntity<>(response, response.getHttpStatus());
    }

    // 스케줄 수정 요청 처리
    @RequestMapping("/updateSchedule")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> updateSchedule(@RequestBody InstructorScheduleVO scheduleVO) throws Exception {
        LOGGER.info("===== Update Schedule Endpoint Reached =====");
        LOGGER.info("Schedule update request received for: {}", scheduleVO);

        instructorScheduleService.updateSchedule(scheduleVO);

        ResponseVO<Void> response = ResponseHelper.success("스케줄 수정 완료");

        return new ResponseEntity<>(response, response.getHttpStatus());
    }

    // 스케줄 삭제 요청 처리
    @RequestMapping("/deleteSchedule")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> deleteSchedule(@RequestBody InstructorScheduleVO scheduleVO) throws Exception {
        LOGGER.info("===== Delete Schedule Endpoint Reached =====");
        LOGGER.info("Schedule delete request received for: {}", scheduleVO);

        instructorScheduleService.deleteSchedule(scheduleVO);

        ResponseVO<Void> response = ResponseHelper.success("스케줄 삭제 완료");

        return new ResponseEntity<>(response, response.getHttpStatus());
    }


}
