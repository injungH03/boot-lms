package com.atos.lms.component;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletRequestWrapper;
import org.owasp.html.PolicyFactory;

import java.util.*;

public class XSSRequestWrapper extends HttpServletRequestWrapper {

    private final PolicyFactory policy;

    public XSSRequestWrapper(HttpServletRequest request, PolicyFactory policy) {
        super(request);
        this.policy = policy;
    }

    @Override
    public String getParameter(String name) {
        String value = super.getParameter(name);
        return sanitize(value);
    }

    @Override
    public String[] getParameterValues(String name) {
        String[] values = super.getParameterValues(name);
        if (values == null) return null;
        String[] sanitizedValues = new String[values.length];
        for(int i=0; i<values.length; i++) {
            sanitizedValues[i] = sanitize(values[i]);
        }
        return sanitizedValues;
    }

    @Override
    public Map<String, String[]> getParameterMap() {
        Map<String, String[]> paramMap = super.getParameterMap();
        Map<String, String[]> sanitizedMap = new HashMap<>();
        paramMap.forEach((key, values) -> {
            String[] sanitizedValues = Arrays.stream(values)
                    .map(this::sanitize)
                    .toArray(String[]::new);
            sanitizedMap.put(key, sanitizedValues);
        });
        return sanitizedMap;
    }

    private String sanitize(String value) {
        if (value != null) {
            return policy.sanitize(value);
        }
        return null;
    }
}