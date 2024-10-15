package com.atos.lms.config;

import com.atos.lms.component.XSSFilter;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
public class FilterConfig {

    @Bean
    public FilterRegistrationBean<XSSFilter> xssFilterRegistration(XSSFilter filter) {
        FilterRegistrationBean<XSSFilter> registrationBean = new FilterRegistrationBean<>();
        registrationBean.setFilter(filter);
        registrationBean.addUrlPatterns("/admin");
        registrationBean.setOrder(1); // 시큐리티 필터보다 먼저 실행되도록 낮은 순서 설정
        return registrationBean;
    }
}
