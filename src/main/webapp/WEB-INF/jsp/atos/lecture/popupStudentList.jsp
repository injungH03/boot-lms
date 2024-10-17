<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layoutPopup.jsp" />
    <div class="popup-wrapper">
     <form id="searchForm" name="searchForm" method="get" action="<c:url value='/admin/education/studentListPopup'/>" class="form-inline mb-3">
		<!-- <input type="hidden" name="pageIndex" value="${searchVO.pageIndex}"> -->
    	<input type="hidden" name="lectureCode" value="${searchVO.lectureCode}">
		<table class="search-table">
             <tr>
                <th>소속</th>
                <td colspan="2">
	                <select id="biz" name="bizRegNo" class="form-select search-select">
	                    <option value="">선택</option>
	                    <c:forEach var="company" items="${biz }">
	                    	<option value="${company.bizRegNo }" <c:if test="${company.bizRegNo == searchVO.bizRegNo}">selected</c:if>>
	                    		${company.corpName }
	                    	</option>
	                    </c:forEach>
	                </select>
                </td>
            </tr>
            <tr>
                <th>검색</th>
                <td colspan="5">
                    <div class="d-flex">
		               <select name="searchCnd" title="검색 조건 선택" class="form-select search-select me-2">
		                	<option value="">선택</option>
		                    <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>아이디</option>
		                    <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>이름</option>
		                </select>
                        <input type="text" name="searchWrd" class="form-control search-input me-2" placeholder="검색어를 입력하세요" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="100"/>
                        <button type="submit" class="btn-search">검색</button>
                    </div>
                </td>
            </tr>
        </table>
    </form>
    
		<div class="d-flex justify-content-between mb-2 mt-5">
		    <div>
		        Total: <strong>${totalCount }</strong>
		    </div>
		    <div>
		    	<button class="btn-create-course" id="addSelected">선택추가</button>
		    </div>
		</div>        
        <table class="table table-bordered course-table table-hover" id="studentTable">
	        <colgroup>
		        <col style="width: 5%;">
		        <col style="width: 10%;">
		        <col style="width: 20%;">
		        <col style="width: 15%;">
		        <col style="width: 10%;">
		        <col style="width: 10%;">
		        <col style="width: 10%;">
	    	</colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th data-sort="C.CORP_NAME">소속</th>
                    <th data-sort="S.ID">아이디</th>
                    <th data-sort="S.NAME">이름</th>
                    <th>전화번호</th>
                    <th>추가</th>
                    <th><input type="checkbox" id="checkAll"></th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${resultList }" var="resultInfo" varStatus="status">
            	<tr>
            		<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.index + 1}"/></td>
            		<td><c:out value="${resultInfo.corpName }" /></td>
            		<td><c:out value="${resultInfo.memberId }" /></td>
            		<td><c:out value="${resultInfo.memName }" /></td>
            		<td><c:out value="${resultInfo.phoneNo }" /></td>
            		<td>
	            		<div class="btn-group">
	                		<button class="addButton" data-key="${resultInfo.memberId }">추가</button>
	                	</div>
            		</td>
            		<td><input type="checkbox" name="rowCheck" value=""></td>
            	</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
		        <tr>
		            <td colspan="7">조회된 결과가 존재하지 않습니다.</td>
		        </tr>
	        </c:if>

            </tbody>
        </table>
		<!-- 페이지네이션 -->
		<div class="pagination">
			<pagination:pagination
					paginationInfo="${paginationInfo}"
					jsFunction="fn_select_linkPage"
					formId="searchForm" />
		</div>    

    </div>

<script>
$(document).ready(function() {
	$('#checkAll').on('click', function() {
	    $('tbody input[name="rowCheck"]').prop('checked', this.checked);
	});
	
	$('#biz').on('change', function() {
		$('#searchForm').submit();
	});
	
	$('.addButton').on('click', function(event) {
		event.preventDefault();
		var key = $(this).data('key');
		var lectureCode = $('input[name=lectureCode]').val();
		
        myFetch({
            url: '/admin/education/addStudent',
            data: {
            	memberId: key,
            	lectureCode: lectureCode
            },
            success: function(response) {
                alert(response.message);
                window.location.reload();
                
                if (window.opener != null && !window.opener.closed) {
                	 window.opener.location.reload();
                    //window.close();
                }
            },
            error: function(error) {
                console.error('오류 발생:', error);
                alert('추가가 실패하였습니다.');
            }
        });
	});
	
	$('#addSelected').on('click', function(event) {
	    event.preventDefault();
	    
	    var selectedMemberIds = [];
	    var lectureCode = $('input[name=lectureCode]').val();
	    
	    $('tbody input[name="rowCheck"]:checked').each(function() {
	        var memberId = $(this).closest('tr').find('.addButton').data('key');
	        selectedMemberIds.push(memberId);
	    });
	    
	    if (selectedMemberIds.length === 0) {
	        alert('추가할 학생을 선택해주세요.');
	        return;
	    }
	    
	    myFetch({
	        url: '/admin/education/addSelectedStudents',
	        data: {
	            memberIds: selectedMemberIds,
	            lectureCode: lectureCode
	        },
	        success: function(response) {
	            alert(response.message);
	            window.location.reload();  // 팝업 창 리로드
	            
	            if (window.opener != null && !window.opener.closed) {
	                window.opener.location.reload();  // 부모 페이지 리로드
	            }
	        },
	        error: function(error) {
	            console.error('오류 발생:', error);
	            alert('추가가 실패하였습니다.');
	        }
	    });
	});
	
	
    var initialSortField = '${searchVO.sortField}';
    var initialSortOrder = '${searchVO.sortOrder}';
	
    handleSort('#studentTable', '#searchForm', initialSortField, initialSortOrder); 
	
});

</script>
</body>
</html>