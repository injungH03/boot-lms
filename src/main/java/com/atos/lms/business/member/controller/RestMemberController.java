package com.atos.lms.business.member.controller;

import com.atos.lms.business.member.model.MemberVO;
import com.atos.lms.business.member.service.MemberService;
import com.atos.lms.common.model.ResponseVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

//@CrossOrigin(origins = "http://localhost:3000", allowCredentials = "true")
@RestController
@RequestMapping("/api")
public class RestMemberController {

    private final MemberService memberService;

    @Autowired
    public RestMemberController(MemberService memberService) {
        this.memberService = memberService;
    }


    @PostMapping("/signup")
    public ResponseEntity<ResponseVO> signup(@RequestBody MemberVO memberVO) throws Exception {
        System.out.println("리액트에서 넘어온 데이터 = " + memberVO);

        ResponseVO responseVO  = memberService.singUp(memberVO);

        System.out.println(">>>>" + responseVO.getMessage());

        return ResponseEntity.status(responseVO.getHttpStatus()).body(responseVO);

    }

}
