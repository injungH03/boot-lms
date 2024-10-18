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
	<span>&nbsp;업체 상세정보</span>
</div>
<div class="table-section">

<table class="search-table detail-table">
            <tr>
                <th>업체명</th>
                <td><c:out value="${company.corpName}" /></td>
                <th>대표자명</th>
                <td><c:out value="${company.repName}" /></td>
            </tr>
            <tr>
                <th>사업자등록번호</th>
                <td><c:out value="${company.bizRegNo}" /></td>
                <th>전화번호</th>
                <td><c:out value="${company.phoneNo}" /></td>
            </tr>
            <tr>
                <th>업태</th>
                <td><c:out value="${company.bizType}" /></td>
                <th>종목</th>
                <td><c:out value="${company.bizItem}" /></td>
            </tr>
            <tr>
                <th>팩스번호</th>
                <td><c:out value="${company.faxNo}" /></td>
                <th>세금계산서 이메일</th>
                <td><c:out value="${company.taxInvoice}" /></td>
            </tr>
            <tr>
                <th>직원수</th>
                <td><c:out value="${company.empCount}" /></td>
                <th>교육인원수</th>
                <td><c:out value="${company.trainCount}" /></td>
            </tr>
            <tr>
                <th>주소(우편번호)</th>
                <td colspan="3">
                    <c:out value="${company.zipcode}" />
                    <c:out value="${company.addr1}" /> <c:out value="${company.addr2}" />
                </td>
            </tr>
            <tr>
                <th>메모</th>
                <td colspan="3">
                    <div class="text-container">
                        <c:out value="${company.memo}" />
                    </div>
                </td>
            </tr>
            <tr>
                <th>교육 담당자명</th>
                <td colspan="3"><c:out value="${company.trainManager}" /></td>
            </tr>
            <tr>
                <th>교육 담당자 이메일</th>
                <td><c:out value="${company.trainEmail}" /></td>
                <th>교육 담당자 휴대폰</th>
                <td><c:out value="${company.trainPhone}" /></td>
            </tr>
            <tr>
                <th>계산서 담당자명</th>
                <td colspan="3"><c:out value="${company.taxManager}" /></td>
            </tr>
            <tr>
                <th>계산서 담당자 이메일</th>
                <td><c:out value="${company.taxEmail}" /></td>
                <th>계산서 담당자 휴대폰</th>
                <td><c:out value="${company.taxPhone}" /></td>
            </tr>
        </table>

        <div class="mt-3">
            <button type="button" class="btn btn-success me-2" id="updateButton">수정</button>
            <button type="button" class="btn btn-secondary me-2" id="listButton">목록</button>
            <button type="button" class="btn btn-danger" id="deleteButton" style="float:right">삭제</button>
        </div>
</div>


</div>


<script>

document.addEventListener('DOMContentLoaded', function() {
    // 수정 버튼 클릭 시 업체 수정 페이지로 이동
    document.getElementById('updateButton').addEventListener('click', function() {
        var bizRegNo = '<c:out value="${company.bizRegNo}" />';
        window.location.href = "<c:url value='/admin/company/companyUpdateView' />?bizRegNo=" + bizRegNo;
    });

    // 목록 버튼 클릭 시 목록 페이지로 이동
    document.getElementById('listButton').addEventListener('click', function() {
        window.location.href = "<c:url value='/admin/company/companyList' />";
    });



 // 삭제 버튼 클릭 시 AJAX 요청을 통해 업체 삭제
    document.getElementById('deleteButton').addEventListener('click', function() {
        if (confirm("정말 삭제하시겠습니까?")) {
            var bizRegNo = '<c:out value="${company.bizRegNo}" />';
            fetch('<c:url value="/admin/company/deleteCompany" />', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ bizRegNo: bizRegNo })
            })
            .then(response => response.json())
            .then(data => {
                console.log("Response from server: ", data);  // 서버 응답 확인
                if (data.status === true) {  // boolean 타입으로 status 체크
                    alert('삭제가 완료되었습니다.');
                    window.location.href = "<c:url value='/admin/company/companyList' />";
                } else {
                    alert('삭제에 실패했습니다: ' + data.message);
                }
            })
            .catch(error => {
                console.error('삭제 중 오류 발생:', error);
                alert('삭제에 실패했습니다.');
            });
        }
    });



   
});





</script>