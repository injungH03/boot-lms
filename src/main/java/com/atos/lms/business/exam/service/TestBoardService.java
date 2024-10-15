package com.atos.lms.business.exam.service;

import com.atos.lms.business.exam.model.TestBoardVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

@Service
public class TestBoardService {

    private final TestBoardDAO testBoardDao;

    @Autowired
    public TestBoardService(TestBoardDAO testBoardDao) {
        this.testBoardDao = testBoardDao;
    }

    public Map<String, Object> selectBoardList(TestBoardVO testBoardVO) {
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("resultList", testBoardDao.selectBoardList(testBoardVO));
        map.put("resultCnt", testBoardDao.selectBoardListCnt(testBoardVO));

        return map;
    }

    public void insert(TestBoardVO testBoardVO) {
        testBoardDao.insertBoard(testBoardVO);
    }

    public TestBoardVO selectBoardKey(TestBoardVO testBoardVO) {
        return testBoardDao.selectBoardKey(testBoardVO);
    }

    public void update(TestBoardVO testBoardVO) {
        testBoardDao.updateBoard(testBoardVO);
    }


}
