package com.atos.lms.business.member.service;

import com.atos.lms.business.company.model.CompanyVO;
import com.atos.lms.business.member.model.MemberAllDTO;
import com.atos.lms.business.member.model.MemberDTO;
import com.atos.lms.business.member.model.MemberExcelVO;
import com.atos.lms.business.member.model.MemberVO;
import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.utl.ExcelUtil;
import jakarta.servlet.http.HttpServletResponse;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.io.InputStream;
import java.util.*;

@Service
public class MemberService {

    private final LoginDAO loginDAO;
    private final PasswordEncoder passwordEncoder;
    private final MemberDAO memberDAO;

    @Autowired
    public MemberService(LoginDAO loginDAO, PasswordEncoder passwordEncoder, MemberDAO memberDAO) {
        this.loginDAO = loginDAO;
        this.passwordEncoder = passwordEncoder;
        this.memberDAO = memberDAO;
    }

    @Transactional
    public Map<String, Object> selectMemberList(MemberVO memberVO) {
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("resultList", memberDAO.selectMemberList(memberVO));
        map.put("resultCnt", memberDAO.selectMemberListCnt(memberVO));

        return map;
    }

    @Transactional
    public List<MemberVO> selectStatusCode() {
        return memberDAO.selectStatusCode();
    }

    @Transactional
    public List<MemberVO> selectCompany() {
        return memberDAO.selectCompany();
    }

    @Transactional
    public CompanyVO selectCompanyKey(String corpBiz) {
        return memberDAO.selectCompanyKey(corpBiz);
    }

    @Transactional
    public MemberDTO selectMemberKey(MemberVO memberVO) {
        return memberDAO.selectMemberKey(memberVO);
    }


    @Transactional
    public String updateStatus(MemberVO memberVO ) {

        memberDAO.updateStatus(memberVO);

        return "상태 변경 완료";
    }

    @Transactional
    public String insertMember(MemberVO memberVO) {

        memberVO.setPassword(passwordEncoder.encode(memberVO.getPassword()));

        memberDAO.insertMember(memberVO);
        memberDAO.insertMemberNomal(memberVO);

        return "회원 등록 완료";
    }

    public String saveMember(MemberVO memberVO) {

        if ("U".equals(memberVO.getType())) {
            memberDAO.updateMember(memberVO);
            memberDAO.updateMemberNomal(memberVO);
            return "회원 수정 완료";
        } else if ("C".equals(memberVO.getType())) {
            memberDAO.insertMember(memberVO);
            memberDAO.insertMemberNomal(memberVO);
            return "회원 등록 완료";
        }

        return "잘못된 경로";
    }

    @Transactional
    public String deleteMember(MemberVO memberVO) {

        memberDAO.deleteMember(memberVO);

        return "회원 삭제 완료";
    }

    @Transactional
    public boolean checkDuplicateId(String id) {
        return memberDAO.checkDuplicateId(id) <= 0;
    }



    @Transactional
    public void signUp(MemberVO memberVO) throws Exception {
        if (loginDAO.existMember(memberVO)) {
            throw new IllegalArgumentException("아이디가 이미 존재합니다.");
        }

        memberVO.setPassword(passwordEncoder.encode(memberVO.getPassword()));

        loginDAO.insertMember(memberVO);
    }

    @Transactional
    public String memberAllSave(MemberAllDTO memberAllDTO) {
        List<MemberVO> memberList = memberAllDTO.getPreviewData();
        String corpBiz = memberAllDTO.getCorpBiz();

        //엑셀 데이터를 가져와서 아이디와 비밀번호 사업자번호를 세팅
        memberList.forEach(member -> {
            String email = member.getEmail();

            // 중복 이메일 체크
            if (memberDAO.checkEmailDuplicate(email) > 0) {
                throw new IllegalArgumentException("중복된 이메일이 있습니다: " + email);
            }

            member.setId(email);
            member.setCorpBiz(corpBiz);
            member.setStatus("1002");
            //임시 비밀번호 "아토스"(한글영문타자)
            String enpassword = passwordEncoder.encode("dkxhtm");
            member.setPassword(enpassword);
        });

        memberDAO.insertMemberList(memberList);
        memberDAO.insertMemberNomalList(memberList);

        return "회원 저장 성공";
    }

    /** #########################################권한 강사 회원####################################################### */
    public Map<String, Object> selectInstructorList(MemberVO memberVO) {
        Map<String, Object> map = new HashMap<String, Object>();

        map.put("resultList", memberDAO.selectInstructorList(memberVO));
        map.put("resultCnt", memberDAO.selectInstructorListCnt(memberVO));

        return map;
    }

    public MemberVO selectInstructorKey(MemberVO memberVO) {
        return memberDAO.selectInstructorKey(memberVO);
    }

    public String saveInstructor(MemberVO memberVO) {

        if ("U".equals(memberVO.getType())) {
            memberDAO.updateMember(memberVO);
            memberDAO.updateMemberInstructor(memberVO);
            return "회원 수정 완료";
        } else if ("C".equals(memberVO.getType())) {
            memberDAO.insertMember(memberVO);
            memberDAO.insertMemberInstructor(memberVO);
            return "회원 등록 완료";
        }

        return "잘못된 경로";
    }

    public void instructorListExcelDown(HttpServletResponse response, MemberVO memberVO) throws Exception {
        List<MemberVO> list = memberDAO.selectInstructorListExcel(memberVO);

        Map<String, String> fieldToHeaderMap = new HashMap<>();
        fieldToHeaderMap.put("id", "아이디");
        fieldToHeaderMap.put("name", "이름");
        fieldToHeaderMap.put("birthdate", "생년월일");
        fieldToHeaderMap.put("phoneNo", "휴대폰번호");
        fieldToHeaderMap.put("email", "이메일");
        fieldToHeaderMap.put("zipcode", "우편번호");
        fieldToHeaderMap.put("addr1", "주소1");
        fieldToHeaderMap.put("addr2", "주소2");
        fieldToHeaderMap.put("job", "직업");
        fieldToHeaderMap.put("department", "소속");
        fieldToHeaderMap.put("position", "직책");
        fieldToHeaderMap.put("bios", "강사소개");
        fieldToHeaderMap.put("career", "경력사항");

        ExcelUtil.exportToExcel(response, list, "강사목록", "강사목록엑셀파일", fieldToHeaderMap);

    }

    /**#################################################################################################################### */

    public void sampleExcelDown(HttpServletResponse response) throws Exception {
        Map<String, String> fieldToHeaderMap = new LinkedHashMap<>();
        fieldToHeaderMap.put("name", "이름");
        fieldToHeaderMap.put("birthdate", "생년월일");
        fieldToHeaderMap.put("phoneNumber", "전화번호");
        fieldToHeaderMap.put("email", "이메일");
        fieldToHeaderMap.put("department", "소속부서");
        fieldToHeaderMap.put("position", "직책");

        ExcelUtil.exportTemplateToExcel(response, "회원정보 양식", "회원정보_양식", fieldToHeaderMap);
    }

    @Transactional
    public void memberListExcelDown(HttpServletResponse response, MemberVO memberVO) throws Exception {
        List<MemberExcelVO> memberList = memberDAO.selectMemberListExcel(memberVO);

        Map<String, String> fieldToHeaderMap = new HashMap<>();
        fieldToHeaderMap.put("id", "아이디");
        fieldToHeaderMap.put("name", "이름");
        fieldToHeaderMap.put("birthdate", "생년월일");
        fieldToHeaderMap.put("phoneNo", "휴대폰번호");
        fieldToHeaderMap.put("zipcode", "우편번호");
        fieldToHeaderMap.put("addr1", "주소1");
        fieldToHeaderMap.put("addr2", "주소2");
        fieldToHeaderMap.put("department", "소속부서");
        fieldToHeaderMap.put("position", "직책");
        fieldToHeaderMap.put("email", "이메일");
        fieldToHeaderMap.put("companybizRegNo", "사업자번호");
        fieldToHeaderMap.put("corpName", "사업장명");
        fieldToHeaderMap.put("repName", "대표자명");
        fieldToHeaderMap.put("bizType", "업태");
        fieldToHeaderMap.put("bizItem", "종목");
        fieldToHeaderMap.put("companyPhoneNo", "대표전화번호");
        fieldToHeaderMap.put("companyZipcode", "회사우편번호");
        fieldToHeaderMap.put("companyAddr1", "회사주소1");
        fieldToHeaderMap.put("companyAddr2", "회사주소2");

        ExcelUtil.exportToExcel(response, memberList, "회원목록", "회원목록엑셀파일", fieldToHeaderMap);
    }

    public List<MemberVO> uploadExcel(MultipartFile file) throws Exception {
        InputStream inputStream = file.getInputStream();
        Workbook workbook = new XSSFWorkbook(inputStream);
        Sheet sheet = workbook.getSheetAt(0);

        List<MemberVO> memberList = new ArrayList<MemberVO>();

        for (int i = 1; i <= sheet.getLastRowNum(); i++) {
            Row row = sheet.getRow(i);

            MemberVO member = new MemberVO();

            member.setName(ExcelUtil.getCellValue(row.getCell(0)));       // 이름 (String)
            member.setBirthdate(ExcelUtil.getCellValue(row.getCell(1)));  // 생년월일 (String or Numeric)
            member.setPhoneNo(ExcelUtil.getCellValue(row.getCell(2)));    // 전화번호 (String)
            member.setEmail(ExcelUtil.getCellValue(row.getCell(3)));      // 이메일 (String)
            member.setDepartment(ExcelUtil.getCellValue(row.getCell(4))); // 소속부서 (String)
            member.setPosition(ExcelUtil.getCellValue(row.getCell(5)));   // 직책 (String)
            memberList.add(member);
        }

        workbook.close();

        return memberList;
    }
}
