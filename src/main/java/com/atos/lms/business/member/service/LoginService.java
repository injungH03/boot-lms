package com.atos.lms.business.member.service;

import com.atos.lms.business.member.model.LoginHistoryVO;
import com.atos.lms.business.member.model.MemberVO;
import com.atos.lms.common.model.ResponseVO;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.InternalAuthenticationServiceException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.Collections;

@Service
public class LoginService implements UserDetailsService {

    private final LoginDAO loginDAO;

    @Autowired
    public LoginService(LoginDAO loginDAO) {
        this.loginDAO = loginDAO;
    }


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        MemberVO memberVO = loginDAO.findMember(username);
        if (memberVO == null) {
            throw new UsernameNotFoundException("아이디 존재 X");
        }

        System.out.println("Found user: " + memberVO.getId() + ", role: " + memberVO.getRoleName());


        GrantedAuthority authority = new SimpleGrantedAuthority(memberVO.getRoleName());

        if (memberVO.getPassword() == null || memberVO.getPassword().isEmpty()) {
            throw new InternalAuthenticationServiceException("사용자의 비밀번호가 설정되어 있지 않습니다.");
        }

        if (memberVO.getRoleName() == null || memberVO.getRoleName().isEmpty()) {
            throw new InternalAuthenticationServiceException("사용자의 역할이 설정되어 있지 않습니다.");
        }

        return new User(memberVO.getId(), memberVO.getPassword(), memberVO.isEnabled(),
                true, true, true, Collections.singleton(authority));
    }

    public void saveLoginHistory(String username, String roleName, HttpServletRequest request, String loginStatus, String failReason) {
        LoginHistoryVO loginHistoryVO  = new LoginHistoryVO();
        loginHistoryVO.setMemberId(username);
        loginHistoryVO.setRoleName(roleName);
        loginHistoryVO.setLoginTime(String.valueOf(LocalDateTime.now()));

        loginHistoryVO.setUserAgent(request.getHeader("User-Agent"));
        loginHistoryVO.setLoginStatus(loginStatus);
        loginHistoryVO.setLoginFailReason(failReason);
        loginHistoryVO.setDeviceType(request.getHeader("User-Agent").toLowerCase().contains("mobile") ? "Mobile" : "PC");

        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty()) {
            ip = request.getRemoteAddr();
        }

        loginHistoryVO.setIpAddress(ip);

        loginDAO.insertLoginHistory(loginHistoryVO);
    }



}
