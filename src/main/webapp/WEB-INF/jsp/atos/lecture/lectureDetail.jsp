<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="wrap">

<div class="head-section">
	<span>&nbsp;<c:out value="${result.title}"/> </span>
</div>
<div class="table-section">
	<%@ include file="/WEB-INF/jsp/atos/common/menutab.jsp" %>
	<table class="search-table detail-table">
		<tr>
			<th>교육명</th>
			<td><c:out value="${result.title}"/></td>
			<th>교육형태</th>
			<td><c:out value="${result.mainName}"/>/<c:out value="${result.subName}"/></td>
		</tr>
		<tr>
			<th>과정목표</th>
			<td colspan="3">
				<div class="text-container">
					<p><c:out value="${result.objective}"/></p>
				</div>
			</td>
		</tr>
		<tr>
			<th>과정소개</th>
			<td colspan="3">
				<div class="text-container">
					<p><c:out value="${result.description}"/></p>
				</div>
			</td>
		</tr>
		<tr>
			<th>교육장소</th>
			<td colspan="3"><c:out value="${result.location}"/> <c:out value="${result.locationDetail}"/></td>
		</tr>
		<tr>
			<th>배정강사</th>
			<td><c:out value="${result.instructorName}"/></td>
			<th>인원수</th>
			<td><c:out value="${result.enrolled}"/> / <c:out value="${result.capacity}"/></td>
		</tr>
		<tr>
			<th>접수시작일</th>
			<td><c:out value="${fn:substring(result.recStartDate, 0, 10)}"/></td>
			<th>접수종료일</th>
			<td><c:out value="${fn:substring(result.recEndDate, 0, 10)}"/></td>
		</tr>
		<tr>
			<th>과정날짜</th>
			<td><c:out value="${result.learnDate}"/></td>
			<th>과정 총시간</th>
			<td><c:out value="${result.trainingTime}"/></td>
		</tr>		

		<tr>
			<th>시작시간</th>
			<td><c:out value="${result.startTimeFormat}"/></td>
			<th>종료시간</th>
			<td><c:out value="${result.endTimeFormat}"/></td>
		</tr>
		<tr>
			<th>담당자</th>
			<td><c:out value="${result.manager}"/></td>
			<th>연락처</th>
			<td><c:out value="${result.managerContact}"/></td>
		</tr>
		<tr>
			<th>첨부파일</th>
			<td colspan="3">
				<!-- <c:if test="${not empty result.atchFileId}">
					<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
						<c:param name="param_atchFileId"
							value="" />
					</c:import>
				</c:if> -->
			</td>
		</tr>
	</table>

        <div class="mt-3">
            <button type="submit" class="btn btn-success me-2" id="Updt">수정</button>
            <button type="button" class="btn btn-secondary me-2" id="list">목록</button>
            <button type="button" class="btn btn-danger" id="deleteButton" style="float:right">삭제</button>
        </div>
</div>
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">
<input type="hidden" name="lectureCode" value="${searchVO.lectureCode}">
</div>
<!-- jQuery Script -->
<script>
$(document).ready(function() {
	$('#Updt').on('click', function() {
		event.preventDefault();
		const lectureCode = $('input[name=lectureCode]').val();
		window.location.href = "<c:url value='/admin/education/lectureUpdt'/>?lectureCode=" + lectureCode;
		
	});
	$('#list').on('click', function() {
		event.preventDefault();
		const pageIndex = $('input[name=pageIndex]').val();
		window.location.href = "<c:url value='/admin/education/lectureList'/>?pageIndex=" + pageIndex;
		
	});
	
	$('#deleteButton').on('click', function(event) {
		event.preventDefault();
		const lectureCode = $('input[name=lectureCode]').val();
		var isConfirmed = confirm("정말로 삭제하시겠습니까?");
		
		if (isConfirmed) {
	        myFetch({
	            url: '/admin/education/deleteLecture',
	            data: {
	            	lectureCode: lectureCode
	            },
	            success: function(response) {
	                alert(response.message);
	                window.location.href = "<c:url value='/admin/education/lectureList'/>?pageIndex=" + pageIndex;
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