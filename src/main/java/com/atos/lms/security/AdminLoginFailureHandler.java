package com.atos.lms.security;

import com.atos.lms.business.member.service.LoginService;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationFailureHandler;
import org.springframework.stereotype.Component;

import java.io.IOException;

@Component
public class AdminLoginFailureHandler extends SimpleUrlAuthenticationFailureHandler {

    private final LoginService loginService;

    @Autowired
    public AdminLoginFailureHandler(LoginService loginService) {
        this.loginService = loginService;
    }

    @Override
    public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
                                        AuthenticationException exception) throws IOException, ServletException {

        String username = request.getParameter("username");

        if (username == null || username.trim().isEmpty()) {
            username = "UNKNOWN";
        }

//        loginService.saveLoginHistory(username, "UNKNOWN", request, "FAILURE", exception.getMessage());
        request.getSession().setAttribute("errorMessage", "아이디 또는 비밀번호가 다릅니다.");

        response.sendRedirect("/admin/login?error=true");
    }

}
