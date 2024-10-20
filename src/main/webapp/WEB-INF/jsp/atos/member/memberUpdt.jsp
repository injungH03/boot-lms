<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="wrap">

<div class="head-section">
	<span>&nbsp;회원수정</span>
</div>
<div class="table-section">

    <form id="registForm" method="post">
        <table class="search-table regist-table">
            <tr>
                <th>아이디</th>
                <td colspan="3"><input type="text" name="id" value="${member.id }" class="form-control me-2 widthAuto"  readonly /></td>
            </tr>
            <tr>
                <th>비밀번호</th>
                <td colspan="3"><input type="password" id="password" name="password" class="form-control me-2 widthAuto" placeholder="영문/숫자/특수문자5~15자리" required /></td>
            </tr>
            <tr>
                <th>비밀번호확인</th>
                <td colspan="3"><input type="password" id="confirmPassword" name="confirmPassword" class="form-control me-2 widthAuto" placeholder="영문/숫자/특수문자5~15자리" required /></td>
            </tr>
            <tr>
                <th>이름</th>
                <td><input type="text" name="name" value="${member.name }" class="form-control me-2 widthAuto"/></td>
                <th>생년월일</th>
                <td><input type="date" name="birthdate" value="${member.birthdate }" class="form-control me-2 widthAuto" /></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><input type="text" name="phoneNo" value="${member.phoneNo }" class="form-control me-2 widthAuto" /></td>
                <th>이메일</th>
                <td><input type="email" name="email" value="${member.email }"class="form-control me-2 widthAuto"  /></td>
 
            </tr>
            <tr>
                <th>소속부서</th>
                <td><input type="text" name="department" value="${member.department }" class="form-control me-2 widthAuto" /></td>
                <th>직책</th>
                <td><input type="text" name="position" value="${member.position }" class="form-control me-2 widthAuto" /></td>
            </tr>
            <tr>
                <th>주소</th>
                <td colspan="3">
                    <div style="display: flex; align-items: center;">
                        <input type="text" id="zipcode" name="zipcode" value="${member.zipcode }" class="form-control me-2 widthAuto " placeholder="주소를 검색해주세요" readonly />
                        <button type="button" class="btn btn-sm btn-primary" id="addressSearchButton">주소 검색</button>
                    </div>
                    <input type="text" id="address" name="addr1" class="form-control mt-2 widthAuto" value="${member.addr1 }" placeholder="주소를 검색해주세요" readonly />
                    <input type="text" id="detailedAddress" name="addr2" class="form-control mt-2" value="${member.addr2 }" placeholder="상세주소를 입력하세요" style="width:43%"/>
                </td>
            </tr>
            <tr>
                <th>소속기업</th>
                <td colspan="3">
                    <select id="group" name="bizRegNo" class="form-select" required>
                        <option value="">선택</option>
                        <c:forEach var="company" items="${company }">
                            <option value="${company.corpBiz }" <c:if test="${company.corpBiz == member.bizRegNo}">selected</c:if>>
                                    ${company.corpName }
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th>사업자등록번호</th>
                <td><input type="text" id="businessRegistrationNumber" name="businessRegistrationNumber" value="${member.companybizRegNo }" class="form-control widthAuto" readonly /></td>
                <th>대표전화번호</th>
                <td><input type="text" id="phoneNo" name="companyPhoneNo" value="${member.companyPhoneNo }" class="form-control widthAuto" readonly /></td>
            </tr>
            <tr>
                <th>사업장명</th>
                <td><input type="text" id="businessName" name="businessName" value="${member.corpName }" class="form-control widthAuto" readonly /></td>
                <th>대표자명</th>
                <td><input type="text" id="representativeName" name="representativeName" value="${member.repName }" class="form-control widthAuto" readonly /></td>
            </tr>
            <tr>
                <th>업태</th>
                <td><input type="text" id="industryType" name="industryType" value="${member.bizType }" class="form-control widthAuto" readonly /></td>
                <th>종목</th>
                <td><input type="text" id="businessCategory" name="businessCategory" value="${member.bizItem }" class="form-control widthAuto" readonly /></td>
            </tr>
            <tr>
                <th>사업장주소</th>
                <td colspan="4"><input type="text" id="businessAddress" name="businessAddress" value="${member.companyAddr1 } ${member.companyAddr2}" class="form-control"  readonly style="width:43%"/></td>
            </tr>
        </table>

        <!-- 등록 및 목록 버튼 -->
        <div class="d-flex justify-content-between mt-3">
            <button type="submit" class="btn btn-success" id="submitBtn">저장</button>
            <button type="button" class="btn btn-secondary" id="btnList">목록</button>
        </div>
        <input type="hidden" name="type" value="U">
    </form>
</div>
</div>

<script>
$(document).ready(function() {
	autoHyphenForPhone('input[name="phoneNo"]');

    $('#group').change(function() {
        var selectedCorpBiz = $(this).val();

        if (selectedCorpBiz) {

            myFetch({
                url: '/admin/member/companyDetail',
                data: { corpBiz: selectedCorpBiz },
                success: function(response) {
                    const resultData = response.result[0];

                    $('#businessRegistrationNumber').val(resultData.bizRegNo);
                    $('#businessName').val(resultData.corpName);
                    $('#representativeName').val(resultData.repName);
                    $('#phoneNo').val(resultData.phoneNo);
                    $('#industryType').val(resultData.bizType);
                    $('#businessCategory').val(resultData.bizItem);
                    $('#businessAddress').val(resultData.addr1 + " " + resultData.addr2);
                },
                error: function(error) {
                    console.error('AJAX 오류:', error);
                }
            });
        } else {
            $('#businessRegistrationNumber, #phoneNo, #businessName, #representativeName, #industryType, #businessCategory, #businessAddress').val('');
        }
    });

    $.validator.addMethod("passwordComplexity", function(value, element) {
        return this.optional(element) || /^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{5,}$/.test(value);
    }, "비밀번호는 영문, 숫자, 특수문자를 포함하며 최소 5자 이상이어야 합니다.");

	$.validator.addMethod("phoneFormat", function(value, element) {
	    return this.optional(element) || /^010-\d{4}-\d{4}$/.test(value);
	}, "전화번호는 010-XXXX-XXXX 형식이어야 합니다.");
	
	
    $("#registForm").validate({
        rules: {
            id: {
                required: true,
                minlength: 5,
                maxlength: 15,
            },
            name: {
                required: true,
                minlength: 2,
                maxlength: 10
            },
            password: {
                required: true,
                minlength: 5,
                maxlength: 15,
                passwordComplexity: true
            },
            confirmPassword: {
                required: true,
                equalTo: "#password"  // 비밀번호와 일치하는지 확인
            },
            birthdate: {
                required: true,
                date: true
            },
            phoneNo: {
                required: true,
                phoneFormat: true
            },
            email: {
                required: true,
                email: true
            },
            bizRegNo: {
                required: true
            }
        },
        messages: {
            name: {
                required: "이름을 입력하세요.",
                minlength: "이름은 최소 2자 이상이어야 합니다.",
                maxlength: "이름은 최대 10자 이하여야 합니다."
            },
            password: {
                required: "비밀번호를 입력하세요.",
                minlength: "비밀번호는 최소 5자 이상이어야 합니다.",
                maxlength: "비밀번호는 최대 15자 이하여야 합니다.",
                passwordComplexity: "비밀번호는 영문, 숫자, 특수문자를 포함해야 합니다."
            },
            confirmPassword: {
                required: "비밀번호 확인을 입력하세요.",
                equalTo: "비밀번호가 일치하지 않습니다."
            },
            birthdate: {
                required: "생년월일을 입력하세요.",
                dateISO: "올바른 날짜 형식(YYYY-MM-DD)을 사용하세요."
            },
            phoneNo: {
                required: "전화번호를 입력하세요.",
                phoneFormat: "전화번호는 010-XXXX-XXXX 형식이어야 합니다."
            },
            email: {
                required: "이메일을 입력하세요.",
                email: "올바른 이메일 형식을 입력하세요."
            },
            bizRegNo: {
                required: "소속기업을 선택해주세요."
            }
        },
        
    });
    

    
    $('#submitBtn').click(function(event) {
    	event.preventDefault();
        if ($("#registForm").valid()) {
        	
            myFetch({
                url: '/admin/member/saveMember',
                data: 'registForm',
                success: function(response) {
                    alert(response.message);
                    window.location.href = "<c:url value='/admin/member/memberList'/>";
                },
                error: function(error) {
                    console.error('수정 중 오류 발생:', error);
                    alert('수정이 실패하였습니다.');
                }
            });
        } else {
            //alert("유효성 검사를 통과하지 못했습니다. 입력 값을 확인해주세요.");
            event.preventDefault(); 
        }

    });
    
	
	$('#btnList').on('click', function(event){
		event.preventDefault();
		window.location.href = "<c:url value='/admin/member/memberList'/>";
	});

    $('#addressSearchButton').on('click', function() {
        new daum.Postcode({
            oncomplete: function(data) {
                $('#zipcode').val(data.zonecode);
                $('#address').val(data.address); // 기본 주소
                $('#detailedAddress').focus();
            }
        }).open();
    });
    
});
</script>