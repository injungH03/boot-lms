package com.atos.lms.business.company.service;

import com.atos.lms.business.company.model.CompanyDTO;
import com.atos.lms.business.company.model.CompanyVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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

    public Map<String, Object> selectCompanyList(CompanyVO companyVO) {
        Map<String, Object> resultMap = new HashMap<>();
        resultMap.put("resultList", companyDAO.selectCompanyList(companyVO));
        resultMap.put("resultCnt", companyDAO.selectCompanyListCnt(companyVO));
        return resultMap;
    }

    public void insertCompany(CompanyVO companyVO) {
        companyDAO.insertCompany(companyVO);
    }

    public boolean isBizRegNoDuplicate(String bizRegNo) {
        return companyDAO.checkDuplicateBizRegNo(bizRegNo) > 0;
    }

    public CompanyVO selectCompanyDetail(String bizRegNo) {
        return companyDAO.selectCompanyDetail(bizRegNo);
    }

    public void updateCompany(CompanyVO companyVO) {
        companyDAO.updateCompany(companyVO);
    }

    public void deleteCompanyAndMembers(String bizRegNo) {
        companyDAO.deleteCompany(bizRegNo);
        companyDAO.deleteMembersByCompany(bizRegNo);
    }

    public void updateStatus(String bizRegNo, String status) {
        CompanyVO companyVO = new CompanyVO();
        companyVO.setBizRegNo(bizRegNo);
        companyVO.setStatus(status);
        companyDAO.updateStatus(companyVO);
    }
/*

    public void companyListExcelDown(HttpServletResponse response, CompanyVO companyVO) throws Exception {
        List<CompanyExcelDTO> companyList = companyDAO.companyListExcelDown(companyVO);
        Map<String, String> fieldToHeaderMap = new LinkedHashMap<>();
        fieldToHeaderMap.put("bizRegNo", "사업자등록번호");
        fieldToHeaderMap.put("corpName", "업체명");
        // 필드 매핑 설정 계속...
        ExcelUtil.exportToExcel(response, companyList, "업체목록", "업체목록엑셀파일", fieldToHeaderMap);
    }

*/

       public List<CompanyDTO> selectStatusCode() {
        return companyDAO.selectStatusCode();
    }

    public List<CompanyDTO> selectCompany() {
        return companyDAO.selectCompany();
    }

}




