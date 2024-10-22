package com.atos.lms.business.member.controller;

import com.atos.lms.business.company.model.CompanyVO;
import com.atos.lms.business.member.model.MemberAllDTO;
import com.atos.lms.business.member.model.MemberVO;
import com.atos.lms.business.member.service.MemberService;
import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.utl.PaginationInfo;
import com.atos.lms.common.utl.ResponseHelper;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


@Controller
@RequestMapping("/admin/member")
public class MemberController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(MemberController.class);
	
	
	private final MemberService memberService;

    public MemberController(MemberService memberService) {
        this.memberService = memberService;
    }


    @RequestMapping("/memberList")
    public String memberList(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {
    	
    	System.out.println("넘어온 스태이터스 코드값 = " + memberVO.getStatusCode());
    	
    	PaginationInfo paginationInfo = new PaginationInfo();
		
    	paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
    	paginationInfo.setRecordCountPerPage(memberVO.getPageUnit());
    	paginationInfo.setPageSize(memberVO.getPageSize());
    	
    	memberVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
    	memberVO.setLastIndex(paginationInfo.getLastRecordIndex());
    	memberVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());
    	
    	Map<String, Object> map = memberService.selectMemberList(memberVO);
    	

    	int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));
    	
    	paginationInfo.setTotalRecordCount(totalcount);
    	
    	
//    	List<MemberVO> list = (List<MemberVO>) map.get("resultList");
//    	
//    	list.forEach(mem -> {
//    		System.out.println(">>" + mem);
//    		System.out.println("상태이름 = " + mem.getListStatusName());
//    	});
//    	

    	List<MemberVO> status = memberService.selectStatusCode();
    	List<MemberVO> company = memberService.selectCompany();
    	
    	model.addAttribute("resultList", map.get("resultList"));
    	model.addAttribute("paginationInfo", paginationInfo);
    	model.addAttribute("status", status);
    	model.addAttribute("company", company);
    	model.addAttribute("totalcount", totalcount);

    	return "atos/member/memberList";
    }
    
    @RequestMapping("/memberRegistView")
    public String memberRegistView(@ModelAttribute("searchVO") MemberVO memberVO,  ModelMap model) throws Exception {
    	
    	List<MemberVO> company = memberService.selectCompany();
    	model.addAttribute("company", company);
    	
    	return "atos/member/memberRegist";
    }
    
    @RequestMapping("/memberDetail")
    public String memberDetail(@ModelAttribute("searchVO") MemberVO memberVO,  ModelMap model) throws Exception {
    	
//    	System.out.println("넘어온 데이터  = " + memberVO);
    	
    	model.addAttribute("member", memberService.selectMemberKey(memberVO));
    	
    	return "atos/member/memberDetail";
    }
    
    @RequestMapping("/memberUpdateView")
    public String memberUpdateView(@ModelAttribute("searchVO") MemberVO memberVO,  ModelMap model) throws Exception {
    	
//    	System.out.println("넘어온 데이터  = " + memberVO);
    	
    	model.addAttribute("company", memberService.selectCompany());
    	model.addAttribute("member", memberService.selectMemberKey(memberVO));
    	return "atos/member/memberUpdt";
    }
    
    @RequestMapping("/memberAllRegistView")
    public String memberAllRegistView(@ModelAttribute("searchVO") MemberVO memberVO,  ModelMap model) throws Exception {
    	
    	
    	
    	model.addAttribute("company", memberService.selectCompany());
    	
    	return "atos/member/memberAllRegist";
    }


    @RequestMapping("/instructorList")
    public String instructorList(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {

        System.out.println("넘어온 스태이터스 코드값 = " + memberVO.getStatusCode());

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(memberVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(memberVO.getPageUnit());
        paginationInfo.setPageSize(memberVO.getPageSize());

        memberVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        memberVO.setLastIndex(paginationInfo.getLastRecordIndex());
        memberVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        Map<String, Object> map = memberService.selectInstructorList(memberVO);


        int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));

        paginationInfo.setTotalRecordCount(totalcount);


//    	List<MemberVO> list = (List<MemberVO>) map.get("resultList");
//
//    	list.forEach(mem -> {
//    		System.out.println(">>" + mem);
//    		System.out.println("상태이름 = " + mem.getListStatusName());
//    	});
//

        List<MemberVO> status = memberService.selectStatusCode();

        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("paginationInfo", paginationInfo);
        model.addAttribute("status", status);
        model.addAttribute("totalcount", totalcount);

        return "atos/member/instructorList";
    }

    @RequestMapping("instructorRegistView")
    public String instructorRegistView(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {

        return "atos/member/instructorRegist";
    }

    @RequestMapping("instructorUpdateView")
    public String instructorUpdateView(@ModelAttribute("searchVO") MemberVO memberVO, ModelMap model) throws Exception {

        model.addAttribute("member", memberService.selectInstructorKey(memberVO));

        return "atos/member/instructorUpdt";
    }

    @RequestMapping("/instructorDetail")
    public String instructorDetail(@ModelAttribute("searchVO") MemberVO memberVO,  ModelMap model) throws Exception {

//    	System.out.println("넘어온 데이터  = " + memberVO);

        model.addAttribute("member", memberService.selectInstructorKey(memberVO));

        return "atos/member/instructorDetail";
    }

    @RequestMapping("/instructorListExcelDown")
    public void instructorListExcelDown(HttpServletResponse response, MemberVO memberVO) throws Exception {
        memberService.instructorListExcelDown(response, memberVO);
    }

    @RequestMapping("/saveInstructor")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> saveInstructor(@RequestBody MemberVO memberVO) throws Exception {

//    	System.out.println(">>>>입력값  =  " + memberVO.toString());

        String message = memberService.saveInstructor(memberVO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
    }


    @RequestMapping("/checkDuplicateId")
    @ResponseBody
    public Map<String, Object> checkDuplicateId(@RequestParam("id") String id) throws Exception {
        Map<String, Object> response = new HashMap<>();

        System.out.println("아이디 = " + id);

        boolean result = memberService.checkDuplicateId(id);
        System.out.println("결과값 = " + result);

        response.put("status", result);

        return response;
    }
    
    
    @RequestMapping("/memberDelete")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> memberDelete(@RequestBody MemberVO memberVO) throws Exception {
    	
    	String message = memberService.deleteMember(memberVO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
    }
    
    @RequestMapping("/updateStatus")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> updateStatus(@RequestBody MemberVO memberVO) throws Exception {
    	
    	String message = memberService.updateStatus(memberVO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
    }
    
    @RequestMapping("/companyDetail")
    @ResponseBody
    public ResponseEntity<ResponseVO<List<CompanyVO>>> companyDetail(
    		@RequestBody Map<String, String> data) throws Exception {
    	
//    	System.out.println("사업자번호 확인 = " + data.get("corpBiz"));
    	String corpBiz = data.get("corpBiz");
    	
    	CompanyVO companyVO = memberService.selectCompanyKey(corpBiz);
    	
//    	System.out.println("companyVO 값 = " + companyVO.toString());
    	List<CompanyVO> companyList = new ArrayList<CompanyVO>();
    	companyList.add(companyVO);

        ResponseVO<List<CompanyVO>> response = ResponseHelper.successWithResult(companyList);

        return new ResponseEntity<>(response, response.getHttpStatus());

    }

    @RequestMapping("/saveMember")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> saveMember(@RequestBody MemberVO memberVO) throws Exception {

//    	System.out.println(">>>>입력값  =  " + memberVO.toString());

        String message = memberService.saveMember(memberVO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
    }

    @RequestMapping("/memberAllSave")
    @ResponseBody
    public ResponseEntity<ResponseVO<Void>> memberAllSave(@RequestBody MemberAllDTO memberAllDTO) {
    	
    	System.out.println(">>>>넘어온데이터 = " + memberAllDTO.getCorpBiz());
    	System.out.println(">>>>리스트사이즈 = " + memberAllDTO.getPreviewData().size());

        String message = memberService.memberAllSave(memberAllDTO);

        ResponseVO<Void> response = ResponseHelper.success(message);

        return new ResponseEntity<>(response, response.getHttpStatus());
    }
    
    
    @RequestMapping("/uploadExcel")
    @ResponseBody
    public ResponseEntity<ResponseVO<List<MemberVO>>> uploadExcel(@RequestParam("file") MultipartFile file) throws Exception {

        List<MemberVO> memberList = memberService.uploadExcel(file);

        ResponseVO<List<MemberVO>> response = ResponseHelper.successWithResult(memberList);

        return new ResponseEntity<>(response, response.getHttpStatus());
            
    }
    
    @RequestMapping("/memberListExcelDown")
    public void memberListExcelDown(HttpServletResponse response, MemberVO memberVO) throws Exception {
    	System.out.println("엑셀 다운................ ");
    	memberService.memberListExcelDown(response, memberVO);
    	
    }
    
    @RequestMapping("/sampleExcelDown")
    public void sampleExcelDown(HttpServletResponse response, MemberVO memberVO) throws Exception {
    	
    	memberService.sampleExcelDown(response);
    }

}
