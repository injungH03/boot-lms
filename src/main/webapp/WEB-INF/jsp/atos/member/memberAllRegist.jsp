<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="wrap">

<div class="head-section">
	<span>&nbsp;회원 일괄 등록[엑셀 등록]</span>
</div>

<div class="table-section">

        <table class="search-table">
            <tr>
                <th colspan="2">1. 회원 샘플양식을 다운로드 받아 작성한 후 업로드 하십시오.</th>
            </tr>
            <tr>
                <th colspan="2">2. 업로드 된 회원 정보를 확인 한 후 등록하기 버튼을 클릭하면 회원등록이 완료 됩니다.</th>
            </tr>
            <tr>
                <th>엑셀 업로드</th>
                <td>
                    <form id="excelUploadForm" enctype="multipart/form-data">
                        <div class="form-group">
                            <input type="file" class="form-control widthAuto" id="uploadFile" name="file">
                            <small class="form-text text-muted">
                                <!-- 업로드 파일은 샘플양식(*.xls) 파일만 가능합니다.  -->복수 시트는 지원하지 않습니다.
                            </small>
                        </div>
                    </form>
                    <button class="btn btn-secondary" id="sampleExcel">샘플양식 다운로드</button>
                </td>
            </tr>
            <tr>
                <th class="custom-th-width">회원소속</th>
                 <td>
                     <select id="group" name="corpBiz" class="form-select">
                         <option value="">선택</option>
                         <c:forEach var="company" items="${company }">
                             <option value="${company.corpBiz }" <c:if test="${company.corpBiz == searchVO.corpBiz}">selected</c:if>>
                                     ${company.corpName }
                             </option>
                         </c:forEach>
                     </select>
                </td>
            </tr>
        </table>
    

<!-- 테이블 위에 버튼 섹션 -->
<div class="d-flex justify-content-between mb-2 mt-5">
    <div>
        <!-- Total: <strong>${totalcount }건</strong> -->
    </div>
    <div>
        <button type="button" class="btn-create-course" id="member-List">목록</button>
        <button type="button" class="btn-create-course" id="preview">미리보기</button>
        <button type="button" class="btn-create-course" id="save">등록</button>
    </div>
</div>

<!-- 과정 테이블 섹션 -->
<div class="course-table-section">
    <table class="table table-bordered table-hover">
        <thead>
            <tr>
                <th>이름</th>
                <th>생년월일</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>소속부서</th>
                <th>직책</th>
            </tr>
        </thead>
        <tbody id="previewTableBody">
        </tbody>
    </table>
</div>

<div id="pagination" class="pagination">
</div>

</div>
</div>

<script>
let previewData = [];
const pageSize = 10;  // 한 페이지에 보여줄 데이터 수
let currentPage = 1;

function goToPage(pageNumber) {
    currentPage = pageNumber;
    updateTable();
}

function updateTable() {
    var tableBody = $('#previewTableBody');
    tableBody.empty();

    // 현재 페이지에서 보여줄 데이터의 범위 설정
    let start = (currentPage - 1) * pageSize;
    let end = start + pageSize;
    let pagedData = previewData.slice(start, end);

    // 테이블에 데이터 추가
    pagedData.forEach(function(member) {
        var row = '<tr>' +
            '<td>' + member.name + '</td>' +
            '<td>' + member.birthdate + '</td>' +
            '<td>' + member.phoneNo + '</td>' +
            '<td>' + member.email + '</td>' +
            '<td>' + member.department + '</td>' +
            '<td>' + member.position + '</td>' +
            '</tr>';
        tableBody.append(row);
    });
}

function createPagination() {
    var totalPages = Math.ceil(previewData.length / pageSize);
    var pagination = $('#pagination');
    pagination.empty();  // 기존 페이징 버튼 초기화

    for (let i = 1; i <= totalPages; i++) {
        var pageItem = '<button class="btn btn-light" onclick="goToPage(' + i + ')">' + i + '</button>';
        pagination.append(pageItem);
    }
}    
$(document).ready(function() {
    $('#sampleExcel').on('click', function(){
		window.location.href = "<c:url value='/admin/member/sampleExcelDown'/>";
	});
	
	$('#member-List').on('click', function(){
		window.location.href = "<c:url value='/admin/member/memberList'/>";
	});
	
	$('#preview').on('click', function(){
	    var fileInput = $('#uploadFile').get(0); 
	    if (!fileInput.files || fileInput.files.length === 0) {
	        alert("업로드할 파일을 선택해주세요.");
	        return; 
	    }
		
	    myFetch({
	        url: '/admin/member/uploadExcel',  
	        isFormData: true,     
	        data: 'excelUploadForm', 
	        success: function(response) {
	        	previewData = [];
	        	
	            previewData = response.result;
	            
	            //console.log(">>>>" + JSON.stringify(previewDzata));
	            
	            currentPage = 1;  
	            updateTable();   
	            createPagination();  
	        },
	        error: function(err) {
	            alert("엑셀 파일을 업로드하는 중 오류가 발생했습니다: " + err);
	        }
	    });
	});
	
	$('#save').on('click', function(){
		const selectedCorpBiz = $('#group').val();
		
	 	if (!selectedCorpBiz) { 
	        alert("회원 소속을 선택해주세요.");
	        return; 
	    }
		
		const sendData = {
			previewData: previewData,
		    corpBiz: selectedCorpBiz  
		};
		
	    myFetch({
	        url: '/admin/member/memberAllSave',
	        data: sendData,
	        success: function(response) {
	            alert("회원 정보가 성공적으로 등록되었습니다.");
	        },
	        error: function(err) {
	            alert("회원 정보 등록 중 오류가 발생했습니다: " + err);
	        }
	    });
		
	});	
    

});
</script>