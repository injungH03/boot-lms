<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layoutPopup.jsp" />
    <div class="popup-wrapper">
    <form id="searchForm" name="searchForm" method="get" action="<c:url value='/admin/education/instructorPopup'/>" class="form-inline mb-3">
		<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">
    	<input type="hidden" name="lectureCode" value="${searchVO.lectureCode}">
    	<input type="hidden" name="type" value="${searchVO.type}">
		<table class="search-table">
            <tr>
                <th>검색</th>
                <td colspan="5">
                    <div class="d-flex">
		               <select name="searchCnd" title="검색 조건 선택" class="form-select search-select me-2">
		                	<option value="">선택</option>
		                    <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>아이디</option>
		                    <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>이름</option>
		                </select>
                        <input type="text" name="searchWrd" class="form-control search-input me-2" placeholder="검색어를 입력하세요" value='<c:out value="${searchVO.searchWrd}"/>' />
                        <button type="submit" class="btn-search">검색</button>
                    </div>
                </td>
            </tr>
        </table>
        
 		<div class="d-flex justify-content-between mb-2 mt-5">
		    <div>
<!-- 		        Total: <strong>38건</strong>-->		    
			</div>
		    <div>
		    	<button class="btn-create-course" id="studentAdd">선택추가</button>
		    </div>
		</div> 
        
        <table class="table table-bordered course-table table-hover" id="insTable">
	        <colgroup>
		        <col style="width: 5%;">
		        <col style="width: 15%;">
		        <col style="width: 10%;">
		        <col style="width: 15%;">
		        <col style="width: 15%;">
		        <col style="width: 10%;">
		        <col style="width: 10%;">
	    	</colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>아이디</th>
                    <th>이름</th>
                    <th>전화번호</th>
                    <th>이메일</th>
                    <th>소속</th>
                    <th>직책</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${resultList }" var="resultInfo" varStatus="status">
            	<tr>
            		<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.index + 1}"/></td>
            		<td><c:out value="${resultInfo.id }" /></td>
            		<td><c:out value="${resultInfo.instructorName }" /></td>
            		<td><c:out value="${resultInfo.phoneNo }" /></td>
            		<td><c:out value="${resultInfo.email }" /></td>
            		<td><c:out value="${resultInfo.department }" /></td>
            		<td><c:out value="${resultInfo.position }" /></td>
            	</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
		        <tr>
		            <td colspan="7">조회된 결과가 존재하지 않습니다.</td>
		        </tr>
	        </c:if>
            </tbody>
        </table>
   </form>

    </div>

<script>
$(document).ready(function() {
	var pageIndex = $('input[name="pageIndex"]').val();
	var lectureCode = $('input[name="lectureCode"]').val();
	var type = $('input[name="type"]').val();
	
	$('#insTable tbody tr').on('click', function() {
		const instructorId = $(this).find('td').eq(1).text();
		
        myFetch({
            url: '/admin/education/instructorPopupSave', 
            data: { 
            	lectureCode: lectureCode,
                id: instructorId,
                type: type
            }, 
            success: function(response) {
                alert(response.message);
                
                if (window.opener != null && !window.opener.closed) {
                    window.opener.fn_select_linkPage("searchForm" ,pageIndex);
                    window.close();
                }
                
            },
            error: function(error) {
                console.error('강사 배정 오류:', error);
            }
        });
	
	       
	});
	
	
});
</script>


</body>
</html>