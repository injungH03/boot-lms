package com.atos.lms.business.company.controller;


import com.atos.lms.business.company.model.CompanyVO;
import com.atos.lms.business.company.service.CompanyService;
import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.utl.PaginationInfo;
import com.atos.lms.common.utl.ResponseHelper;
import com.atos.lms.common.utl.SortFieldValidator;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/company")
public class CompanyController {

    private static final Logger LOGGER = LoggerFactory.getLogger(CompanyController.class);

    private final CompanyService companyService;
    private final SortFieldValidator sortFieldValidator;

    @Autowired
    public CompanyController(CompanyService companyService, SortFieldValidator sortFieldValidator) {
        this.companyService = companyService;
        this.sortFieldValidator = sortFieldValidator;
    }



  // 업체 목록 조회
    @GetMapping("/companyList")
    public String companyList(@ModelAttribute("companySearchVO") CompanyVO companyVO, ModelMap model) throws Exception {
        LOGGER.info("Entering companyList with search criteria: {}", companyVO);

        // 정렬 필드 및 순서 검증
        String validatedSortField = sortFieldValidator.validateSortField("ATOS_COMPANY", companyVO.getSortField());
        String validatedSortOrder = sortFieldValidator.validateSortOrder(companyVO.getSortOrder());
        companyVO.setSortField(validatedSortField);
        companyVO.setSortOrder(validatedSortOrder);

        // 페이징 처리
        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(companyVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(companyVO.getPageUnit());
        paginationInfo.setPageSize(companyVO.getPageSize());

        companyVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        companyVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> map = companyService.selectCompanyList(companyVO);
        int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));
        paginationInfo.setTotalRecordCount(totalcount);

        List<CompanyVO> statusList = companyService.selectStatusCode();
        List<CompanyVO> companyList = companyService.selectCompany();

        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("status", statusList);
        model.addAttribute("companyList", companyList);
        model.addAttribute("totalcount", totalcount);

        LOGGER.info("Exiting companyList with result count: {}", totalcount);
        return "atos/company/companyList";
    }

    // 등록 페이지 이동
    @GetMapping("/companyRegistView")
    public String companyRegistView(ModelMap model) throws Exception {
        LOGGER.info("Entering companyRegistView");
        List<CompanyVO> companyList = companyService.selectCompany();
        model.addAttribute("companyList", companyList);
        LOGGER.info("Exiting companyRegistView");
        return "atos/company/companyRegist";
    }

    // 업체 등록
    @PostMapping("/companyInsert")
    @ResponseBody
    public ResponseEntity<ResponseVO<Object>> companyInsert(@RequestBody CompanyVO companyVO) {
        LOGGER.info("Entering companyInsert with data: {}", companyVO);
        try {
            boolean isDuplicate = companyService.isBizRegNoDuplicate(companyVO);
            if (isDuplicate) {
                LOGGER.warn("Duplicate business registration number detected: {}", companyVO.getBizRegNo());
                return ResponseEntity.status(HttpStatus.CONFLICT).body(
                        ResponseHelper.error("DUPLICATE_BIZ_REG_NO", "이미 존재하는 사업자등록번호입니다.", HttpStatus.CONFLICT, null)
                );
            }

            companyService.insertCompany(companyVO);
            LOGGER.info("Company insertion successful for: {}", companyVO.getBizRegNo());
            return ResponseEntity.ok(
                    ResponseHelper.success("등록 완료")
            );

        } catch (Exception e) {
            LOGGER.error("Error occurred during company insertion", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                    ResponseHelper.error("INTERNAL_SERVER_ERROR", "서버 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage())
            );
        }
    }

    // 사업자등록번호 중복 체크
    @PostMapping("/checkDuplicateBizRegNo")
    @ResponseBody
    public ResponseEntity<ResponseVO<Map<String, Boolean>>> checkDuplicateBizRegNo(@RequestBody Map<String, String> request) {
        String bizRegNo = request.get("bizRegNo");
        LOGGER.info("Checking duplicate bizRegNo: {}", bizRegNo);

        CompanyVO companyVO = new CompanyVO();
        companyVO.setBizRegNo(bizRegNo);
        boolean isDuplicate = companyService.isBizRegNoDuplicate(companyVO);

        Map<String, Boolean> result = new HashMap<>();
        result.put("duplicate", isDuplicate);

        return ResponseEntity.ok(
                ResponseHelper.successWithResult("중복 체크 완료", result)
        );
    }

    // 업체 상세 조회
    @GetMapping("/companyDetail")
    public String companyDetail(@RequestParam("bizRegNo") String bizRegNo, ModelMap model) throws Exception {
        LOGGER.info("Entering companyDetail with bizRegNo: {}", bizRegNo);

        CompanyVO companyDetail = companyService.selectCompanyDetail(bizRegNo);
        model.addAttribute("company", companyDetail);

        LOGGER.info("Exiting companyDetail");
        return "atos/company/companyDetail";
    }

    // 수정 페이지 이동
    @GetMapping("/companyUpdateView")
    public String companyUpdateView(@RequestParam("bizRegNo") String bizRegNo, ModelMap model) throws Exception {
        LOGGER.info("Entering companyUpdateView with bizRegNo: {}", bizRegNo);

        CompanyVO companyDetail = companyService.selectCompanyDetail(bizRegNo);
        model.addAttribute("company", companyDetail);

        LOGGER.info("Exiting companyUpdateView");
        return "atos/company/companyUpdate";
    }

    // 업체 정보 수정
    @PostMapping("/companyUpdate")
    @ResponseBody
    public ResponseEntity<ResponseVO<Object>> companyUpdate(@RequestBody CompanyVO companyVO) {
        LOGGER.info("Received company update request for: {}", companyVO);
        try {
            companyService.updateCompany(companyVO);
            LOGGER.info("Company update successful for: {}", companyVO.getBizRegNo());
            return ResponseEntity.ok(
                    ResponseHelper.success("수정 완료")
            );
        } catch (Exception e) {
            LOGGER.error("Error during company update", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                    ResponseHelper.error("INTERNAL_SERVER_ERROR", "수정 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage())
            );
        }
    }

    // 업체 삭제
    @PostMapping("/deleteCompany")
    @ResponseBody
    public ResponseEntity<ResponseVO<Object>> deleteCompany(@RequestBody Map<String, String> request) {
        String bizRegNo = request.get("bizRegNo");
        LOGGER.info("Received delete request for bizRegNo: {}", bizRegNo);
        try {
            companyService.deleteCompanyAndMembers(bizRegNo);
            LOGGER.info("Company deletion successful for bizRegNo: {}", bizRegNo);
            return ResponseEntity.ok(
                    ResponseHelper.success("삭제 완료")
            );
        } catch (Exception e) {
            LOGGER.error("Error during company deletion", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                    ResponseHelper.error("INTERNAL_SERVER_ERROR", "삭제 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage())
            );
        }
    }

    // 업체 상태 변경
    @PostMapping("/updateStatus")
    @ResponseBody
    public ResponseEntity<ResponseVO<Object>> updateCompanyStatus(@RequestBody Map<String, String> request) {
        String bizRegNos = request.get("bizRegNos");
        String status = request.get("status");
        LOGGER.info("Received status update request for bizRegNos: {} with status: {}", bizRegNos, status);
        try {
            companyService.updateStatus(bizRegNos, status);
            LOGGER.info("Status update successful for bizRegNos: {}", bizRegNos);
            return ResponseEntity.ok(
                    ResponseHelper.success("상태 변경 완료")
            );
        } catch (Exception e) {
            LOGGER.error("Error during status update", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
                    ResponseHelper.error("INTERNAL_SERVER_ERROR", "상태 변경 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage())
            );
        }
    }

    /*
    // 엑셀 다운로드 요청 처리 (주석 해제 및 수정)
    @GetMapping("/company/companyListExcelDown")
    public void companyListExcelDown(CompanyVO companyVO, HttpServletResponse response) throws Exception {
        LOGGER.info("Received request for company list Excel download");
        companyService.companyListExcelDown(response, companyVO);
    }
    */



}
