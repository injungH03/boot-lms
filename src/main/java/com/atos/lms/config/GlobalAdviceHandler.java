package com.atos.lms.config;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ModelAttribute;

@ControllerAdvice
public class GlobalAdviceHandler {

    @ModelAttribute
    public void addAttributes(Model model) {
        model.addAttribute("pageTitle", "안전교육센터");  // 기본 타이틀
    }

}

