<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="wrap">

<div class="head-section">
	<span>강사 상세</span>
</div>
<div class="table-section">
	<table class="search-table detail-table">
		<tr>
			<th>아이디</th>
			<td colspan="3"><c:out value="${member.id }" /></td>

		</tr>
		<tr>
			<th>이름</th>
			<td><c:out value="${member.name }" /></td>
            <th>생년월일</th>
            <td><c:out value="${member.birthdate }" /></td>
		</tr>
		<tr>
		    <th>주소</th>
            <td colspan="3"><c:out value="${member.addr1 }" />&nbsp;<c:out value="${member.addr2 }" /></td>
		</tr>
		<tr>
			<th>우편번호</th>
        	<td><c:out value="${member.zipcode }" /></td>
			<th>전화번호</th>
			<td><c:out value="${member.phoneNo }" /></td>

		</tr>
		<tr>
			<th>이메일</th>
			<td><c:out value="${member.email }" /></td>
			<th>직업</th>
			<td><c:out value="${member.job }" /></td>
		</tr>
		<tr>
			<th>소속부서</th>
			<td><c:out value="${member.department }" /></td>
			<th>직책</th>
			<td><c:out value="${member.position }" /></td>
		</tr>
		<tr>
		    <th>강사소개</th>
		    <td colspan="3"><c:out value="${member.bios }" /></td>
		</tr>
		<tr>
		    <th>경력사항</th>
		    <td colspan="3"><c:out value="${member.career }" /></td>
		</tr>
	</table>

        <div class="mt-3">
            <button type="submit" class="btn btn-success me-2" id="Updt">수정</button>
            <button type="button" class="btn btn-secondary me-2" id="list">목록</button>
            <button type="button" class="btn btn-danger" id="deleteButton" style="float:right">삭제</button>
        </div>
</div>
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">
</div>

<script>
$(document).ready(function() {
	$('#Updt').on('click', function() {
		const memId = '<c:out value="${member.id }" />';
		window.location.href = "<c:url value='/admin/member/instructorUpdateView' />?id=" + memId;
		
	});
	$('#list').on('click', function() {
		const pageIndex = $('input[name=pageIndex]').val();
		window.location.href = "<c:url value='/admin/member/instructorList'/>?pageIndex=" + pageIndex;
		
	});
	
	$('#deleteButton').on('click', function(event) {
		event.preventDefault();
		var isConfirmed = confirm("정말로 삭제하시겠습니까?");
		const memId = '<c:out value="${member.id }" />';
		const pageIndex = $('input[name=pageIndex]').val();

		if (isConfirmed) {
	        myFetch({
	            url: '/admin/member/memberDelete',
	            data: {
					id: memId
	            },
	            success: function(response) {
	                alert(response.message);
	                window.location.href = "<c:url value='/admin/member/instructorList'/>?pageIndex=" + pageIndex;
	            },
	            error: function(error) {
	                console.error('오류 발생:', error);
	                alert('삭제가 실패하였습니다.');
	            }
	        });
		}
	});
    
});
</script>