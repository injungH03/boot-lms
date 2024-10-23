package com.atos.lms.business.lecture.service;


import java.util.List;

import com.atos.lms.business.lecture.model.*;
import org.apache.ibatis.annotations.Mapper;



@Mapper
public interface LectureDAO  {

	List<LectureVO> selectLectureList(LectureVO lectureVO);

	int selectLectureListCnt(LectureVO lectureVO);

	List<LectureVO> selectEducationList(LectureVO lectureVO);

	int selectEducationListCnt(LectureVO lectureVO);

	List<LectureInsDTO> selectInstructorList(LectureInsDTO lectureInsDTO);

	List<LectureEnrollDTO> selectEnrollList(LectureEnrollDTO lectureEnrollDTO);

	int selectEnrollListCnt(LectureEnrollDTO lectureEnrollDTO);

	LectureVO selectLectureKey(LectureVO lectureVO);

	LectureVO selectLectureOne(int lectureCode);

	LectureVO selectAttendTime(LectureAttendDTO lectureAttendDTO );

	List<LectureMemDTO> selectStudentList(LectureMemDTO lectureMemDTO);

	int selectStudentListCnt(LectureMemDTO lectureMemDTO);

	List<LectureAttendDTO> selectAttendList(LectureAttendDTO lectureAttendDTO);

	int selectAttendListCnt(LectureAttendDTO lectureAttendDTO);

	List<LectureMemDTO> selectCompanyList();

	List<LectureAttendExcelVO> selectAttendExcel(LectureAttendDTO lectureAttendDTO);

	List<LectureExcelVO> selectLectureExcel(LectureVO lectureVO);


	void insertLecture(LectureVO lectureVO);

	void updateLecture(LectureVO lectureVO);

	/** 강의에 수강생 배정 인원수 업데이트 */
	void updateLectureEnroll(LectureMemDTO lectureMemDTO);

	/** 강의에 강사 업데이트 */
	void updateLectureInstructor(LectureInsDTO lectureInsDTO);

	/** 강사 배정 */
	void insertInstructor(LectureInsDTO lectureInsDTO);

	/** 강사 배정 */
	void updateInstructor(LectureInsDTO lectureInsDTO);

	/** 강사 배정 */
	void deleteInstructor(LectureInsDTO lectureInsDTO);

	/** 강의 수정시 배정 강사 삭제*/
	int deleteLectureInstructor(LectureVO lectureVO);

	/** 강의 삭제 실제 업데이트 수행 상태값 변경 */
	void deleteLecture(LectureVO lectureVO);

	/** 배정된 수강생 배정 취소 (삭제) */
	void deleteStudent(LectureMemDTO lectureMemDTO);

	/** 수강생 배정 */
	void insertStudent(LectureMemDTO lectureMemDTO);

	/** 수강생 배정시 출석 테이블에 수강생 추가 */
	void insertAttendance(LectureMemDTO lectureMemDTO);

	/** 수강생 배정시 수료 테이블에 수강생 추가 */
	void insertCertification(LectureMemDTO lectureMemDTO);

	/** 수강생 N건 배정 PK 조회 */
	List<Integer> selectEnrollIds(LectureMemDTO lectureMemDTO);

	/** 수강생 정원 조회 */
	LectureVO selectLectureCapacity(int lectureCode);

	/** 배정된 수강생 *선택* 배정 취소  (삭제) */
	void deleteStudentBatch(LectureMemDTO lectureMemDTO);

	void insertStudentBatch(LectureMemDTO lectureMemDTO);

	void insertAttendanceBatch(LectureMemDTO lectureMemDTO);

	void insertCertificationBatch(LectureMemDTO lectureMemDTO);

	/** 출석 / 결석 처리 */
	void updateAttend(LectureAttendDTO lectureAttendDTO);

	void updateAttendAll(LectureAttendDTO lectureAttendDTO);
}
