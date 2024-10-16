package com.atos.lms.business.company.controller;


import com.atos.lms.business.company.model.CompanyDTO;
import com.atos.lms.business.company.model.CompanyVO;
import com.atos.lms.business.company.service.CompanyService;
import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.utl.PaginationInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;



import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin")
public class CompanyController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CompanyController.class);

    private final CompanyService companyService;

    @Autowired
    public CompanyController(CompanyService companyService) {
        this.companyService = companyService;
    }

    // 회사 목록 조회
    @RequestMapping("/company/companyList")
    public String companyList(@ModelAttribute("companySearchVO") CompanyVO companyVO, ModelMap model) throws Exception {
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(companyVO.getPageUnit());
        paginationInfo.setPageSize(companyVO.getPageSize());

        companyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        companyVO.setLastIndex(paginationInfo.getLastRecordIndex());
        companyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> map = companyService.selectCompanyList(companyVO);
        int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));
        paginationInfo.setTotalRecordCount(totalcount);

        List<CompanyDTO> status = companyService.selectStatusCode();
        List<CompanyDTO> company = companyService.selectCompany();

        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("status", status);
        model.addAttribute("company", company);

        return "company/companyList";
    }

    // 등록 페이지 이동
    @RequestMapping("/company/CompanyRegistView")
    public String companyRegistView(@ModelAttribute("companySearchVO") CompanyVO companyVO, ModelMap model) throws Exception {
        List<CompanyDTO> company = companyService.selectCompany();
        model.addAttribute("company", company);
        return "company/companyRegist";
    }

    // 회사 등록
    @RequestMapping("/company/companyInsert")
    @ResponseBody
    public ResponseEntity<ResponseVO> companyInsert(@RequestBody CompanyVO companyVO) {
        LOGGER.info("Entering companyInsert method with data: {}", companyVO);
        try {
            if (companyService.isBizRegNoDuplicate(companyVO.getBizRegNo())) {
                LOGGER.warn("Duplicate business registration number detected: {}", companyVO.getBizRegNo());
                ResponseVO responseVO = ResponseVO.builder()
                        .httpStatus(HttpStatus.CONFLICT)
                        .message("이미 존재하는 사업자등록번호입니다.")
                        .status(false)
                        .build();
                return ResponseEntity.status(responseVO.getHttpStatus()).body(responseVO);
            }

            companyService.insertCompany(companyVO);
            LOGGER.info("Company insertion successful for: {}", companyVO.getBizRegNo());
            ResponseVO responseVO = ResponseVO.builder()
                    .httpStatus(HttpStatus.OK)
                    .message("등록 완료")
                    .status(true)
                    .build();
            return ResponseEntity.status(responseVO.getHttpStatus()).body(responseVO);

        } catch (Exception e) {
            LOGGER.error("Error occurred during company insertion", e);
            ResponseVO responseVO = ResponseVO.builder()
                    .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                    .message("서버 오류가 발생했습니다.")
                    .status(false)
                    .build();
            return ResponseEntity.status(responseVO.getHttpStatus()).body(responseVO);
        }
    }

    // 사업자등록번호 중복 체크
    @RequestMapping("/company/checkDuplicateBizRegNo")
    @ResponseBody
    public ResponseEntity<Map<String, Boolean>> checkDuplicateBizRegNo(@RequestBody Map<String, String> request) {
        String bizRegNo = request.get("bizRegNo");
        boolean isDuplicate = companyService.isBizRegNoDuplicate(bizRegNo);

        Map<String, Boolean> response = new HashMap<>();
        response.put("duplicate", isDuplicate);

        return ResponseEntity.ok(response);
    }

    // 회사 상세 조회
    @RequestMapping("/company/companyDetail")
    public String companyDetail(@ModelAttribute("companySearchVO") CompanyVO companyVO, ModelMap model) throws Exception {
        CompanyVO companyDetail = companyService.selectCompanyDetail(companyVO.getBizRegNo());
        model.addAttribute("company", companyDetail);
        return "company/companyDetail";
    }

    // 수정 페이지 이동
    @RequestMapping("/company/companyUpdateView")
    public String companyUpdateView(@ModelAttribute("companySearchVO") CompanyVO companyVO, ModelMap model) throws Exception {
        CompanyVO companyDetail = companyService.selectCompanyDetail(companyVO.getBizRegNo());
        model.addAttribute("company", companyDetail);
        return "company/companyUpdate";
    }

    // 회사 정보 수정
    @RequestMapping("/company/companyUpdate")
    @ResponseBody
    public ResponseEntity<ResponseVO> companyUpdate(@RequestBody CompanyVO companyVO) {
        LOGGER.info("Received company update request for: {}", companyVO);
        try {
            companyService.updateCompany(companyVO);
            ResponseVO responseVO = ResponseVO.builder()
                    .httpStatus(HttpStatus.OK)
                    .message("수정 완료")
                    .status(true)
                    .build();
            LOGGER.info("Company update successful for: {}", companyVO.getBizRegNo());
            return ResponseEntity.status(responseVO.getHttpStatus()).body(responseVO);
        } catch (Exception e) {
            LOGGER.error("Error during company update", e);
            ResponseVO responseVO = ResponseVO.builder()
                    .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                    .message("수정 중 오류가 발생했습니다.")
                    .status(false)
                    .build();
            return ResponseEntity.status(responseVO.getHttpStatus()).body(responseVO);
        }
    }

    // 회사 삭제
    @RequestMapping("/company/deleteCompany")
    @ResponseBody
    public ResponseEntity<ResponseVO> deleteCompany(@RequestBody CompanyVO companyVO) {
        try {
            companyService.deleteCompanyAndMembers(companyVO.getBizRegNo());
            ResponseVO responseVO = ResponseVO.builder()
                    .httpStatus(HttpStatus.OK)
                    .message("삭제 완료")
                    .status(true)
                    .build();
            return ResponseEntity.ok(responseVO);
        } catch (Exception e) {
            LOGGER.error("Error during company deletion", e);
            ResponseVO responseVO = ResponseVO.builder()
                    .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                    .message("삭제 중 오류가 발생했습니다.")
                    .status(false)
                    .build();
            return ResponseEntity.status(responseVO.getHttpStatus()).body(responseVO);
        }
    }

    // 회사 상태 변경
    @RequestMapping("/company/updateStatus")
    @ResponseBody
    public ResponseEntity<ResponseVO> updateCompanyStatus(@RequestBody CompanyVO companyVO) {
        try {
            companyService.updateStatus(companyVO.getBizRegNo(), companyVO.getStatus());
            ResponseVO responseVO = ResponseVO.builder()
                    .httpStatus(HttpStatus.OK)
                    .message("상태 변경 완료")
                    .status(true)
                    .build();
            return ResponseEntity.ok(responseVO);
        } catch (Exception e) {
            LOGGER.error("Error during status update", e);
            ResponseVO responseVO = ResponseVO.builder()
                    .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                    .message("상태 변경 중 오류가 발생했습니다.")
                    .status(false)
                    .build();
            return ResponseEntity.status(responseVO.getHttpStatus()).body(responseVO);
        }
    }
/*

    // 엑셀 다운로드 요청 처리
    @RequestMapping("/company/companyListExcelDown")
    public void companyListExcelDown(HttpServletResponse response, CompanyVO companyVO) throws Exception {
        companyService.companyListExcelDown(response, companyVO);
    }

*/

}
