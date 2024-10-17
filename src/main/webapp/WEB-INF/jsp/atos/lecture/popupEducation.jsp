<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layoutPopup.jsp" />
<div class="popup-wrapper">
	<form id="searchForm" name="searchForm" action="<c:url value='/admin/education/educationPopup'/>" method="get">
		<input type="hidden" id="srcMainCode" name="srcMainCode"  value="" />
    	       
	<div class="tab-section" style="margin-bottom:20px;">
		
	    <ul class="nav nav-tabs">
	       <li class="nav-item" role="presentation">
	            <button class="nav-link ${(searchVO.srcMainCode == null || searchVO.srcMainCode == '') ? 'active' : ''}"  type="button"  >전체</button>
	        </li>
	    <c:forEach items="${categoryList }" var="category">
	        <li class="nav-item" role="presentation">
	            <button class="nav-link ${category.mainCode == searchVO.srcMainCode ? 'active' : ''}"  type="button" data-category-id="${category.mainCode}" >${category.mainName }</button>
	        </li>
	    </c:forEach>
	    </ul>
	</div>
		<table class="search-table" style="margin-bottom:30px;">
            <tr>
                <th>검색</th>
                <td colspan="5">
                    <div class="d-flex">
		               <select name="searchCnd" title="검색 조건 선택" class="form-select search-select me-2">
		                	<option value="">선택</option>
		                    <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>교육명</option>
		                    <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>교육시간</option>
		                </select>
                        <input type="text" name="searchWrd" class="form-control search-input me-2" placeholder="검색어를 입력하세요" value='<c:out value="${searchVO.searchWrd}"/>' />
                        <button type="submit" class="btn-search">검색</button>
                    </div>
                </td>
            </tr>
        </table>
    
        
        <table class="table table-bordered course-table table-hover" id="eduTable">
	        <colgroup>
		        <col style="width: 5%;">
		        <col style="width: 10%;">
		        <col style="width: 10%;">
	    	</colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th data-sort="TITLE">교육명</th>
                    <th data-sort="TRAINING_TIME">교육시간</th>
                </tr>
            </thead>
            <tbody>
            <c:forEach items="${resultList }" var="resultInfo" varStatus="status">
            	<tr data-title="${resultInfo.title}" data-key="${resultInfo.eduCode}">
            		<td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.index + 1}"/></td>
            		<td><c:out value="${resultInfo.title }" /></td>
            		<td><c:out value="${resultInfo.trainingTime }" />시간</td>
            	</tr>
			</c:forEach>
			<c:if test="${fn:length(resultList) == 0}">
		        <tr>
		            <td colspan="3">조회된 결과가 존재하지 않습니다.</td>
		        </tr>
	        </c:if>
            </tbody>
        </table>
   </form>     
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
	$('.nav-link').click(function() {
	    var categoryId = $(this).data('category-id');
	    $('#srcMainCode').val(categoryId);
	
	    $('#searchForm').submit();
	});
	
    var initialSortField = '${searchVO.sortField}';
    var initialSortOrder = '${searchVO.sortOrder}';
	
    handleSort('#eduTable', '#searchForm', initialSortField, initialSortOrder);

    $('#eduTable tbody').on('click', 'tr', function() {
        var title = $(this).data('title');
        var key = $(this).data('key');
        
        if (window.opener && !window.opener.closed) {
            window.opener.document.getElementById('selectedEduInfo').innerText = title;
            window.opener.document.getElementById('selectedEduKey').value = key;
            window.opener.$('.popup-add-span').css({
                'color': 'black',
                'font-weight': 'bold'
            });
        }
        
        window.close();
    });


});
</script>
</body>
</html>