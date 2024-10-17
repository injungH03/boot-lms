<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="wrap">

<div class="head-section">
	<span>&nbsp;<c:out value="${result.title}"/></span>
</div>
<div class="table-section">
	<%@ include file="/WEB-INF/jsp/atos/common/menutab.jsp" %>
    <form id="searchForm" name="searchForm" action="<c:url value='/admin/education/lectureStudentList'/>" method="get">
        <table class="search-table">
            <tr>
                <th class="custom-th-width">수료여부</th>
                <td colspan="2">
	                <div class="form-check form-check-inline">
	                    <input class="form-check-input" id="certAll" type="radio" name="certStatus" value="" <c:if test="${empty searchVO.certStatus}">checked</c:if>>
	                    <label class="form-check-label" for="certAll">전체</label>
	                </div>
	                <div class="form-check form-check-inline">
	                    <input class="form-check-input" id="certY" type="radio" name="certStatus" value="Y" <c:if test="${searchVO.certStatus eq 'Y'}">checked</c:if> >
	                    <label class="form-check-label" for="certY">수료</label>
	                </div>
	                <div class="form-check form-check-inline">
	                    <input class="form-check-input" id="certN" type="radio" name="certStatus" value="N" <c:if test="${searchVO.certStatus eq 'N'}">checked</c:if>>
	                    <label class="form-check-label" for="certN">미수료</label>
	                </div>
                </td>
				<th class="custom-th-width">과정날짜</th>
                <td colspan="3">
                    <div class="d-flex">
                        <input type="date" name="srcLearnDate" class="form-control me-2 " value="${searchVO.srcLearnDate }" />
                    </div>
                </td>
            <tr>
                <th>검색</th>
                <td colspan="5">
                    <div class="d-flex">
						<select name="searchCnd" class="form-select search-select me-2">
                            <option value="">전체</option>
                            <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>과정명</option>
                            <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>소속회사</option>
                            <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>아이디</option>
                            <option value="3" <c:if test="${searchVO.searchCnd == '3'}">selected="selected"</c:if>>이름</option>
                        </select>
                        <input type="text" name="searchWrd" class="form-control search-input me-2" placeholder="검색어를 입력하세요" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="100"/>
                        
                        <button type="submit" class="btn-search">검색</button>
                    </div>
                </td>
            </tr>
        </table>
		<input type="hidden" name="lectureCode" value="${searchVO.lectureCode}">
    </form>


<!-- 테이블 위에 버튼 섹션 -->
<div class="d-flex justify-content-between mb-2 mt-5">
    <div>
        수강생 정원 : <strong>${totalcount } / ${capacity.capacity}</strong>
    </div>
    <div>
    	<button class="btn-create-course" id="studentAdd">수강생추가</button>
        <button class="btn-excel">EXCEL</button>
        <button class="btn-del" id="allDelete">삭제</button>
    </div>
</div>

<div class="course-table-section">
    <table class="table table-bordered table-hover" id="enrollTable">
       <colgroup>
	        <col style="width: 5%;">
	        <col style="width: 25%;">
	        <col style="width: 10%;">
	        <col style="width: 15%;">
	        <col style="width: 10%;">
	        <col style="width: 10%;">
	        <col style="width: 10%;">
	        <col style="width: 5%;">
    	</colgroup>
        <thead>
            <tr>
                <th>No</th>
                <th data-sort="ED.TITLE">과정명</th>
                <th data-sort="EN.MEMBER_ID">아이디</th>
                <th data-sort="S.NAME">이름</th>
                <th data-sort="C.CORP_NAME">소속회사</th>
                <th data-sort="L.LEARN_DATE">과정날짜</th>
                <th data-sort="CE.ISSUE_DATE">발급날짜</th>
                <th data-sort="CE.CERT_STATUS">수료여부</th>
                <th>관리</th>
                <th><input type="checkbox" id="checkAll"></th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${resultList }" var="resultInfo" varStatus="status">
            <tr>
                <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.index + 1}"/></td>
                <td><c:out value="${resultInfo.title }" /></td>
                <td><a href="#" class="student-link" data-key="${resultInfo.memberId }"><c:out value="${resultInfo.memberId }" /></a></td>
                <td><c:out value="${resultInfo.memName }" /></td>
                <td><c:out value="${resultInfo.corpName }" /></td>
                <td><c:out value="${resultInfo.learnDate }" /></td>
                <td><c:out value="${resultInfo.issueDate }" /></td>
                <td>
                	<c:if test="${resultInfo.certStatus eq 'Y' }">수료</c:if>	
                	<c:if test="${resultInfo.certStatus eq 'N' }">미수료</c:if>	
                </td>
                <td>
                <div class="btn-group">
                	<button class="deleteButton" data-key="${resultInfo.enrollCode }">삭제</button>
                </div>
                </td>
                <td><input type="checkbox" name="rowCheck" value=""></td>
            </tr>
        </c:forEach>
           
        <c:if test="${fn:length(resultList) == 0}">
	        <tr>
	            <td colspan="9">조회된 결과가 존재하지 않습니다.</td>
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
</div>
<script>
$(document).ready(function() {
	var lectureCode = $('input[name=lectureCode]').val();
	
	$('#studentAdd').on('click', function() {
		window.open("<c:url value='/admin/education/studentListPopup'/>?lectureCode=" + lectureCode, 'popup', 'width=1200,height=900');
	});
	
    $('.student-link').on('click', function(e) {
        e.preventDefault(); 

        var studentId = $(this).data('student-id');
        var popupUrl = "<c:url value='/admin/education/studentDetailPopup'/>?studentId=" + studentId;
        var popupName = '수강생 정보';
        var popupFeatures = 'width=1200,height=800,scrollbars=yes,resizable=yes';

        window.open(popupUrl, popupName, popupFeatures);
    });
    
	$('.deleteButton').on('click', function(event) {
		event.preventDefault();
		var key = $(this).data('key');
		var isConfirmed = confirm("정말로 삭제하시겠습니까?");
		
		if (isConfirmed) {
	        myFetch({
	            url: '/admin/education/deleteStudent',
	            data: {
	            	enrollCode: key
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

    $('#allDelete').on('click', function(event) {
	    event.preventDefault();
	    
	    var selectedMemberIds = [];
	    var lectureCode = $('input[name=lectureCode]').val();
	    
	    $('tbody input[name="rowCheck"]:checked').each(function() {
	        var memberId = $(this).closest('tr').find('.student-link').data('key');
	        selectedMemberIds.push(memberId);
	    });
	    
	    if (selectedMemberIds.length === 0) {
	        alert('삭제할 학생을 선택해주세요.');
	        return;
	    }

        var isConfirmed = confirm("정말로 삭제하시겠습니까?");
	    
        if (isConfirmed) {
            myFetch({
                url: '/admin/education/delSelectedStudents',
                data: {
                    memberIds: selectedMemberIds,
                    lectureCode: lectureCode
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

	
	
    // 전체 선택/해제 기능
    $('#checkAll').on('click', function() {
        $('tbody input[name="rowCheck"]').prop('checked', this.checked);
    });
         
    var initialSortField = '${searchVO.sortField}';
    var initialSortOrder = '${searchVO.sortOrder}';
	
    handleSort('#enrollTable', '#searchForm', initialSortField, initialSortOrder); 
	
});
</script>