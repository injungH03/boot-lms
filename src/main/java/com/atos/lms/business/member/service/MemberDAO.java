package com.atos.lms.business.member.service;

import com.atos.lms.business.company.model.CompanyVO;
import com.atos.lms.business.member.model.LoginHistoryVO;
import com.atos.lms.business.member.model.MemberDTO;
import com.atos.lms.business.member.model.MemberExcelVO;
import com.atos.lms.business.member.model.MemberVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface MemberDAO {

    List<MemberVO> selectStatusCode();

    List<MemberVO> selectCompany();

    List<MemberVO> selectMemberList(MemberVO memberVO);

    int selectMemberListCnt(MemberVO memberVO);

    CompanyVO selectCompanyKey(String corpBiz);

    MemberDTO selectMemberKey(MemberVO memberVO);

    List<MemberExcelVO> selectMemberListExcel(MemberVO memberVO);

    int checkEmailDuplicate(String email);

    int checkDuplicateId(String id);

    void updateStatus(MemberVO memberVO);

    void insertMember(MemberVO memberVO);

    void insertMemberNomal(MemberVO memberVO);

    void insertMemberList(@Param("memberList") List<MemberVO> memberList);

    void insertMemberNomalList(@Param("memberList") List<MemberVO> memberList);

    void updateMember(MemberVO memberVO);

    void updateMemberNomal(MemberVO memberVO);

    void deleteMember(MemberVO memberVO);


}
