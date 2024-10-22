package com.atos.lms.business.education.controller;


import com.atos.lms.business.education.model.EducationMasterVO;
import com.atos.lms.business.education.model.EducationVO;
import com.atos.lms.business.education.service.EducationService;
import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.utl.PaginationInfo;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/education")
public class EducationController {

     private static final Logger LOGGER = LoggerFactory.getLogger(EducationController.class);

     private final EducationService educationService;

    @Autowired
    public EducationController(EducationService educationService) {
        this.educationService = educationService;
    }

 @RequestMapping("/educationList")
    public String educationList(@ModelAttribute("educationSearchVO") EducationVO educationVO, ModelMap model) throws Exception {

        PaginationInfo paginationInfo = new PaginationInfo();
        paginationInfo.setCurrentPageNo(educationVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(educationVO.getPageUnit());
        paginationInfo.setPageSize(educationVO.getPageSize());

        educationVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        educationVO.setLastIndex(paginationInfo.getLastRecordIndex());
        educationVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> map = educationService.selectEducationList(educationVO);
        int totalCount = Integer.parseInt(String.valueOf(map.get("resultCnt")));
        paginationInfo.setTotalRecordCount(totalCount);

        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("status", educationService.selectStatusCode());

        return "atos/education/educationList";
    }

    @RequestMapping("/updateStatus")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> updateStatus(@RequestBody EducationMasterVO educationMasterVO) throws Exception {
        // Service로 VO 전달하여 처리
        educationService.updateStatus(educationMasterVO);

        ResponseVO<Void> response = ResponseVO.<Void>builder()
                                  .httpStatus(HttpStatus.OK)
                                  .message("상태 변경 완료")
                                  .build();

        return new ResponseEntity<>(response, response.getHttpStatus());
    }

    @RequestMapping("/educationRegistView")
    public String educationRegistView(@ModelAttribute("educationSearchVO") EducationVO educationVO, ModelMap model) throws Exception {

        List<EducationVO> categories = educationService.selectAllCategoryList();
        List<EducationMasterVO> completionCriteria = educationService.selectCompletionCriteria();

        model.addAttribute("categories", categories);
        model.addAttribute("completionCriteria", completionCriteria);

        return "atos/education/educationRegist";
    }

    @RequestMapping("/educationInsert")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> educationInsert(@RequestBody EducationVO educationVO) {
        try {
            educationService.insertEducation(educationVO);
            ResponseVO<Void> response = ResponseVO.<Void>builder()
                                      .httpStatus(HttpStatus.OK)
                                      .message("교육 과정이 성공적으로 등록되었습니다.")
                                      .status(true)
                                      .build();
            return new ResponseEntity<>(response, response.getHttpStatus());
        } catch (Exception e) {
            LOGGER.error("교육 과정 등록 중 오류 발생", e);
            ResponseVO<Void> response = ResponseVO.<Void>builder()
                                      .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                                      .message("교육 과정 등록 중 오류가 발생했습니다.")
                                      .status(false)
                                      .build();
            return new ResponseEntity<>(response, response.getHttpStatus());
        }
    }

    @RequestMapping("/educationListExcelDown")
    public void educationListExcelDown(HttpServletResponse response, @ModelAttribute("educationSearchVO") EducationVO educationVO) throws Exception {
        educationService.educationListExcelDown(response, educationVO);
    }

    @RequestMapping("/educationDetail")
    public String educationDetail(@ModelAttribute("educationSearchVO") EducationVO educationVO, ModelMap model) throws Exception {
        EducationVO educationDetail = educationService.selectEducationDetail(educationVO);

        if (educationDetail == null) {
            LOGGER.warn("해당 eduCode로 조회된 데이터가 없습니다: {}", educationVO.getEduCode());
        } else {
            LOGGER.info("조회된 데이터: {}", educationDetail.toString());
        }

        model.addAttribute("educationDetail", educationDetail);
        return "atos/education/educationDetail";
    }

    @RequestMapping("/educationUpdateView")
    public String educationUpdateView(@ModelAttribute("educationSearchVO") EducationVO educationVO, ModelMap model) throws Exception {
        EducationVO educationDetail = educationService.selectEducationDetail(educationVO);

        model.addAttribute("educationDetail", educationDetail);
        model.addAttribute("categories", educationService.selectAllCategoryList());
        model.addAttribute("completionCriteria", educationService.selectCompletionCriteria());

        return "atos/education/educationUpdate";
    }

    @RequestMapping("/educationUpdate")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> educationUpdate(@RequestBody EducationVO educationVO) {
        try {
            // 수정 로직
            educationService.updateEducation(educationVO);

            // 성공 응답
            ResponseVO<Void> response = ResponseVO.<Void>builder()
                    .httpStatus(HttpStatus.OK)
                    .message("교육 과정이 성공적으로 수정되었습니다.")
                    .status(true)  // 성공 상태 추가
                    .build();
            return new ResponseEntity<>(response, response.getHttpStatus());
        } catch (Exception e) {
            // 오류 발생 시 로그 출력
            LOGGER.error("교육 과정 수정 중 오류 발생", e);

            // 실패 응답
            ResponseVO<Void> response = ResponseVO.<Void>builder()
                    .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                    .message("수정 중 오류가 발생했습니다.")
                    .status(false)  // 실패 상태 추가
                    .build();
            return new ResponseEntity<>(response, response.getHttpStatus());
        }
    }

    @RequestMapping("/deleteEducation")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> deleteEducation(@RequestBody EducationVO educationVO) {
        try {
            educationService.deleteEducation(educationVO);
            ResponseVO<Void> response = ResponseVO.<Void>builder()
                                      .httpStatus(HttpStatus.OK)
                                      .message("교육 과정과 관련된 강의가 성공적으로 삭제되었습니다.")
                                      .build();
            return new ResponseEntity<>(response, response.getHttpStatus());
        } catch (Exception e) {
            LOGGER.error("교육 과정 삭제 중 오류 발생", e);
            ResponseVO<Void> response = ResponseVO.<Void>builder()
                                      .httpStatus(HttpStatus.INTERNAL_SERVER_ERROR)
                                      .message("교육 과정 삭제 중 오류가 발생했습니다.")
                                      .build();
            return new ResponseEntity<>(response, response.getHttpStatus());
        }
    }



}
