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
	<span>&nbsp;집합과정운영</span>
</div>

<form id="searchForm" name="searchForm" action="<c:url value='/admin/education/lectureList'/>" method="get">
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">
<div class="tab-section">

<input type="hidden" id="srcMainCode" name="srcMainCode"  value="" />
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

<div class="table-section">

        <table class="search-table">
            <tr>
                <th class="custom-th-width">신청시작/종료일</th>
                 <td colspan="2">
                    <div class="d-flex">
                        <span>시작일 :</span><input type="date" name="srcStartDate" id="startDate" class="form-control me-2 custom-width" value="${searchVO.srcStartDate }"/>
						<span class="span-ml">종료일 :</span><input type="date" name="srcEndDate" id="endDate" class="form-control me-2 custom-width" value="${searchVO.srcEndDate }"/>
                    </div>
                </td>
                <th class="custom-th-width">과정날짜</th>
                <td colspan="3">
                    <div class="d-flex">
                        <input type="date" name="srcLearnDate" id="learningStartDate" class="form-control me-2 " value="${searchVO.srcLearnDate }" />
                    </div>
                </td>
            </tr>
            <tr>
                <th>검색</th>
                <td colspan="5">
                    <div class="d-flex">
                        <select name="searchCnd" class="form-select search-select me-2">
                            <option value="">전체</option>
                            <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>배정강사</option>
                            <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>과정명</option>
                        </select>
                        <input type="text" name="searchWrd" class="form-control search-input me-2" placeholder="검색어를 입력하세요" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="100"/>
                        <button type="submit" class="btn-search">검색</button>
                    </div>
                </td>
            </tr>
        </table>
    

<!-- 테이블 위에 버튼 섹션 -->
<div class="d-flex justify-content-between mb-2 mt-5">
    <div>
        Total: <strong>${totalcount }건</strong>
    </div>
    <div>
        <button type="button" class="btn-create-course" id="regist">과정개설</button>
        <button type="button" class="btn-excel" id="excelDown">EXCEL</button>
    </div>
</div>

<!-- 과정 테이블 섹션 -->
<div class="course-table-section">
    <table class="table table-bordered table-hover" id="lectureTable">
        <thead>
            <tr>
                <th>No</th>
                <th data-sort="E.TITLE">과정명</th>
                <th data-sort="I.NAME">배정 강사명</th>
                <th data-sort="E.TRAINING_TIME">교육시간</th>
                <th data-sort="L.ENROLLED">인원수</th>
                <th data-sort="L.REC_START_DATE">접수 신청 기간</th>
                <th data-sort="L.LEARN_DATE">과정날짜</th>
                <th>상태</th>
                <th>관리</th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${resultList }" var="resultInfo" varStatus="status">
            <tr >
                <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.index + 1}"/></td>
                <td class="left"><a href="<c:url value='/admin/education/lectureDetail'/>?lectureCode=${resultInfo.lectureCode }&pageIndex=${searchVO.pageIndex}"><c:out value="${resultInfo.title }" /></a></td>
                <td>
                <c:if test="${empty resultInfo.instructorName }">
                	<div class="btn-group">
                    	<button class="instructorButton" data-key="${resultInfo.lectureCode }" data-type="C">강사 배정</button>
                    </div>
                </c:if>
                	<c:out value="${resultInfo.instructorName }" />
                </td>
                <td><c:out value="${resultInfo.trainingTime }" /></td>
                <td><c:out value="${resultInfo.enrolled }" />/<c:out value="${resultInfo.capacity }" /></td>
                <td>
                	<c:out value="${fn:substring(resultInfo.recStartDate, 0, 10)}" /> ~
    				<c:out value="${fn:substring(resultInfo.recEndDate, 0, 10)}" />
    			</td>
                <td><c:out value="${resultInfo.learnDate }" /></td>
                <td><c:out value="${resultInfo.learnStatus }" /></td>
                <td>
                    <div class="btn-group">
                    	<button class="instructorButton" data-key="${resultInfo.lectureCode }" data-type="U">강사 수정</button>
                        <button class="deleteButton" data-key="${resultInfo.lectureCode }">삭제</button>
                    </div>
                </td>
            </tr>
		</c:forEach>

        <c:if test="${fn:length(resultList) == 0}">
	        <tr>
	            <td colspan="8">조회된 결과가 존재하지 않습니다.</td>
	        </tr>
        </c:if>

        </tbody>
    </table>
</div>
    <!-- 페이지네이션 -->
    <div class="pagination">
        <pagination:pagination
                paginationInfo="${paginationInfo}"
                jsFunction="fn_select_linkPage"
                formId="searchForm" />
    </div>  

</div>
</form>

</div>

<script>
$(document).ready(function() {
	var pageIndex = $('input[name="pageIndex"]').val();
	
	$('.instructorButton').on('click', function() {
		var key = $(this).data('key');
		var type = $(this).data('type');
		window.open("<c:url value='/admin/education/instructorPopup'/>?lectureCode=" + key + "&type=" + type + "&pageIndex=" + pageIndex, 'popup', 'width=1200,height=800');
	});
	
	$('.deleteButton').on('click', function(event) {
		event.preventDefault();
		var key = $(this).data('key');
		var isConfirmed = confirm("정말로 삭제하시겠습니까?");
		
		if (isConfirmed) {
	        myFetch({
	            url: '/admin/education/deleteLecture',
	            data: {
	            	lectureCode: key
	            },
	            success: function(response) {
	                alert(response.message);
	                window.location.reload();
	            },
	            error: function(error) {
	                console.error('오류 발생:', error);
	                alert('삭제가 실패하였습니다.');
	            }
	        });
		}
	});
	
	$('#regist').on('click', function(event){
		event.preventDefault();
		window.location.href = "<c:url value='/admin/education/lectureRegist'/>";
	});
	

    $('.nav-link').click(function() {
/*         $('.nav-link').removeClass('active');
        
        $(this).addClass('active'); */

        var categoryId = $(this).data('category-id');
        $('#srcMainCode').val(categoryId);

        // form 전송
        $('#searchForm').submit();
    });

    $('#excelDown').on('click', function() {
        const searchForm = $('#searchForm');
        const originalAction = searchForm.attr('action');

        searchForm.attr('action', '/admin/education/lectureListExcelDown');

        searchForm.submit();

        searchForm.attr('action', originalAction);
    });
    
    var initialSortField = '${searchVO.sortField}';
    var initialSortOrder = '${searchVO.sortOrder}';
	
    handleSort('#lectureTable', '#searchForm', initialSortField, initialSortOrder);
    

});
</script>