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
	<span>&nbsp;회원목록</span>
</div>

<form id="searchForm" name="searchForm" action="<c:url value='/admin/member/memberList'/>" method="get">
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">

<div class="table-section">

        <table class="search-table">
            <tr>
                <th class="custom-th-width">업체</th>
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
                <th class="custom-th-width">상태</th>
                <td>
                    <select id="status" name="statusCode" class="form-select">
                        <option value="">선택</option>
                        <c:forEach var="status" items="${status }">
                            <option value="${status.statusCode }" <c:if test="${status.statusCode == searchVO.statusCode}">selected</c:if>>
                                    ${status.statusName }
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>
            <tr>
                <th>검색</th>
                <td colspan="5">
                    <div class="d-flex">
                        <select name="searchCnd" class="form-select search-select me-2">
                            <option value="">전체</option>
                            <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>아이디</option>
                            <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>이름</option>
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
        <button type="button" class="btn-create-course" id="statusUpdate">상태변경</button>
        <button type="button" class="btn-create-course" id="AllRegist">일괄등록</button>
        <button type="button" class="btn-create-course" id="regist">등록</button>
        <button type="button" class="btn-excel" id="excelDown">EXCEL</button>
    </div>
</div>

<!-- 과정 테이블 섹션 -->
<div class="course-table-section">
    <table class="table table-bordered table-hover" id="memberTable">
        <colgroup>
            <col style="width: 5%;">
            <col style="width: 20%;">
            <col style="width: 10%;">
            <col style="width: 15%;">
            <col style="width: 10%;">
            <col style="width: 10%;">
            <col style="width: 5%;">
        </colgroup>
        <thead>
            <tr>
                <th>No</th>
                <th class="board_th_link">아이디</th>
                <th>이름</th>
                <th>전화번호</th>
                <th>소속</th>
                <th>상태</th>
                <th><input type="checkbox" id="checkAll"></th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${resultList }" var="resultInfo" varStatus="status">
            <tr >
                <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.index + 1}"/></td>
                <td class="left"><a href="<c:url value='/admin/member/memberDetail' />?id=${resultInfo.id }&pageIndex=${searchVO.pageIndex}"><c:out value="${resultInfo.id }" /></a></td>
                <td><c:out value="${resultInfo.name }" /></td>
                <td><c:out value="${resultInfo.phoneNo }" /></td>
                <td><c:out value="${resultInfo.corpName }" /></td>
                <td><c:out value="${resultInfo.listStatusName }" /></td>
                <td><input type="checkbox" name="rowCheck" value="${resultInfo.id }"></td>
            </tr>
		</c:forEach>

        <c:if test="${fn:length(resultList) == 0}">
	        <tr>
	            <td colspan="7">조회된 결과가 존재하지 않습니다.</td>
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

<div id="statusModal" class="modal fade" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="statusModalLabel">상태 변경</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="modalContent">
                <div class="d-flex justify-content-around">
                    <div class="form-check me-3">
                        <input class="form-check-input" type="radio" name="statusRadio" id="status1" value="1002" checked>
                        <label class="form-check-label" for="status1">정상</label>
                    </div>
                    <div class="form-check me-3">
                        <input class="form-check-input" type="radio" name="statusRadio" id="status2" value="1004">
                        <label class="form-check-label" for="status2">정지</label>
                    </div>
                    <div class="form-check">
                        <input class="form-check-input" type="radio" name="statusRadio" id="status3" value="1003">
                        <label class="form-check-label" for="status3">휴면</label>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
                <button type="button" class="btn btn-primary" id="confirmChangeBtn">확인</button>
            </div>
        </div>
    </div>
</div>

<script>
$(document).ready(function() {
	var pageIndex = $('input[name="pageIndex"]').val();

    //등록 이동
    $('#regist').on('click', function() {
        window.location.href = "<c:url value='/admin/member/memberRegistView'/>";
    });
    //일괄 등록 이동
    $('#AllRegist').on('click', function() {
        window.location.href = "<c:url value='/admin/member/memberAllRegistView'/>";
    });
    // 업체 셀렉트 박스 변경 시
    $('#group').change(function() {
        $('#searchForm').submit();
    });

    // 상태 셀렉트 박스 변경 시
    $('#status').change(function() {
        $('#searchForm').submit();
    });

    // 전체 선택/해제 기능
    $('#checkAll').on('click', function() {
        $('tbody input[name="rowCheck"]').prop('checked', this.checked);
    });

    // 상태변경 버튼 클릭 시
    $('#statusUpdate').on('click', function() {
        var selectedData = [];

        $('tbody input[name="rowCheck"]:checked').each(function() {
            var tr = $(this).closest('tr');
            var id = tr.find('td:nth-child(2)').text(); //
            selectedData.push(id);
        });

        if (selectedData.length > 0) {
            $('#statusModal').modal('show');
        } else {
            alert("선택된 항목이 없습니다.");
        }
    });

    // 확인 버튼 클릭 시 상태 변경 처리
    $('#confirmChangeBtn').on('click', function() {
        var selectedStatus = $('input[name="statusRadio"]:checked').val();
        var selectedIds = [];

        $('tbody input[name="rowCheck"]:checked').each(function() {
            var id = $(this).closest('tr').find('td:nth-child(2)').text();
            selectedIds.push(id);
        });

        if (selectedIds.length > 0) {
            myFetch({
                url: '/admin/member/updateStatus',
                data: {
                    ids: selectedIds.join(','),
                    status: selectedStatus
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
            // 모달 닫기
            $('#statusModal').modal('hide');
        } else {
            alert("선택된 항목이 없습니다.");
        }
    });

    $('#excelDown').on('click', function() {
        const searchForm = $('#searchForm');
        const originalAction = searchForm.attr('action');

        searchForm.attr('action', '/admin/member/memberListExcelDown');

        searchForm.submit();

        searchForm.attr('action', originalAction);
    });

    <%--var initialSortField = '${searchVO.sortField}';--%>
    <%--var initialSortOrder = '${searchVO.sortOrder}';--%>
	
    <%--handleSort('#lectureTable', '#searchForm', initialSortField, initialSortOrder);--%>
    

});
</script>