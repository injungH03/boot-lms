package com.atos.lms.business.exam.controller;

import com.atos.lms.common.utl.PaginationInfo;
import com.atos.lms.business.exam.model.TestBoardVO;
import com.atos.lms.business.exam.service.TestBoardService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.Map;

@Controller
@RequestMapping("/admin")
public class TestBoardController {

    private static final Logger LOGGER = LoggerFactory.getLogger(TestBoardController.class);

    private final TestBoardService testBoardService;

    @Autowired
    public TestBoardController(TestBoardService testBoardService) {
        this.testBoardService = testBoardService;
    }

    @RequestMapping("/member/boardList")
    public String boardList(@ModelAttribute("searchVO") TestBoardVO testBoardVO, ModelMap model) throws Exception {

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(testBoardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(testBoardVO.getPageUnit());
        paginationInfo.setPageSize(testBoardVO.getPageSize());

        System.out.println(">>>>>>>>>>>>getPageSize = " + paginationInfo.getPageSize());
        System.out.println(">>>>>>>>>>>>getRecordCountPerPage = " + paginationInfo.getRecordCountPerPage());
        System.out.println(">>>>>>>>>>>>testBoardVO.getPageIndex() = " + testBoardVO.getPageIndex());
        System.out.println(">>>>>>>>>>>>getCurrentPageNo = " + paginationInfo.getCurrentPageNo());

        testBoardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        testBoardVO.setLastIndex(paginationInfo.getLastRecordIndex());
        testBoardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        System.out.println(">>>>>>>>>>>>>>>>>getFirstIndex = " + testBoardVO.getFirstIndex());
        System.out.println(">>>>>>>>>>>>>>>>>getLastIndex = " + testBoardVO.getLastIndex());
        System.out.println(">>>>>>>>>>>>>>>>>getRecordCountPerPage = " + testBoardVO.getRecordCountPerPage());

        Map<String, Object> map = testBoardService.selectBoardList(testBoardVO);

        System.out.println("총갯수 = " + map.get("resultCnt"));


        int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));

        paginationInfo.setTotalRecordCount(totalcount);

        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("paginationInfo", paginationInfo);


        return "atos/board/TestBoardList";
    }

    @RequestMapping("/member/boardDetail")
    public String boardDetail(@ModelAttribute("searchVO") TestBoardVO boardVO, ModelMap model) throws Exception {
        TestBoardVO board = testBoardService.selectBoardKey(boardVO);

        System.out.println("결과값 = " + board);

        model.addAttribute("result", board);

        return "atos/board/TestBoardDetail";
    }

    @RequestMapping("/company/companyList")
    public String companyList(@ModelAttribute("searchVO") TestBoardVO testBoardVO, ModelMap model) throws Exception {

        PaginationInfo paginationInfo = new PaginationInfo();

        paginationInfo.setCurrentPageNo(testBoardVO.getPageIndex());
        paginationInfo.setRecordCountPerPage(testBoardVO.getPageUnit());
        paginationInfo.setPageSize(testBoardVO.getPageSize());

        System.out.println(">>>>>>>>>>>>getPageSize = " + paginationInfo.getPageSize());
        System.out.println(">>>>>>>>>>>>getRecordCountPerPage = " + paginationInfo.getRecordCountPerPage());
        System.out.println(">>>>>>>>>>>>testBoardVO.getPageIndex() = " + testBoardVO.getPageIndex());
        System.out.println(">>>>>>>>>>>>getCurrentPageNo = " + paginationInfo.getCurrentPageNo());

        testBoardVO.setFirstIndex(paginationInfo.getFirstRecordIndex());
        testBoardVO.setLastIndex(paginationInfo.getLastRecordIndex());
        testBoardVO.setRecordCountPerPage(paginationInfo.getRecordCountPerPage());

        System.out.println(">>>>>>>>>>>>>>>>>getFirstIndex = " + testBoardVO.getFirstIndex());
        System.out.println(">>>>>>>>>>>>>>>>>getLastIndex = " + testBoardVO.getLastIndex());
        System.out.println(">>>>>>>>>>>>>>>>>getRecordCountPerPage = " + testBoardVO.getRecordCountPerPage());

        Map<String, Object> map = testBoardService.selectBoardList(testBoardVO);

        System.out.println("총갯수 = " + map.get("resultCnt"));


        int totalcount = Integer.parseInt(String.valueOf(map.get("resultCnt")));

        paginationInfo.setTotalRecordCount(totalcount);

        model.addAttribute("resultList", map.get("resultList"));
        model.addAttribute("paginationInfo", paginationInfo);


        return "atos/board/TestBoardList";
    }



}
