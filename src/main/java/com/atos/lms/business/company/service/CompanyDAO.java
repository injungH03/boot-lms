package com.atos.lms.business.company.service;

import com.atos.lms.business.company.model.CompanyDTO;
import com.atos.lms.business.company.model.CompanyExcelDTO;
import com.atos.lms.business.company.model.CompanyVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface CompanyDAO {

    List<CompanyVO> selectCompanyList(CompanyVO companyVO);

    int selectCompanyListCnt(CompanyVO companyVO);

    void insertCompany(CompanyVO companyVO);

    int checkDuplicateBizRegNo(String bizRegNo);

    CompanyVO selectCompanyDetail(String bizRegNo);

    void updateCompany(CompanyVO companyVO);

    void deleteCompany(String bizRegNo);

    void deleteMembersByCompany(String bizRegNo);

    void updateStatus(CompanyVO companyVO);

    List<CompanyExcelDTO> companyListExcelDown(CompanyVO companyVO);

    List<CompanyDTO > selectStatusCode();

    List<CompanyDTO> selectCompany();


}
