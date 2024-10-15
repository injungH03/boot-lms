package com.atos.lms.business.member.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/admin")
public class LoginController {

    @RequestMapping("/login")
    public String LoginView() {

        return "atos/login/LoginUser";
    }
}
