<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/common.css' />">
<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="wrap">




<div class="head-section">
	<span>&nbsp;업체 등록</span>
</div>
<div class="table-section">

    <form id="registForm" method="post" enctype="multipart/form-data">



<table class="search-table regist-table">
    <tr>
        <th>사업장명</th>
        <td><input type="text" name="corpName" class="form-control custom-width" placeholder="사업장명을 입력하세요" /></td>
        <th>사업자등록번호</th>
        <td><input type="text" id="bizRegNo" name="bizRegNo" class="form-control custom-width" placeholder="사업자등록번호를 입력하세요" maxlength="10" /></td>
    </tr>
    <tr>
        <th>주소</th>
        <td colspan="1">
          <div class="mt-2">
           <input type="text" id="zipcode" name="zipcode" class="form-control me-2 custom-width" placeholder="우편번호를 검색해주세요" readonly />
           <button type="button" class="btn btn-sm btn-primary" id="addressSearchButton">주소검색</button>
          </div>

          <div class="mt-2">
            <input type="text" id="addr1" name="addr1" class="form-control me-2 custom-width" placeholder="주소를 검색해주세요" readonly />
            <input type="text" id="addr2" name="addr2" class="form-control mt-2 custom-width" placeholder="상세주소를 입력하세요" disabled/>
          </div>


        </td>
        <th colspan="2"></th>
    </tr>
    <tr>
        <th>대표자명</th>
        <td><input type="text" name="repName" class="form-control custom-width" placeholder="대표자명을 입력하세요" /></td>
        <th>업태</th>
        <td><input type="text" name="bizType" class="form-control custom-width" placeholder="업태를 입력하세요" /></td>
    </tr>
    <tr>
        <th>종목</th>
        <td><input type="text" name="bizItem" class="form-control custom-width" placeholder="종목을 입력하세요" /></td>
        <th>전화번호</th>
        <td><input type="text" name="phoneNo" class="form-control custom-width" placeholder="전화번호를 입력하세요" /></td>
    </tr>
    <tr>
        <th>세금계산서 메일</th>
        <td colspan=""><input type="email" name="taxInvoice" class="form-control custom-width" placeholder="이메일을 입력하세요" /></td>
        <th colspan="2"></th>
    </tr>
    <tr>
        <th>직원 수</th>
        <td>
            <input type="number" name="empCount" class="form-control custom-width" min="1" max="100" placeholder="직원 수를 입력하세요" />
        </td>  
        <th>교육 인원</th>
        <td>
            <input type="number" name="trainCount" class="form-control custom-width" min="1" max="100" placeholder="교육 인원을 입력하세요" />
        </td>  
    </tr>        
    <tr>
        <th>메모</th>
        <td colspan="3">
            <textarea id="memo" name="memo" class="form-control" rows="4" ></textarea>
        </td>
    </tr>
    <tr>
        <th>교육 담당자명</th>
        <td><input type="text" name="trainManager" class="form-control custom-width" placeholder="담당자명을 입력하세요" /></td>
        <th colspan="2"></th>
    </tr>
    <tr>
        <th>이메일</th>
        <td><input type="email" name="trainEmail" class="form-control custom-width" placeholder="이메일을 입력하세요" /></td>
        <th>휴대폰</th>
        <td><input type="tel" name="trainPhone" class="form-control custom-width" placeholder="휴대폰 번호를 입력하세요" /></td>
    </tr>
    <tr>
        <th >계산서 담당자명</th>
        <td><input type="text" name="taxManager" class="form-control custom-width" placeholder="담당자명을 입력하세요" /></td>
        <th colspan="2"></th>
    </tr>
    <tr>
        <th>이메일</th>
        <td><input type="email" name="taxEmail" class="form-control custom-width" placeholder="이메일을 입력하세요" /></td>
        <th>휴대폰</th>
        <td><input type="tel" name="taxPhone" class="form-control custom-width" placeholder="휴대폰 번호를 입력하세요" /></td>
    </tr>
</table>




        <!-- 등록 및 목록 버튼 -->
        <div class="d-flex justify-content-between mt-3">
            <button type="submit" class="btn btn-success" id="submitBtn">등록</button>
            <button type="button" class="btn btn-secondary" id="btnList">목록</button>
        </div>
        

    </form>
</div>



</div>


<script>


$(document).ready(function() {
    // 폼 유효성 검사 초기화
    $("#registForm").validate({
        rules: {
            corpName: {
                required: true,
                maxlength: 60
            },
            bizRegNo: {
                required: true,
                maxlength: 10
            },
            addr1: {
                required: true,
                maxlength: 300
            },
            addr2: {
                required: true,
                maxlength: 300
            },
            repName: {
                required: true,
                maxlength: 30
            },
            bizType: {
                required: true,
                maxlength: 60
            },
            bizItem: {
                required: true,
                maxlength: 60
            },
            phoneNo: {
                required: true,
                maxlength: 15
            },
            taxInvoice: {
                required: true,
                email: true,
                maxlength: 50
            }
        },
        messages: {
            corpName: {
                required: "사업장명을 입력하세요.",
                maxlength: "사업장명은 최대 60자까지 입력 가능합니다."
            },
            bizRegNo: {
                required: "사업자등록번호를 입력하세요.",
                maxlength: "사업자등록번호는 최대 10자까지 입력 가능합니다."
            },
            addr1: {
                required: "주소를 검색하세요.",
            },
            addr2: {
                required: "상세 주소를 입력하세요.",
            },
            repName: {
                required: "대표자명을 입력하세요.",
                maxlength: "대표자명은 최대 30자까지 입력 가능합니다."
            },
            bizType: {
                required: "업태를 입력하세요.",
                maxlength: "업태는 최대 60자까지 입력 가능합니다."
            },
            bizItem: {
                required: "종목을 입력하세요.",
            },
            phoneNo: {
                required: "전화번호를 입력하세요.",
                maxlength: "전화번호는 최대 15자까지 입력 가능합니다."
            },
            taxInvoice: {
                required: "이메일을 입력하세요.",
                email: "유효한 이메일 주소를 입력하세요.",
            }
        },
        errorElement: 'div',
        errorClass: 'invalid-feedback',
        errorPlacement: function(error, element) {
            $(element).next('div.invalid-feedback').remove(); 
            error.insertAfter(element); 
        },
        highlight: function(element) {
            $(element).addClass('is-invalid');
        },
        unhighlight: function(element) {
            $(element).removeClass('is-invalid');
        }
    });

    // 등록 버튼 클릭 이벤트
    $('#submitBtn').click(function(event) {
        event.preventDefault();
        
        if ($("#registForm").valid()) {
            // 폼 데이터 JSON 변환
            var formData = $('#registForm').serializeArray();
            var jsonData = {};
            $(formData).each(function(index, obj) {
                jsonData[obj.name] = obj.value;
            });

            // 사업자등록번호 중복 체크 후 등록 요청
            var bizRegNo = jsonData['bizRegNo'];
            $.ajax({
                url: '<c:url value="/admin/company/checkDuplicateBizRegNo" />', // 중복 체크 URL
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ bizRegNo: bizRegNo }),
                success: function(response) {
                    if (response.result.duplicate) {
                        alert("이미 존재하는 사업자등록번호입니다.");
                    } else {
                        // 중복 없을 경우 등록 처리
                        $.ajax({
                            url: '<c:url value="/admin/company/companyInsert" />',
                            type: 'POST',
                            contentType: 'application/json',
                            data: JSON.stringify(jsonData),
                            success: function(response) {
                                alert(response.message || "등록이 완료되었습니다.");
                                window.location.href = "<c:url value='/admin/company/companyList' />";
                            },
                            error: function(jqXHR, textStatus, errorThrown) {
                                alert('등록이 실패하였습니다.');
                            }
                        });
                    }
                },
                error: function() {
                    alert("중복 확인 중 오류가 발생했습니다.");
                }
            });
        } else {
            alert("필수 입력란을 확인해주세요.");
        }
    });



       $('#addressSearchButton').on('click', function() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 우편번호와 주소를 각각 설정
                    $('#zipcode').val(data.zonecode); // 우편번호 설정
                    $('#addr1').val(data.address); // 기본 주소 설정
                    $('#addr1').valid(); // 유효성 검사를 다시 실행하여 오류 제거
                    $('#addr2').prop('disabled', false).focus(); // 상세주소 입력 필드로 포커스를 이동
                   
    
                }
            }).open();
        });



// 메모란의 글자 수 제한 기능 추가
$('#memo').on('input', function() {
    var text = $(this).val();
    var koreanCharCount = (text.match(/[\u3131-\uD79D]/g) || []).length; // 한글 글자 수
    var otherCharCount = text.length - koreanCharCount; // 한글 외 글자 수

    // 한글은 1000자, 영문은 1500자 제한
    if (koreanCharCount > 1000 || otherCharCount > 1500) {
        alert('메모란은 한글 1000자, 영문 1500자로 제한됩니다.');
        $(this).val(text.substring(0, 1000 + 1500)); // 한글과 영문 합쳐서 2500자로 제한
    }
});

// 중복 체크를 위한 AJAX 로직
$('#bizRegNo').on('focusout', function() {
    var bizRegNo = $(this).val();
    if (bizRegNo) {
        $.ajax({
            url: '<c:url value="/admin/company/checkDuplicateBizRegNo" />', // 컨트롤러에서 중복 체크 URL
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({ bizRegNo: bizRegNo }),
            success: function(response) {
                if (response.result.duplicate) {
                    alert("이미 존재하는 사업자등록번호입니다.");
                    $('#bizRegNo').addClass('is-invalid');
                } else {
                    $('#bizRegNo').removeClass('is-invalid');
                    alert("사용 가능한 사업자등록번호입니다.");
                }
            },
            error: function() {
                alert("중복 확인 중 오류가 발생했습니다.");
            }
        });
    }
});



});






</script>