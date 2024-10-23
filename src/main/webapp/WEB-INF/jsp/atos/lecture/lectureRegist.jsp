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
	<span>&nbsp;과정개설</span>
</div>
<div class="table-section">

    <form id="registForm" method="post" enctype="multipart/form-data">
        <table class="search-table regist-table">
            <tr>
                <th>교육정보</th>
                <td colspan="3">
                    <input type="button" class="btn btn-sm btn-primary" value="교육정보 선택" id="eduInfoButton" />
                    <span class="popup-add-span" id="selectedEduInfo"></span>
                    <input type="hidden" id="selectedEduKey" name="education" value="" />
                </td>
            </tr>
            <tr>
                <th>교육장소</th>
                <td colspan="3">
				<div>
                    <input type="text" id="address" name="location" class="form-control me-2 custom-width" placeholder="주소를 검색해주세요" readonly /><br />
                    <input type="text"id="detailedAddress" name="locationDetail" class="form-control mt-2 custom-width" placeholder="상세주소를 입력하세요" maxlength="30" />
                </div>
                <div class="mt-2">
                    <button type="button" class="btn btn-sm btn-primary" id="addressSearchButton">주소검색</button>
                </div>
                </td>
            </tr>



            <tr>
                <th>접수 시작일</th>
                <td>
                    <div class="d-flex">
                        <input type="date" name="recStartDate" class="form-control me-2" />
                    </div>
                </td>
                <th>접수 종료일</th>
                <td>
                    <div class="d-flex">
                        <input type="date" name="recEndDate" class="form-control me-2" />
                    </div>
                </td>
 
            </tr>
            <tr>
            	<th>과정 날짜</th>
                <td>
                    <div class="d-flex">
                        <input type="date" name="learnDate" class="form-control me-2" />
                    </div>
                </td>
                <th>모집 인원수</th>
                <td>
                    <input type="number" name="capacity" class="form-control custom-width" min="1" max="100"  />
                </td>  
            </tr>
            <tr>
                <th>시작시간</th>
                <td><input type="time" name="startTime" class="form-control custom-width" /></td>
                <th>종료시간</th>
                <td><input type="time" name="endTime" class="form-control custom-width" /></td>
            </tr>
            <tr>
            	<th>담당자</th>
            	<td><input type="text" name="manager" class="form-control custom-width" placeholder="담당자를 입력하세요" maxlength="10" /></td>
                <th>연락처</th>
            	<td><input type="text" name="managerContact" class="form-control custom-width" placeholder="연락처를 입력하세요" /></td>
            </tr>
			<tr>
			    <th>파일</th>
			    <td colspan="3">
			        <input name="file_1" id="egovComFileUploader" class="file-button" type="file" title="첨부파일" multiple />
			        <div id="egovComFileList" class="file-list"></div>
			    </td>
			</tr>

        </table>

        <!-- 등록 및 목록 버튼 -->
        <div class="d-flex justify-content-between mt-3">
            <button type="submit" class="btn btn-success" id="submitBtn">등록</button>
            <button type="button" class="btn btn-secondary" id="btnList">목록</button>
        </div>

        <input type="hidden" id="atchPosblFileNumber" name="atchPosblFileNumber" value="${searchVO.atchPosblFileNumber}" />
        <input type="hidden"  name="type" value="C" />
    </form>
</div>
</div>

<script>
$(document).ready(function() {
	autoHyphenForPhone('input[name="managerContact"]');
	
	$.validator.addMethod("phoneFormat", function(value, element) {
	    return this.optional(element) || /^010-\d{4}-\d{4}$/.test(value);
	}, "전화번호는 010-XXXX-XXXX 형식이어야 합니다.");
	
	
    $("#registForm").validate({
        rules: {
            location: {
                required: true  // 주소는 필수 입력
            },
            regStartDate: {
                required: true,  // 접수 시작일 필수
                date: true       // 날짜 형식 확인
            },
            regEndDate: {
                required: true,  // 접수 종료일 필수
                date: true       // 날짜 형식 확인
            },
            learnDate: {
                required: true,  // 과정 날짜 필수
                date: true       // 날짜 형식 확인
            },
            capacity: {
                required: true,  // 모집 인원수 필수
                number: true,    // 숫자만 허용
                min: 1,          // 최소 1명
                max: 100         // 최대 100명
            },
            startTime: {
                required: true,  // 시작 시간 필수
            },
            endTime: {
                required: true,  // 종료 시간 필수
            },
            manager: {
                required: true,  // 담당자 필수 입력
                minlength: 2     // 최소 2글자 이상
            },
            managerContact: {
                required: true,   // 연락처 필수 입력
                phoneFormat: true     // 전화번호 형식 확인
            }
        },
        messages: {
            location: "주소를 검색 해주세요.",
            regStartDate: "접수 시작일을 선택 해주세요.",
            regEndDate: "접수 종료일을 선택 해주세요.",
            learnDate: "과정 날짜를 선택 해주세요.",
            capacity: {
                required: "모집 인원을 입력 해주세요.",
                number: "숫자를 입력 해주세요.",
                min: "최소 1명 이상 입력 해주세요.",
                max: "최대 100명까지 입력 가능합니다."
            },
            startTime: "시작 시간을 입력 해주세요.",
            endTime: "종료 시간을 입력 해주세요.",
            manager: "담당자를 입력 해주세요.",
            managerContact: "올바른 연락처를 입력 해주세요."
        },
        
    });
    

    
    $('#submitBtn').click(function(event) {
    	event.preventDefault();
    	
    	var eduKey = $('#selectedEduKey').val();
   	    var eduInfoText = $('#selectedEduInfo').text().trim();  

   	    $('#selectedEduInfo').css('color', '');  

   	    if (eduKey.trim() === "" || eduInfoText === "") {
   	        $('#selectedEduInfo').css('color', 'red').text('교육정보를 선택해주세요.');
   	        $('#selectedEduInfo').css('font-size', '12px');
   	        $('.popup-add-span').css('font-weight', 'normal');
   	        return;  
   	    }
    	
        if ($("#registForm").valid()) {
        	
            myFetch({
                url: '/admin/education/saveLecture',
                data: 'registForm',
                isFormData: true,    // FormData로 전송 (파일전송시)
                success: function(response) {
                    alert(response.message);
                    window.location.href = "<c:url value='/admin/education/lectureList'/>";
                },
                error: function(error) {
                    console.error('등록 중 오류 발생:', error);
                    alert('등록이 실패하였습니다.');
                }
            });
        } else {
            //alert("유효성 검사를 통과하지 못했습니다. 입력 값을 확인해주세요.");
            event.preventDefault(); 
        }

    });
    
	
	$('#btnList').on('click', function(event){
		event.preventDefault();
		window.location.href = "<c:url value='/admin/education/lectureList'/>";
	});
	
	//팝업 이동 URL
	$('#eduInfoButton').on('click', function() {
		 window.open("<c:url value='/admin/education/educationPopup'/>", 'popup', 'width=1200,height=800');
	});

	
	//다중 파일 업로드 처리
	// var maxFileNum = document.getElementById('atchPosblFileNumber').value;
	// if(maxFileNum==null || maxFileNum==""){
	// 	maxFileNum = 3;
	// }
	// var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
	// multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );

    $('#addressSearchButton').on('click', function() {
        new daum.Postcode({
            oncomplete: function(data) {
                $('#address').val(data.address); // 기본 주소
                $('#detailedAddress').focus();
            }
        }).open();
    });
    
});
</script>