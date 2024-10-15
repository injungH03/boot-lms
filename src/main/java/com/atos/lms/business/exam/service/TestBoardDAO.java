package com.atos.lms.business.exam.service;

import com.atos.lms.business.exam.model.TestBoardVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface TestBoardDAO {

    List<TestBoardVO> selectBoardList(TestBoardVO testBoardVO);
    int selectBoardListCnt(TestBoardVO testBoardVO);
    TestBoardVO selectBoardKey(TestBoardVO testBoardVO);

    int insertBoard(TestBoardVO testBoardVO);
    int updateBoard(TestBoardVO testBoardVO);




}
