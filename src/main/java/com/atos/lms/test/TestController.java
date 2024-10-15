package com.atos.lms.test;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class TestController {

    private static final Logger logger = LoggerFactory.getLogger(TestController.class);

    @RequestMapping("/test")
    public String testMain() {

        System.out.println("dddd");
        logger.info("로그 작동중 ........");
        return "test/test";

    }

}
