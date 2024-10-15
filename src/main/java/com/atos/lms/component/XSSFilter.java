package com.atos.lms.component;

import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.HttpServletRequest;
import org.owasp.html.Sanitizers;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.owasp.html.PolicyFactory;

import java.io.IOException;

@Component
public class XSSFilter implements Filter {

    private static final Logger logger = LoggerFactory.getLogger(XSSFilter.class);

    private final PolicyFactory policy = Sanitizers.FORMATTING.and(Sanitizers.LINKS);

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        logger.info("XSSFilter 작동중 ........");

        XSSRequestWrapper sanitizedRequest = new XSSRequestWrapper((HttpServletRequest) request, policy);
        chain.doFilter(sanitizedRequest, response);
    }
}
