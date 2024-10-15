package com.atos.lms.config;

import com.atos.lms.component.MenuInterceptor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final MenuInterceptor menuInterceptor;

    @Autowired
    public WebConfig(MenuInterceptor menuInterceptor) {
        this.menuInterceptor = menuInterceptor;
    }

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 모든 경로에 대해 Interceptor 적용
        registry.addInterceptor(menuInterceptor).addPathPatterns("/admin/**");
    }
}
