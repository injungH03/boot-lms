package com.atos.lms.business.attendance.service;


import com.atos.lms.business.attendance.model.AllAttendanceExcelVO;
import com.atos.lms.business.attendance.model.AllAttendanceVO;
import com.atos.lms.common.utl.ExcelUtil;
import com.atos.lms.common.utl.SortFieldValidator;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class AllAttendanceService {

    private final AllAttendanceDAO allAttendanceDAO;
    private final SortFieldValidator sortFieldValidator;

    @Autowired
    public AllAttendanceService(AllAttendanceDAO allAttendanceDAO, SortFieldValidator sortFieldValidator) {
        this.allAttendanceDAO = allAttendanceDAO;
        this.sortFieldValidator = sortFieldValidator;
    }

    // 출석 목록 조회
    @Transactional
    public Map<String, Object> selectAttendanceList(AllAttendanceVO attendanceVO) {
        // 정렬 필드 검증 및 설정
        String validatedSortField = sortFieldValidator.validateSortField("attendance", attendanceVO.getSortField());
        String validatedSortOrder = sortFieldValidator.validateSortOrder(attendanceVO.getSortOrder());

        attendanceVO.setSortField(validatedSortField);
        attendanceVO.setSortOrder(validatedSortOrder);

        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("resultList", allAttendanceDAO.selectAttendanceList(attendanceVO));
        resultMap.put("resultCnt", allAttendanceDAO.selectAttendanceListCnt(attendanceVO));
        return resultMap;
    }

    // 교육 목록 조회
    @Transactional
    public List<AllAttendanceVO> selectEducationList() {
        return allAttendanceDAO.selectEducationList();
    }

    @Transactional
    public void updateCheckIn(Map<String, Object> paramMap) {
        allAttendanceDAO.updateCheckIn(paramMap);
    }

    @Transactional
    public void updateCheckOut(Map<String, Object> paramMap) {
        allAttendanceDAO.updateCheckOut(paramMap);
    }

    @Transactional
    public AllAttendanceVO selectAttendanceByCode(int attendCode) {
        return allAttendanceDAO.selectAttendanceByCode(attendCode);
    }

    @Transactional
    public void updateCheckInAll(Map<String, Object> paramMap) {
        allAttendanceDAO.updateCheckInAll(paramMap);
    }

    @Transactional
    public void updateCheckOutAll(Map<String, Object> paramMap) {
        allAttendanceDAO.updateCheckOutAll(paramMap);
    }

    @Transactional
    public void updateAllAbsence(List<Integer> attendCodes) {
        allAttendanceDAO.updateAllAbsence(attendCodes);
    }

    // 엑셀 다운로드
    public void attendanceListExcelDown(HttpServletResponse response, AllAttendanceVO attendanceVO) throws Exception {
        List<AllAttendanceExcelVO> list = allAttendanceDAO.selectAttendanceExcelList(attendanceVO);

        Map<String, String> fieldToHeaderMap = new HashMap<>();
        fieldToHeaderMap.put("No", "No");  // 번호 컬럼 추가
        fieldToHeaderMap.put("corpName", "소속");
        fieldToHeaderMap.put("title", "과정명");
        fieldToHeaderMap.put("lectureTitle", "강의 제목");
        fieldToHeaderMap.put("memberId", "수강생 ID");
        fieldToHeaderMap.put("name", "수강생 이름");
        fieldToHeaderMap.put("status", "출석 상태");
        fieldToHeaderMap.put("attendDate", "출석일");
        fieldToHeaderMap.put("inTime", "입실시간");
        fieldToHeaderMap.put("outTime", "퇴실시간");
        fieldToHeaderMap.put("learnStatus", "강의 상태");

        ExcelUtil.exportToExcel(response, list, "출석부", "출석 목록", fieldToHeaderMap);
    }


}
