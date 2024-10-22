package com.atos.lms.business.lecture.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;


import com.atos.lms.business.lecture.model.*;
import com.atos.lms.business.lecture.service.LectureService;
import com.atos.lms.business.member.model.MemberVO;
import com.atos.lms.common.model.CategoryVO;
import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.service.CategoryService;
import com.atos.lms.common.utl.PaginationInfo;
import com.atos.lms.common.utl.ResponseHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;



@Controller
@RequestMapping("/admin/education")
public class LectureController {

	private static final Logger LOGGER = LoggerFactory.getLogger(LectureController.class);

    private final LectureService lectureService;
	private final CategoryService categoryservice;
    //    private FileUtil fileUtil;

    @Autowired
    public LectureController(LectureService lectureService, CategoryService categoryservice) {
        this.lectureService = lectureService;
        this.categoryservice = categoryservice;
    }




	@RequestMapping("/lectureList")
	public String lectureList(@ModelAttribute("searchVO") LectureVO lectureVO, ModelMap model) throws Exception {

		List<CategoryVO> categoryList = categoryservice.selectCodeMain(null);

		PaginationInfo paginationInfo = new PaginationInfo();

    	paginationInfo.setCurrentPageNo(lectureVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(lectureVO.getPageUnit());
    	paginationInfo.setPageSize(lectureVO.getPageSize());

    	lectureVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	lectureVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	lectureVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	Map<String, Object> map = lectureService.selectLecture(lectureVO);

    	int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));

    	paginationInfo.setTotalRecordCount(totalcount);


    	model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("totalcount", totalcount);
		model.addAttribute("resultList", map.get("resultList"));

		return "atos/lecture/lectureList";
	}

	@RequestMapping("/lectureRegist")
	public String lectureRegist(@ModelAttribute("searchVO") LectureVO lectureVO, ModelMap model) throws Exception {

		//첨부 파일 갯수
		lectureVO.setAtchPosblFileNumber(2);

		return "atos/lecture/lectureRegist";
	}

	@RequestMapping("/lectureDetail")
	public String lectureDetail(@ModelAttribute("searchVO") LectureVO lectureVO, ModelMap model) throws Exception {

		LectureVO lecture = lectureService.selectLectureKey(lectureVO);


		model.addAttribute("result", lecture);
		model.addAttribute("page", "lectureDetail");

		return "atos/lecture/lectureDetail";
	}

	@RequestMapping("/lectureUpdt")
	public String lectureUpdt(@ModelAttribute("searchVO") LectureVO lectureVO, ModelMap model) throws Exception {

		LectureVO lecture = lectureService.selectLectureKey(lectureVO);

		lectureVO.setAtchPosblFileNumber(2);

		//날짜 시간 포멧
		String recStartDate = (lecture.getRecStartDate() != null) ? lecture.getRecStartDate().substring(0, 10) : null;
		String recEndDate = (lecture.getRecEndDate() != null) ? lecture.getRecEndDate().substring(0, 10) : null;
		String startTime = (lecture.getStartTime() != null) ? lecture.getStartTime().substring(0, 5) : null;
		String endTime = (lecture.getEndTime() != null) ? lecture.getEndTime().substring(0, 5) : null;

		lecture.setRecStartDate(recStartDate);
		lecture.setRecEndDate(recEndDate);
		lecture.setStartTime(startTime);
		lecture.setEndTime(endTime);

		model.addAttribute("result", lecture);

		return "atos/lecture/lectureUpdt";
	}


	@RequestMapping("/lectureStudentList")
	public String lectureStudentList(@ModelAttribute("searchVO") LectureEnrollDTO lectureEnrollDTO, ModelMap model) throws Exception {

		LectureVO lecture = lectureService.selectLectureTitle(lectureEnrollDTO.getLectureCode());

		System.out.println(">>>>lecture " + lecture);

		PaginationInfo paginationInfo = new PaginationInfo();

    	paginationInfo.setCurrentPageNo(lectureEnrollDTO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(lectureEnrollDTO.getPageUnit());
    	paginationInfo.setPageSize(lectureEnrollDTO.getPageSize());

    	lectureEnrollDTO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	lectureEnrollDTO.setLastIndex(paginationInfo.getLastRecordIndex());
    	lectureEnrollDTO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	Map<String, Object> map = lectureService.selectEnrollList(lectureEnrollDTO);



    	int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));

    	paginationInfo.setTotalRecordCount(totalcount);


    	model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalcount", totalcount);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("result", lecture);
		model.addAttribute("capacity", map.get("capacity"));
		model.addAttribute("page", "lectureStudentList");

		return "atos/lecture/lectureStudentList";
	}

	@RequestMapping("/lectureAttendance")
	public String attendanceInfo(@ModelAttribute("searchVO")LectureAttendDTO lectureAttendDTO, ModelMap model) throws Exception {

		LectureVO lecture = lectureService.selectLectureTitle(lectureAttendDTO.getLectureCode());

		PaginationInfo paginationInfo = new PaginationInfo();

		paginationInfo.setCurrentPageNo(lectureAttendDTO.getPageIndex());
		paginationInfo.setRecordCountPerPage(lectureAttendDTO.getPageUnit());
		paginationInfo.setPageSize(lectureAttendDTO.getPageSize());

		lectureAttendDTO.setFirstIndex(paginationInfo.getFirstRecordIndex());
		lectureAttendDTO.setLastIndex(paginationInfo.getLastRecordIndex());
		lectureAttendDTO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

		Map<String, Object> map = lectureService.selectAttendList(lectureAttendDTO);

		int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));

		paginationInfo.setTotalRecordCount(totalcount);

		model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("totalcount", totalcount);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("result", lecture);
		model.addAttribute("page", "lectureAttendance");

		return "atos/lecture/lectureAttendance";
	}




	@RequestMapping("/educationPopup")
	public String educationPopup(@ModelAttribute("searchVO") LectureVO lectureVO, ModelMap model) throws Exception {

		List<CategoryVO> categoryList = categoryservice.selectCodeMain(null);


		PaginationInfo paginationInfo = new PaginationInfo();

    	paginationInfo.setCurrentPageNo(lectureVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(lectureVO.getPageUnit());
    	paginationInfo.setPageSize(lectureVO.getPageSize());

    	lectureVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	lectureVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	lectureVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	Map<String, Object> map = lectureService.selectEducation(lectureVO);

    	int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));

    	paginationInfo.setTotalRecordCount(totalcount);

    	model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("categoryList", categoryList);
		model.addAttribute("resultList", map.get("resultList"));

		return "atos/lecture/popupEducation";
	}

	@RequestMapping("/instructorPopup")
	public String instructorPopup(@ModelAttribute("searchVO") LectureInsDTO lectureInsDTO, ModelMap model) throws Exception {

    	Map<String, Object> map = lectureService.selectInstructor(lectureInsDTO);


		model.addAttribute("resultList", map.get("resultList"));

		return "atos/lecture/popupInstructor";
	}

	@RequestMapping("/studentListPopup")
	public String studentListPopup(@ModelAttribute("searchVO") LectureMemDTO lectureMemDTO, ModelMap model) throws Exception {

		PaginationInfo paginationInfo = new PaginationInfo();

    	paginationInfo.setCurrentPageNo(lectureMemDTO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(lectureMemDTO.getPageUnit());
    	paginationInfo.setPageSize(lectureMemDTO.getPageSize());

    	lectureMemDTO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	lectureMemDTO.setLastIndex(paginationInfo.getLastRecordIndex());
    	lectureMemDTO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

    	Map<String, Object> map = lectureService.selectStudentList(lectureMemDTO);

    	int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));

    	paginationInfo.setTotalRecordCount(totalcount);

    	model.addAttribute("paginationInfo", paginationInfo);
		model.addAttribute("resultList", map.get("resultList"));
		model.addAttribute("biz", map.get("biz"));
		model.addAttribute("totalCount", totalcount);

		return "atos/lecture/popupStudentList";
	}

	@RequestMapping("/studentDetailPopup")
	public String studentDetailPopup(ModelMap model) throws Exception {


		return "atos/lecture/popupStudentDetail";
	}

	@RequestMapping("/studentLecturePopup")
	public String studentLecturePopup(ModelMap model) throws Exception {


		return "atos/lecture/popupStudentLecture";
	}

	@RequestMapping("/instructorPopupSave")
	@ResponseBody
	public ResponseEntity<ResponseVO<Void>> instructorPopupSave(@RequestBody LectureInsDTO lectureInsDTO) throws Exception {

		System.out.println(">>>>>데이터 = " + lectureInsDTO);

		String message = lectureService.saveInstructor(lectureInsDTO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
	}

	@RequestMapping("/deleteLecture")
	@ResponseBody
	public ResponseEntity<ResponseVO<Void>> deleteLecture(@RequestBody LectureVO lectureVO) throws Exception {

		String message = lectureService.deleteLecture(lectureVO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
	}

	@RequestMapping("/deleteStudent")
	@ResponseBody
	public ResponseEntity<ResponseVO<Void>> deleteStudent(@RequestBody LectureMemDTO lectureMemDTO) throws Exception {

		String message = lectureService.deleteStudent(lectureMemDTO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
	}

	@RequestMapping("/addStudent")
	@ResponseBody
	public ResponseEntity<ResponseVO<Void>> addStudent(@RequestBody LectureMemDTO lectureMemDTO) throws Exception {

		String message = lectureService.insertStudent(lectureMemDTO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
	}

	@RequestMapping("/attendTime")
	@ResponseBody
	public ResponseEntity<ResponseVO<LectureVO>> attendTime(@RequestBody LectureAttendDTO lectureAttendDTO) throws Exception {

		LectureVO lectureVO = lectureService.selectLectureAttendTime(lectureAttendDTO.getLectureCode());

		ResponseVO<LectureVO> response = ResponseHelper.successWithResult(lectureVO);

		return new ResponseEntity<>(response, response.getHttpStatus());
	}

	@RequestMapping("/attendSave")
	@ResponseBody
	public ResponseEntity<ResponseVO<Void>> attendSave(@RequestBody LectureAttendDTO lectureAttendDTO) throws Exception {

		String message = lectureService.attendSave(lectureAttendDTO);

		ResponseVO<Void> response = ResponseHelper.success(message);

		return new ResponseEntity<>(response, response.getHttpStatus());
	}

	@RequestMapping("/addSelectedStudents")
	@ResponseBody
	public ResponseEntity<ResponseVO<Void>> addSelectedStudents(@RequestBody LectureMemDTO lectureMemDTO) throws Exception {

		lectureMemDTO.getMemberIds().forEach(mem -> System.out.println("넘어온 셀렉트 데이터 = " + mem));

		String message = lectureService.insertSelectedStudents(lectureMemDTO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
	}

	@RequestMapping("/delSelectedStudents")
	@ResponseBody
	public ResponseEntity<ResponseVO<Void>> delSelectedStudents(@RequestBody LectureMemDTO lectureMemDTO) throws Exception {

		lectureMemDTO.getMemberIds().forEach(mem -> System.out.println("넘어온 셀렉트 데이터 = " + mem));

		String message = lectureService.deleteSelectedStudents(lectureMemDTO);

		ResponseVO<Void> response = ResponseHelper.success(message);

		return new ResponseEntity<>(response, response.getHttpStatus());
	}

	@RequestMapping(value = "/saveLecture", method = RequestMethod.POST)
	@ResponseBody
	public ResponseEntity<ResponseVO<Void>> saveLecture(final MultipartHttpServletRequest multiRequest, @ModelAttribute LectureVO lectureVO) {
        ResponseVO<Void> response = new ResponseVO<>();
        try {

	        LOGGER.info("폼데이터 = " + lectureVO);

	        final Map<String, MultipartFile> files = multiRequest.getFileMap();

//	        String atchFileId = fileUtil.handleFileProcessing(files, lectureVO.getAtchFileId(), "Lecture_");

//	        lectureVO.setAtchFileId(atchFileId);

	        String message = lectureService.saveLecture(lectureVO);

            response = ResponseHelper.success(message);
	    } catch (Exception e) {
	        LOGGER.error("파일 저장 중 오류 발생", e);
            response = ResponseHelper.error("파일 서버 에러", "파일 저장 중 오류가 발생했습니다.", HttpStatus.INTERNAL_SERVER_ERROR, e.getMessage());
	    }

        return new ResponseEntity<>(response, response.getHttpStatus());
	}

}



