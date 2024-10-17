package com.atos.lms.business.company.service;

import com.atos.lms.business.company.model.CompanyDTO;
import com.atos.lms.business.company.model.CompanyExcelDTO;
import com.atos.lms.business.company.model.CompanyVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CompanyDAO {

  // 업체 목록 조회
    List<CompanyVO> selectCompanyList(CompanyVO companyVO);

    // 업체 총 개수 조회
    int selectCompanyListCnt(CompanyVO companyVO);

    // 업체 등록
    void insertCompany(CompanyVO companyVO);

    // 사업자등록번호 중복 체크 (파라미터 타입 변경)
    boolean checkDuplicateBizRegNo(CompanyVO companyVO);

    // 업체 상세 정보 조회 (파라미터 타입 변경)
    CompanyVO selectCompanyDetail(CompanyVO companyVO);

    // 업체 정보 수정
    void updateCompany(CompanyVO companyVO);

    // 업체 삭제
    void deleteCompany(CompanyVO companyVO);

    // 업체 소속 회원 삭제
    void deleteMembersByCompany(CompanyVO companyVO);

    // 업체 상태 업데이트
    void updateStatus(CompanyDTO companyDTO);

    // 엑셀 다운로드용 업체 목록 조회
    List<CompanyExcelDTO> companyListExcelDown(CompanyVO companyVO);

    // 상태 코드 목록 조회
    List<CompanyVO> selectStatusCode();

    // 업체 목록 조회
    List<CompanyVO> selectCompany();

}
