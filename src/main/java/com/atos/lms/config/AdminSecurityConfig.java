package com.atos.lms.config;

import com.atos.lms.security.AdminLoginFailureHandler;
import com.atos.lms.security.AdminLoginSuccessHandler;
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

    private final CustomAuthenticationEntryPoint customAuthenticationEntryPoint;
    private final CustomAccessDeniedHandler customAccessDeniedHandler;

    @Autowired
    public AdminSecurityConfig(CustomAuthenticationEntryPoint customAuthenticationEntryPoint,
                               CustomAccessDeniedHandler customAccessDeniedHandler) {
        this.customAuthenticationEntryPoint = customAuthenticationEntryPoint;
        this.customAccessDeniedHandler = customAccessDeniedHandler;
    }

    @Bean
    @Order(2) // 낮은 우선순위
    public SecurityFilterChain adminSecurityFilterChain(HttpSecurity http, AdminLoginSuccessHandler successHandler,
                                                        AdminLoginFailureHandler failureHandler) throws Exception {
        http
                .csrf(csrf -> csrf.disable())
                .securityMatcher("/admin/**") // /admin/** 경로에만 적용
                .authorizeHttpRequests(authorize -> authorize
                        .requestMatchers("/images/**", "/css/**", "/js/**", "/favicon.ico").permitAll()
                        .requestMatchers("/admin/login", "/admin/actionLogin", "/admin/login?error=true", "/admin/login?logout=true").permitAll()
                        .anyRequest().hasRole("ADMIN")
                )
                .formLogin(form -> form
                        .loginPage("/admin/login") // 커스텀 로그인 페이지 경로
                        .loginProcessingUrl("/admin/actionLogin") // 로그인 처리 URL
                        .successHandler(successHandler)  // 로그인 성공 핸들러
                        .failureHandler(failureHandler)  // 로그인 실패 핸들러
                        .permitAll()
                )
                .logout(logout -> logout
                        .logoutUrl("/admin/logout") // 로그아웃 처리 URL
                        .logoutSuccessUrl("/admin/login?logout=true") // 로그아웃 성공 시 리다이렉트 URL
                        .invalidateHttpSession(true) // 세션 무효화
                        .deleteCookies("JSESSIONID") // 세션 쿠키 삭제
                        .permitAll()
                )
                .sessionManagement(session -> session
                        .invalidSessionUrl("/admin/login?sessionExpired=true")
                        .maximumSessions(1) // 최대 세션 수 제한
                        .expiredUrl("/admin/login?sessionExpired=true")
                )
                .exceptionHandling(exception -> exception
                        .authenticationEntryPoint(customAuthenticationEntryPoint)
                        .accessDeniedHandler(customAccessDeniedHandler)
                );


        return http.build();
    }
}
