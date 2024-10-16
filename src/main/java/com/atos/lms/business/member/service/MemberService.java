package com.atos.lms.business.member.service;

import com.atos.lms.business.member.model.MemberVO;
import com.atos.lms.common.model.ResponseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class MemberService {

    private final LoginDAO loginDAO;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public MemberService(LoginDAO loginDAO, PasswordEncoder passwordEncoder) {
        this.loginDAO = loginDAO;
        this.passwordEncoder = passwordEncoder;
    }

    public void signUp(MemberVO memberVO) throws Exception {
        if (loginDAO.existMember(memberVO)) {
            throw new IllegalArgumentException("아이디가 이미 존재합니다.");
        }

        memberVO.setPassword(passwordEncoder.encode(memberVO.getPassword()));

        loginDAO.insertMember(memberVO);
    }
}
