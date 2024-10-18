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

    <div class="head-section" style="margin-bottom:20px;">
        <span>&nbsp;업체 목록</span>
    </div>

    <form id="searchForm" name="searchForm" action="<c:url value='/admin/company/companyList'/>" method="get">
        <input type="hidden" name="pageIndex" value="${companySearchVO.pageIndex}">

        <div class="table-section">
            <table class="search-table">
                <tr>
                    <th class="custom-th-width">상태</th>
                    <td colspan="1">
                        <div class="d-flex">
                            <select name="statusCode" class="form-select search-select me-2">
                                <option value="">전체</option>
                                <c:forEach var="status" items="${status}">
                                    <option value="${status.statusCode}"
                                        <c:if test="${status.statusCode == companySearchVO.statusCode}">selected</c:if>>
                                        ${status.statusName}
                                    </option>
                                </c:forEach>
                            </select>
                        </div>
                    </td>
                </tr>
                <tr>
                    <th>검색</th>
                    <td colspan="5">
                        <div class="d-flex">
                            <select name="searchCnd" class="form-select search-select me-2">
                                <option value="">전체</option>
                                <option value="0" <c:if test="${companySearchVO.searchCnd == '0'}">selected="selected"</c:if>>회사명</option>
                                <option value="1" <c:if test="${companySearchVO.searchCnd == '1'}">selected="selected"</c:if>>담당자명</option>
                                <option value="2" <c:if test="${companySearchVO.searchCnd == '2'}">selected="selected"</c:if>>사업자등록번호</option>
                            </select>
                            <input type="text" name="searchWrd" class="form-control search-input me-2" placeholder="검색어를 입력하세요" value='<c:out value="${companySearchVO.searchWrd}"/>' maxlength="100"/>
                            <button type="submit" class="btn-search">검색</button>
                        </div>
                    </td>
                </tr>
            </table>

            <!-- 테이블 위에 버튼 섹션 -->
            <div class="d-flex justify-content-between mb-2 mt-5">
                <div>
                    Total: <strong>${totalcount}건</strong>
                </div>
                <div>
                    <button class="btn-create-course" id="statusUpdateBtn">상태변경</button>
                    <button class="btn-excel" id="excelDownloadBtn">EXCEL</button>
                    <button class="btn-create-course" id="registerCompanyBtn">업체등록</button>
                </div>
            </div>

            <!-- 업체 테이블 섹션 -->
            <div class="course-table-section">
                <table class="table table-bordered table-hover" id="companyTable">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th data-sort="">등록일</th>
                            <th data-sort="">회사명</th>
                            <th data-sort="">사업자등록번호</th>
                            <th data-sort="">인원수</th>
                            <th data-sort="">담당자</th>
                            <th data-sort="">상태</th>
                            <th><input type="checkbox" id="checkAll"/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                            <tr>
                                <td><c:out value="${(companySearchVO.pageIndex-1) * companySearchVO.pageSize + status.index + 1}"/></td>
                                <td><c:out value="${resultInfo.regDate}" /></td>
                                <td>
                                    <a href="<c:url value='/admin/company/companyDetail' />?bizRegNo=${resultInfo.bizRegNo}&pageIndex=${companySearchVO.pageIndex}">
                                        <c:out value="${resultInfo.corpName}" />
                                    </a>
                                </td>
                                <td><c:out value="${resultInfo.bizRegNo}" /></td>
                                <td><c:out value="${resultInfo.empCount}" /></td>
                                <td><c:out value="${resultInfo.trainManager}" /></td>
                                <td><c:out value="${resultInfo.statusName}" /></td>
                                <td><input type="checkbox" name="rowCheck" value="${resultInfo.bizRegNo}"/></td>
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
            <div class="pagination justify-content-center">
                <pagination:pagination paginationInfo="${paginationInfo}" jsFunction="fn_select_linkPage" formId="searchForm" />
            </div>

        </div>
    </form>

</div>



<!-- 상태 변경 모달 -->
<div id="statusModal" class="modal fade" tabindex="-1" aria-labelledby="statusModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="statusModalLabel">상태 변경</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body" id="modalContent">
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status1" value="1002" checked>
            <label class="form-check-label" for="status1">정상</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status2" value="1001">
            <label class="form-check-label" for="status2">대기</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status3" value="1004">
            <label class="form-check-label" for="status3">정지</label>
        </div>
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status4" value="1003">
            <label class="form-check-label" for="status4">휴면</label>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="confirmStatusChangeBtn">확인</button>
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
      </div>
    </div>
  </div>
</div>



<script>
$(document).ready(function() {
     // 전체 선택/해제 기능
    $('#checkAll').on('click', function() {
        $('tbody input[name="rowCheck"]').prop('checked', this.checked);
    });

    // 상태변경 버튼 클릭 시 모달 열기
    $('#statusUpdateBtn').on('click', function(event) {
        event.preventDefault(); // 기본 폼 제출 방지

        var selectedBizNos = [];
        $('tbody input[name="rowCheck"]:checked').each(function() {
            selectedBizNos.push($(this).val());
        });

        if (selectedBizNos.length > 0) {
            // 선택된 사업자 번호가 있는 경우에만 모달을 띄움
            $('#statusModal').data('bizNos', selectedBizNos).modal('show');
        } else {
            alert("상태를 변경할 업체를 선택해주세요.");
        }
    });

    // 상태 변경 확인 버튼 클릭 시 AJAX 요청
    $('#confirmStatusChangeBtn').on('click', function() {
        var selectedStatus = $('input[name="statusRadio"]:checked').val();
        var selectedBizNos = $('#statusModal').data('bizNos');

        if (!selectedStatus) {
            alert("변경할 상태를 선택해주세요.");
            return;
        }

        // AJAX 요청으로 상태 변경
        $.ajax({
            url: '<c:url value="/admin/company/updateStatus"/>',
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                bizRegNos: selectedBizNos.join(','), // 선택된 사업자등록번호들을 전송
                status: selectedStatus // 선택된 상태 값
            }),
            success: function(response) {
                if (response.status) { // ResponseVO의 'status' 필드 확인
                    alert('상태 변경이 완료되었습니다.');
                    location.reload(); // 페이지 새로고침하여 변경 사항 반영
                } else {
                    alert('상태 변경에 실패했습니다: ' + response.message);
                }
            },
            error: function() {
                alert('서버와의 통신에 실패했습니다.');
            }
        });

        // 모달 닫기
        $('#statusModal').modal('hide');
    });

    // 엑셀 다운로드 버튼 클릭 시
    $('#excelDownloadBtn').on('click', function() {
        // 현재 검색 조건을 유지하며 엑셀 다운로드 요청
        var form = $('#searchForm');
        var action = form.attr('action');
        var queryString = form.serialize();
        window.location.href = '<c:url value="/admin/company/companyListExcelDown"/>' + '?' + queryString;
    });


    $('#registerCompanyBtn').on('click', function(event){
        event.preventDefault();
        window.location.href = "<c:url value='/admin/company/companyRegistView'/>";
    });   





    // // 페이지네이션 함수 정의
    // window.fn_select_linkPage = function(formId, pageNo) {
    //     var form = $('#' + formId);
    //     form.find('input[name="pageIndex"]').val(pageNo);
    //     form.submit();
    // };







});







</script>
