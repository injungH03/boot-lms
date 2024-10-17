package com.atos.lms.business.company.service;

import com.atos.lms.business.company.model.CompanyDTO;
import com.atos.lms.business.company.model.CompanyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CompanyService {


    private final CompanyDAO companyDAO;

    @Autowired
    public CompanyService(CompanyDAO companyDAO) {
        this.companyDAO = companyDAO;
    }

    // 업체 목록 조회
    public Map<String, Object> selectCompanyList(CompanyVO companyVO) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("resultList", companyDAO.selectCompanyList(companyVO));
        resultMap.put("resultCnt", companyDAO.selectCompanyListCnt(companyVO));
        return resultMap;
    }

    // 업체 등록
    public void insertCompany(CompanyVO companyVO) {
        companyDAO.insertCompany(companyVO);
    }


    // 업체 정보 수정 메서드 추가
    public void updateCompany(CompanyVO companyVO) {
        companyDAO.updateCompany(companyVO);
    }


    // 사업자등록번호 중복 체크
    public boolean isBizRegNoDuplicate(CompanyVO companyVO) {
        int count = companyDAO.checkDuplicateBizRegNo(companyVO);
        return count > 0;
    }

    // 업체 상세 정보 조회
    public CompanyVO selectCompanyDetail(String bizRegNo) {
        CompanyVO companyVO = new CompanyVO();
        companyVO.setBizRegNo(bizRegNo);
        return companyDAO.selectCompanyDetail(companyVO);
    }

    // 업체 삭제 및 소속 회원 삭제
    public void deleteCompanyAndMembers(String bizRegNo) {
        CompanyVO companyVO = new CompanyVO();
        companyVO.setBizRegNo(bizRegNo);
        companyDAO.deleteCompany(companyVO);
        companyDAO.deleteMembersByCompany(companyVO);
    }



    // 업체 상태 업데이트
    public void updateStatus(String bizRegNos, String status) {
        List<String> corpBizList = Arrays.asList(bizRegNos.split(","));
        CompanyDTO companyDTO = new CompanyDTO();
        companyDTO.setCorpBizList(corpBizList);
        companyDTO.setStatus(status);
        companyDAO.updateStatus(companyDTO);
    }


/*

    // 엑셀 다운로드용 업체 목록 조회
    public void companyListExcelDown(HttpServletResponse response, CompanyVO companyVO) throws Exception {
        List<CompanyExcelDTO> companyList = companyDAO.companyListExcelDown(companyVO);
        Map<String, String> fieldToHeaderMap = new LinkedHashMap<>();
        fieldToHeaderMap.put("bizRegNo", "사업자등록번호");
        fieldToHeaderMap.put("corpName", "업체명");
        // 필요한 필드 매핑 추가
        ExcelUtil.exportToExcel(response, companyList, "업체목록", "업체목록엑셀파일", fieldToHeaderMap);
    }

*/

    // 상태 코드 목록 조회
    public List<CompanyVO> selectStatusCode() {
        return companyDAO.selectStatusCode();
    }

    // 업체 목록 조회
    public List<CompanyVO> selectCompany() {
        return companyDAO.selectCompany();
    }

}




