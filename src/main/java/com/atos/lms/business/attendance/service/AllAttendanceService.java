package com.atos.lms.business.attendance.service;


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
    @Transactional
    public void attendanceListExcelDown(HttpServletResponse response, AllAttendanceVO attendanceVO) throws Exception {
        // DAO를 통해 엑셀 다운로드에 필요한 출석 목록 데이터를 가져옵니다.
        List<AllAttendanceVO> attendanceList = allAttendanceDAO.selectAttendanceListForExcel(attendanceVO);

        // 필드 이름을 엑셀 헤더로 매핑하는 맵을 설정합니다.
        Map<String, String> fieldToHeaderMap = Map.of(
                "corpName", "법인명",
                "title", "교육 제목",
                "enrollID", "학생 아이디",
                "name", "학생 이름",
                "status", "상태",
                "attendDate", "출석 날짜",
                "inTime", "입실 시간",
                "outTime", "퇴실 시간"
        );

        // ExcelUtil을 사용하여 엑셀 파일을 생성하고 다운로드합니다.
        ExcelUtil.exportToExcel(response, attendanceList, "출석 목록", "attendance_list", fieldToHeaderMap);
    }
}
