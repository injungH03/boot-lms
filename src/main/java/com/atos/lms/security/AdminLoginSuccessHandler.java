package com.atos.lms.security;

import com.atos.lms.business.member.model.LoginHistoryVO;
import com.atos.lms.business.member.service.LoginDAO;
import com.atos.lms.business.member.service.LoginService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.Collection;

@Component
public class AdminLoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler {

    private final LoginService loginService;

    @Autowired
    public AdminLoginSuccessHandler(LoginService loginService) {
        this.loginService = loginService;
    }

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        // 로그인한 사용자 정보 가져오기
        User user = (User) authentication.getPrincipal();
        String username = user.getUsername();

        // 권한 가져 오기 (현재 각 회원은 하나의 권한만을 가진다)
        Collection<? extends GrantedAuthority> authorities = user.getAuthorities();
        String roleName = authorities.stream()
                .map(GrantedAuthority::getAuthority)
                .findFirst()
                .orElse("ROLE_UNKNOWN");

        // 로그인 이력 저장
        loginService.saveLoginHistory(username, roleName, request, "SUCCESS", "");

        // 기본 성공 핸들러 동작 유지
//        super.onAuthenticationSuccess(request, response, authentication);
        response.sendRedirect("/admin/member/boardList");
    }


}
