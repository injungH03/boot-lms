package com.atos.lms.business.member.service;

import com.atos.lms.business.member.model.MemberVO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface LoginDAO {

    void insertMember(MemberVO memberVO);

    boolean existMember(MemberVO memberVO);

    MemberVO findMember(String username);



}
