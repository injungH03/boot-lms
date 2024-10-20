package com.atos.lms.business.lecture.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.atos.lms.business.lecture.model.LectureEnrollDTO;
import com.atos.lms.business.lecture.model.LectureInsDTO;
import com.atos.lms.business.lecture.model.LectureMemDTO;
import com.atos.lms.business.lecture.model.LectureVO;
import com.atos.lms.common.utl.SortFieldValidator;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service
public class LectureService  {

	private final LectureDAO lectureDao;
    private final SortFieldValidator sortFieldValidator;

    @Autowired
    public LectureService(LectureDAO lectureDao, SortFieldValidator sortFieldValidator) {
        this.lectureDao = lectureDao;
        this.sortFieldValidator = sortFieldValidator;
    }

	@Transactional
    public Map<String, Object> selectLecture(LectureVO lectureVO) {
		Map<String, Object> map = new HashMap<String, Object>();

		System.out.println("넘어온 정렬 필드 = " + lectureVO.getSortField());
		System.out.println("넘어온 정렬 조건 = " + lectureVO.getSortOrder());

		// SQL인젝션방지
		String validateField = sortFieldValidator.validateSortField("lecture", lectureVO.getSortField());
		String validateOrder = sortFieldValidator.validateSortOrder(lectureVO.getSortOrder());

		System.out.println("정렬 필드 = " + validateField);
		System.out.println("정렬 조건 = " + validateOrder);

		// 검증된 값 입력
		lectureVO.setSortField(validateField);
		lectureVO.setSortOrder(validateOrder);

		//교육방식
		lectureVO.setLectureMethod("집체");

		map.put("resultList", lectureDao.selectLectureList(lectureVO));
		map.put("resultCnt", lectureDao.selectLectureListCnt(lectureVO));

		return map;
	}

	@Transactional
	public Map<String, Object> selectEducation(LectureVO lectureVO) {
		Map<String, Object> map = new HashMap<String, Object>();

		// SQL인젝션방지
		String validateField = sortFieldValidator.validateSortField("education", lectureVO.getSortField());
		String validateOrder = sortFieldValidator.validateSortOrder(lectureVO.getSortOrder());

		// 검증된 값 입력
		lectureVO.setSortField(validateField);
		lectureVO.setSortOrder(validateOrder);

		map.put("resultList", lectureDao.selectEducationList(lectureVO));
		map.put("resultCnt", lectureDao.selectEducationListCnt(lectureVO));

		return map;
	}

	@Transactional
	public Map<String, Object> selectInstructor(LectureInsDTO lectureInsDTO) {
		Map<String, Object> map = new HashMap<String, Object>();


		map.put("resultList", lectureDao.selectInstructorList(lectureInsDTO));

		return map;
	}

	@Transactional
	public String saveInstructor(LectureInsDTO lectureInsDTO) {

        String message = "";
		// 강의의 배정된 강사를 수정
		lectureDao.updateLectureInstructor(lectureInsDTO);

		if ("C".equals(lectureInsDTO.getType())) {
			lectureDao.insertInstructor(lectureInsDTO);
			message = "강사 배정 완료";

		} else if ("U".equals(lectureInsDTO.getType())) {
			lectureDao.updateInstructor(lectureInsDTO);
			message = "강사 배정 수정 완료";
		}

		return message;
	}

	@Transactional
	public String saveLecture(LectureVO lectureVO) {
		String message = "";

		if ("C".equals(lectureVO.getType())) {
			lectureDao.insertLecture(lectureVO);
			message = "강의 개설 완료";
		} else if ("U".equals(lectureVO.getType())) {
			// 강의 날짜 변경 시 배정 된 강사 삭제
			int num = lectureDao.deleteLectureInstructor(lectureVO);
			if (num > 0) lectureVO.setInstructor(null);

			lectureDao.updateLecture(lectureVO);
            message = "강의 수정 완료";
		}

		return message;
	}

	@Transactional
	public LectureVO selectLectureKey(LectureVO lectureVO) {
		return lectureDao.selectLectureKey(lectureVO);
	}

	@Transactional
	public LectureVO selectLectureTitle(LectureEnrollDTO lectureEnrollDTO) {
		return lectureDao.selectLectureOne(lectureEnrollDTO);
	}

	@Transactional
	public String deleteLecture(LectureVO lectureVO) {
        String message = "";

		//강의 삭제 (실제 삭제X 업데이트 Status = '4002'
		lectureDao.deleteLecture(lectureVO);
        message = "강의 삭제 완료";

		return message;
	}

	@Transactional
	public Map<String, Object> selectEnrollList(LectureEnrollDTO lectureEnrollDTO) {
		Map<String, Object> map = new HashMap<String, Object>();

		String validateField = sortFieldValidator.validateSortField("enroll", lectureEnrollDTO.getSortField());
		String validateOrder = sortFieldValidator.validateSortOrder(lectureEnrollDTO.getSortOrder());

		lectureEnrollDTO.setSortField(validateField);
		lectureEnrollDTO.setSortOrder(validateOrder);



		map.put("resultList", lectureDao.selectEnrollList(lectureEnrollDTO));
		map.put("resultCnt", lectureDao.selectEnrollListCnt(lectureEnrollDTO));
		map.put("capacity", lectureDao.selectLectureCapacity(lectureEnrollDTO));

		return map;
	}

	@Transactional
	public Map<String, Object> selectStudentList(LectureMemDTO lectureMemDTO) {
		Map<String, Object> map = new HashMap<String, Object>();

		String validateField = sortFieldValidator.validateSortField("lectureStudent", lectureMemDTO.getSortField());
		String validateOrder = sortFieldValidator.validateSortOrder(lectureMemDTO.getSortOrder());

		lectureMemDTO.setSortField(validateField);
		lectureMemDTO.setSortOrder(validateOrder);

		map.put("resultList", lectureDao.selectStudentList(lectureMemDTO));
		map.put("resultCnt", lectureDao.selectStudentListCnt(lectureMemDTO));
		map.put("biz", lectureDao.selectCompanyList());


		return map;
	}

	@Transactional
	public String deleteStudent(LectureMemDTO lectureMemDTO) {
		String message = "";

		lectureDao.deleteStudent(lectureMemDTO);
        message = "수강생 배정 취소 완료";

		return message;
	}

	@Transactional
	public String insertStudent(LectureMemDTO lectureMemDTO) {
		String message = "";

	    lectureDao.insertStudent(lectureMemDTO);

		lectureDao.insertAttendance(lectureMemDTO);
		lectureDao.insertCertification(lectureMemDTO);

        message = "수강생 배정 완료";

		return message;
	}

	@Transactional
	public String insertSelectedStudents(LectureMemDTO lectureMemDTO) {
		String message = "";

		lectureDao.insertStudentBatch(lectureMemDTO);

	    List<Integer> enrollIds = lectureDao.selectEnrollIds(lectureMemDTO);

	    lectureMemDTO.setEnrollIds(enrollIds);

		lectureDao.insertAttendanceBatch(lectureMemDTO);
		lectureDao.insertCertificationBatch(lectureMemDTO);

        message = "선택 수강생 배정 완료";

		return message;
	}

	@Transactional
	public String deleteSelectedStudents(LectureMemDTO lectureMemDTO) {
		String message = "";

		lectureDao.deleteStudentBatch(lectureMemDTO);
		message = "선택 수강생 배정 취소 완료";

		return message;
	}



}
