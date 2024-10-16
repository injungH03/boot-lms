package com.atos.lms.business.member.controller;

import com.atos.lms.business.member.model.MemberVO;
import com.atos.lms.business.member.service.MemberService;
//import com.atos.lms.common.model.ResponseVO;
//import com.atos.lms.common.utl.ResponseHelper;
import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.utl.ResponseHelper;
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
    public ResponseEntity<ResponseVO<Void>> signup(@RequestBody MemberVO memberVO) throws Exception {
        System.out.println("리액트에서 넘어온 데이터 = " + memberVO);

        memberService.signUp(memberVO);
        ResponseVO<Void> response  = ResponseHelper.success("회원가입 완료");

        return new ResponseEntity<>(response, response.getHttpStatus());

    }

}
