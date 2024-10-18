package com.atos.lms.business.education.service;

import com.atos.lms.business.education.model.EducationExcelDTO;
import com.atos.lms.business.education.model.EducationMasterVO;
import com.atos.lms.business.education.model.EducationVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface EducationDAO {



    // 교육 과정 리스트 조회
    List<EducationVO> selectEducationList(EducationVO educationVO);

    // 교육 과정 총 개수 조회
    int selectEducationListCnt(EducationVO educationVO);

    // 상태 코드 조회
    List<EducationMasterVO> selectStatusCode();

    // 상태 업데이트
    void updateStatus(EducationMasterVO educationMasterVO);

    // 교육 과정 등록
    void insertEducation(EducationVO educationVO);

    // 카테고리 리스트 조회
    List<EducationVO> selectAllCategoryList();

    // 수료 조건 조회
    List<EducationMasterVO> selectCompletionCriteria();

    // 엑셀 다운로드용 교육 과정 리스트 조회
    List<EducationExcelDTO> selectEducationListForExcel(EducationVO educationVO);

    // 교육 과정 상세 조회
    EducationVO selectEducationDetail(EducationVO educationVO);

    // 교육 과정 업데이트
    void updateEducation(EducationVO educationVO);

    // 교육 상태 '삭제'로 변경
    void deleteEducationByEduCode(EducationVO educationVO);

    // 강의 상태 '폐강'으로 변경
    void deleteLecturesByEduCode(EducationVO educationVO);


}
