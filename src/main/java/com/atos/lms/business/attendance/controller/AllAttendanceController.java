package com.atos.lms.business.attendance.controller;


import com.atos.lms.business.attendance.model.AllAttendanceVO;
import com.atos.lms.business.attendance.service.AllAttendanceService;
import com.atos.lms.common.utl.PaginationInfo;
import com.atos.lms.common.utl.ResponseHelper;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/education")
public class AllAttendanceController {

    private static final Logger LOGGER = LoggerFactory.getLogger(AllAttendanceController.class);

    private final AllAttendanceService allAttendanceService;

    @Autowired
    public AllAttendanceController(AllAttendanceService allAttendanceService) {
        this.allAttendanceService = allAttendanceService;
    }

    // 출석 목록 조회
    @RequestMapping("/allAttendanceList")
    public String allAttendanceList(@ModelAttribute("attendanceSearchVO") AllAttendanceVO attendanceVO, ModelMap model) throws Exception {
        LOGGER.info("allAttendanceList 접근");

        // 페이징 처리 설정
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(attendanceVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(attendanceVO.getPageUnit());
        paginationInfo.setPageSize(attendanceVO.getPageSize());

        attendanceVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        attendanceVO.setLastIndex(paginationInfo.getLastRecordIndex());
        attendanceVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        // 출석 목록 조회 및 교육 목록 조회
        Map<String, Object> map = allAttendanceService.selectAttendanceList(attendanceVO);
        List<AllAttendanceVO> educationList = allAttendanceService.selectEducationList();

        // 총 레코드 수 설정
        int totalCount = Integer.parseInt(String.valueOf(map.get("resultCnt")));
        paginationInfo.setTotalRecordCount(totalCount);

        // 모델에 데이터 추가
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("totalCount", totalCount);
        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("educationList", educationList);

        return "atos/attendance/allAttendanceList";  // JSP 경로
    }

    // 입실 처리
    @RequestMapping("/checkIn")
    @ResponseBody
    public ResponseEntity<?> checkIn(@RequestParam("attendCode") int attendCode) {
        LOGGER.info("입실 처리 시작 attendCode: " + attendCode);
        try {
            LocalTime inTime = LocalTime.now();
            LocalDate attendDate = LocalDate.now();

            // 입실 시간과 출석일 설정
            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("attendCode", attendCode);
            paramMap.put("inTime", inTime.format(DateTimeFormatter.ofPattern("HH:mm")));
            paramMap.put("attendDate", attendDate);

            // 입실 처리
            allAttendanceService.updateCheckIn(paramMap);
            return ResponseEntity.ok(ResponseHelper.successWithResult("입실 처리 완료", null));
        } catch (Exception e) {
            LOGGER.error("입실 처리 실패", e);
            return ResponseEntity.status(500).body(ResponseHelper.error("500", "입실 처리 실패", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage()));
        }
    }

    // 퇴실 처리
    @RequestMapping("/checkOut")
    @ResponseBody
    public ResponseEntity<?> checkOut(@RequestBody Map<String, Object> requestData) {
        try {
            List<Integer> attendCodes = (List<Integer>) requestData.get("attendCodes");
            LocalTime outTime = LocalTime.now();
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("HH:mm");

            for (Integer attendCode : attendCodes) {
                AllAttendanceVO attendanceVO = allAttendanceService.selectAttendanceByCode(attendCode);
                if (attendanceVO.getInTime() == null) {
                    return ResponseEntity.status(400).body(ResponseHelper.error("400", "입실 처리되지 않은 출석 코드", HttpStatus.BAD_REQUEST, null));
                }
            }

            Map<String, Object> paramMap = new HashMap<>();
            paramMap.put("attendCodes", attendCodes);
            paramMap.put("outTime", outTime.format(formatter));
            allAttendanceService.updateCheckOutAll(paramMap);

            return ResponseEntity.ok(ResponseHelper.successWithResult("퇴실 처리 완료", null));
        } catch (Exception e) {
            LOGGER.error("퇴실 처리 실패", e);
            return ResponseEntity.status(500).body(ResponseHelper.error("500", "퇴실 처리 실패", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage()));
        }
    }

    // 전체 입실 처리
    @RequestMapping("/checkInAll")
    @ResponseBody
    public ResponseEntity<?> checkInAll(@RequestBody Map<String, Object> requestData) {
        try {
            allAttendanceService.updateCheckInAll(requestData);
            return ResponseEntity.ok(ResponseHelper.successWithResult("전체 입실 처리 완료", null));
        } catch (Exception e) {
            LOGGER.error("전체 입실 처리 실패", e);
            return ResponseEntity.status(500).body(ResponseHelper.error("500", "전체 입실 처리 실패", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage()));
        }
    }

    // 전체 퇴실 처리
    @RequestMapping("/checkOutAll")
    @ResponseBody
    public ResponseEntity<?> checkOutAll(@RequestBody Map<String, Object> requestData) {
        try {
            allAttendanceService.updateCheckOutAll(requestData);
            return ResponseEntity.ok(ResponseHelper.successWithResult("전체 퇴실 처리 완료", null));
        } catch (Exception e) {
            LOGGER.error("전체 퇴실 처리 실패", e);
            return ResponseEntity.status(500).body(ResponseHelper.error("500", "전체 퇴실 처리 실패", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage()));
        }
    }

    // 결석 처리
    @RequestMapping("/allAbsence")
    @ResponseBody
    public ResponseEntity<?> markAbsent(@RequestBody Map<String, Object> requestData) {
        try {
            List<Integer> attendCodes = (List<Integer>) requestData.get("attendCodes");
            allAttendanceService.updateAllAbsence(attendCodes);
            return ResponseEntity.ok(ResponseHelper.successWithResult("결석 처리 완료", null));
        } catch (Exception e) {
            LOGGER.error("결석 처리 실패", e);
            return ResponseEntity.status(500).body(ResponseHelper.error("500", "결석 처리 실패", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage()));
        }
    }


    // 출석 목록 엑셀 다운로드
    @RequestMapping("/attendanceExcelDownload")
    public void attendanceExcelDownload(HttpServletResponse response, @ModelAttribute("attendanceSearchVO") AllAttendanceVO attendanceVO) throws Exception {
        allAttendanceService.attendanceListExcelDown(response, attendanceVO);
    }


}
