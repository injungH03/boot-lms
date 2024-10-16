package com.atos.lms.security;

import com.atos.lms.business.member.service.LoginService;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.java.Log;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;


import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class JsonAuthFilter extends UsernamePasswordAuthenticationFilter {

    private final ObjectMapper objectMapper = new ObjectMapper();
    private final JwtTokenProvider jwtTokenProvider;
    private final LoginService loginService;

    // 로그인한 유저의 아이디
    private String username;

    public JsonAuthFilter(JwtTokenProvider jwtTokenProvider, AuthenticationManager authenticationManager, LoginService loginService) {
        this.jwtTokenProvider = jwtTokenProvider;
        this.loginService = loginService;
        this.setAuthenticationManager(authenticationManager);
    }

    @Override
    public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
        if (!"application/json".equals(request.getContentType()) &&
                !"application/json;charset=UTF-8".equals(request.getContentType())) {
            return super.attemptAuthentication(request, response);
        }

        try {
            Map<String, String> authRequest = objectMapper.readValue(request.getInputStream(), Map.class);
            username = authRequest.get(getUsernameParameter());
            String password = authRequest.get(getPasswordParameter());


            if (username == null) {
                username = "";
            }

            if (password == null) {
                password = "";
            }

            username = username.trim();

            System.out.println("아이디 비번 = " + username +"/" + password);

            UsernamePasswordAuthenticationToken authToken = new UsernamePasswordAuthenticationToken(username, password);

            setDetails(request, authToken);

            return this.getAuthenticationManager().authenticate(authToken);
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    protected void successfulAuthentication(HttpServletRequest request, HttpServletResponse response, FilterChain chain,
                                            Authentication authResult) throws IOException, ServletException {

        String jwtToken = jwtTokenProvider.generateToken(authResult.getName());

        Collection<? extends GrantedAuthority> authorities = authResult.getAuthorities();
        String role = authorities.stream()
                .map(GrantedAuthority::getAuthority)
                .findFirst()
                .orElse("ROLE_UNKNOWN");

        // 로그인 이력 저장
        loginService.saveLoginHistory(authResult.getName(), role, request, "SUCCESS", "");

        // JWT 토큰과 역할 정보를 함께 JSON 응답
        Map<String, String> tokenResponse = new HashMap<>();
        tokenResponse.put("token", jwtToken);
        tokenResponse.put("role", role);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write(objectMapper.writeValueAsString(tokenResponse));
        response.getWriter().flush();
    }
    @Override
    protected void unsuccessfulAuthentication(HttpServletRequest request, HttpServletResponse response, AuthenticationException failed)
            throws IOException, ServletException {

        // 로그인 이력 저장 (실패)
        loginService.saveLoginHistory(username, "UNKNOWN", request, "FAILURE", failed.getMessage());

        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"error\": \"로그인에 실패했습니다.\"}");
        response.getWriter().flush();
    }

}
