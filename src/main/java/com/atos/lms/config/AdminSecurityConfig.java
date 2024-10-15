package com.atos.lms.config;

import com.atos.lms.security.CustomAccessDeniedHandler;
import com.atos.lms.security.CustomAuthenticationEntryPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.annotation.Order;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.web.SecurityFilterChain;

@Configuration
@EnableWebSecurity
public class AdminSecurityConfig {

    @Autowired
    private CustomAuthenticationEntryPoint customAuthenticationEntryPoint;

    @Autowired
    private CustomAccessDeniedHandler customAccessDeniedHandler;

    @Bean
    @Order(2) // 낮은 우선순위
    public SecurityFilterChain adminSecurityFilterChain(HttpSecurity http) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .securityMatcher("/admin/**") // /admin/** 경로에만 적용
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/admin/login", "/admin/actionLogin", "/admin/login?error=true", "/admin/login?logout=true").permitAll()
                        .anyRequest().hasRole("ADMIN") // 나머지 admin 경로는 ADMIN 역할만 허용
                )
                .formLogin(form -> form
                        .loginPage("/admin/login") // 커스텀 로그인 페이지 경로
                        .loginProcessingUrl("/admin/actionLogin") // 로그인 처리 URL
                        .defaultSuccessUrl("/admin/member/boardList", true) // 로그인 성공 시 리다이렉트 URL
                        .failureUrl("/admin/login?error=true") // 로그인 실패 시 리다이렉트 URL
                        .failureHandler((request, response, exception) -> {
                            request.getSession().setAttribute("errorMessage", "아이디 또는 비밀번호가 틀렸습니다.");
                            response.sendRedirect("/admin/login?error=true");
                        })
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/admin/logout") // 로그아웃 처리 URL
                        .logoutSuccessUrl("/admin/login?logout=true") // 로그아웃 성공 시 리다이렉트 URL
                        .deleteCookies("JSESSIONID") // 세션 쿠키 삭제
                        .permitAll()
                )
                .exceptionHandling(exception -> exception
                        .authenticationEntryPoint(customAuthenticationEntryPoint)
                        .accessDeniedHandler(customAccessDeniedHandler)
                );


        return http.build();
    }
}
