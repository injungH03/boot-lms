package com.atos.lms.business.education.service;


import com.atos.lms.business.education.model.EducationExcelVO;
import com.atos.lms.business.education.model.EducationMasterVO;
import com.atos.lms.business.education.model.EducationVO;
import com.atos.lms.common.utl.ExcelUtil;
import com.atos.lms.common.utl.SortFieldValidator;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class EducationService {

    private final EducationDAO educationDAO;
    private final SortFieldValidator sortFieldValidator;  // 추가

    @Autowired
    public EducationService(EducationDAO educationDAO, SortFieldValidator sortFieldValidator) {
        this.educationDAO = educationDAO;
        this.sortFieldValidator = sortFieldValidator;  // 주입
    }

    // 교육 과정 목록 조회
    public Map<String, Object> selectEducationList(EducationVO educationVO) {
        // SQL 인젝션 방지 및 정렬 필드 검증
        String validatedSortField = sortFieldValidator.validateSortField("education", educationVO.getSortField());
        String validatedSortOrder = sortFieldValidator.validateSortOrder(educationVO.getSortOrder());

        // 검증된 값을 VO에 설정
        educationVO.setSortField(validatedSortField);
        educationVO.setSortOrder(validatedSortOrder);

        // DAO 호출 및 결과 반환
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("resultList", educationDAO.selectEducationList(educationVO));
        resultMap.put("resultCnt", educationDAO.selectEducationListCnt(educationVO));
        return resultMap;
    }

    // 상태 코드 조회
    public List<EducationMasterVO> selectStatusCode() {
        return educationDAO.selectStatusCode();
    }

    // 상태 업데이트
    public void updateStatus(EducationMasterVO educationMasterVO) {
        // 교육 과정 상태 업데이트
        educationDAO.updateStatus(educationMasterVO);

        // 상태가 '폐강(4002)'일 경우, 관련 강의도 '폐강'으로 상태 변경
        if ("4002".equals(educationMasterVO.getStatusCode())) {
            for (Integer eduCode : educationMasterVO.getEduCodeList()) {
                EducationVO educationVO = new EducationVO();
                educationVO.setEduCode(eduCode);
                educationVO.setStatus("4002"); // '폐강' 상태 코드
                educationDAO.deleteLecturesByEduCode(educationVO);
            }
        }
    }

    // 교육 과정 등록
    public void insertEducation(EducationVO educationVO) {
        educationVO.setStatus("4001"); // 기본 상태 설정
        educationDAO.insertEducation(educationVO);
    }

    // 수료 조건 조회
    public List<EducationMasterVO> selectCompletionCriteria() {
        return educationDAO.selectCompletionCriteria();
    }

    // 카테고리 리스트 조회
    public List<EducationVO> selectAllCategoryList() {
        return educationDAO.selectAllCategoryList();
    }

    // 엑셀 다운로드 처리
    public void educationListExcelDown(HttpServletResponse response, EducationVO educationVO) throws Exception {
        List<EducationExcelVO> educationList = educationDAO.selectEducationListForExcel(educationVO);

        // 엑셀 파일로 출력 (필드 매핑 포함)
        ExcelUtil.exportToExcel(response, educationList, "교육목록", "교육목록엑셀파일", Map.of(
                "title", "교육명",
                "category", "교육 분류",
                "description", "과정 소개",
                "objective", "과정 목표",
                "completionCriteria", "수료 조건",
                "note", "비고",
                "status", "상태",
                "trainingTime", "교육 시간",
                "regDate", "등록일",
                "register", "등록자"
        ));
    }

    // 교육 과정 상세 조회
    public EducationVO selectEducationDetail(EducationVO educationVO) {
        return educationDAO.selectEducationDetail(educationVO);
    }

    // 교육 과정 수정
    public void updateEducation(EducationVO educationVO) {
        educationDAO.updateEducation(educationVO);
    }

    // 교육 과정 삭제
    public void deleteEducation(EducationVO educationVO) {
        educationDAO.deleteEducationByEduCode(educationVO);
        educationDAO.deleteLecturesByEduCode(educationVO);
    }


}
