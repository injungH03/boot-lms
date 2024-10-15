package com.atos.lms.test;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/test")
public class TestRestController {

    @PostMapping("/xss")
    public String testXSS(@RequestParam String input) {
        return "입력된 값: " + input;
    }
}
