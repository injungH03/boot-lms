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
        <span>&nbsp;교육 과정 목록</span>
    </div>

    <form id="searchForm" name="searchForm" action="<c:url value='/admin/education/educationList'/>" method="get">
        <input type="hidden" name="pageIndex" value="${educationSearchVO.pageIndex}">

  

<!-- 검색 조건 섹션 -->
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
                                        <c:if test="${status.statusCode == educationSearchVO.statusCode}">selected</c:if>>
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
                                <option value="0" <c:if test="${educationSearchVO.searchCnd == '0'}">selected="selected"</c:if>>교육명</option>
                                <option value="1" <c:if test="${educationSearchVO.searchCnd == '1'}">selected="selected"</c:if>>교육시간</option>
                                <option value="2" <c:if test="${educationSearchVO.searchCnd == '2'}">selected="selected"</c:if>>등록일</option>
                            </select>
                            <input type="text" name="searchWrd" class="form-control search-input me-2"
                                   placeholder="검색어를 입력하세요" value='<c:out value="${educationSearchVO.searchWrd}"/>' maxlength="100"/>
                            <button type="submit" class="btn-search">검색</button>
                        </div>
                    </td>
                </tr>
            </table>



<!-- 테이블 위에 버튼 섹션 -->
            <div class="d-flex justify-content-between mb-2 mt-5">
                <div>
                Total: <strong>${paginationInfo.totalRecordCount}건</strong>
                </div>
                <div>
                    <button class="btn-create-course" id="statusUpdateBtn">상태변경</button>
                    <button class="btn-excel" id="excelDownloadBtn">EXCEL</button>
                    <button class="btn-create-course" id="registerCourseBtn">과정등록</button>
                </div>
            </div>

     <!-- 교육 과정 목록 테이블 섹션 -->
            <div class="course-table-section">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>등록일</th>
                            <th>교육 분류</th>
                            <th>교육명</th>
                            <th>교육 시간</th>
                            <th>등록자</th>
                            <th>상태</th>
                            <th><input type="checkbox" id="checkAll"/></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
                            <tr>
                                <td><c:out value="${(educationSearchVO.pageIndex-1) * educationSearchVO.pageSize + status.index + 1}"/></td>
                                <td><c:out value="${resultInfo.regDate}" /></td>
                                <td>
                                    ${resultInfo.mainName}<c:if test="${resultInfo.subName != null && !resultInfo.subName.isEmpty()}"> > ${resultInfo.subName}</c:if>
                                </td>
                                <td><a href="<c:url value='/admin/education/educationDetail?eduCode=${resultInfo.eduCode}'/>">${resultInfo.title}</a></td>
                                <td><c:out value="${resultInfo.trainingTime}" /></td>
                                <td><c:out value="${resultInfo.register}" /></td>
                                <td><c:out value="${resultInfo.statusName}" /></td>
                                <td><input type="checkbox" name="rowCheck" value="${resultInfo.eduCode}"/></td>
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
        <!-- 교육중 상태 -->
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status1" value="4001" checked>
            <label class="form-check-label" for="status1">교육중</label>
        </div>
        <!-- 폐강 상태 -->
        <div class="form-check">
            <input class="form-check-input" type="radio" name="statusRadio" id="status2" value="4002">
            <label class="form-check-label" for="status2">폐강</label>
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

        var selectedEduCodes = [];
        $('tbody input[name="rowCheck"]:checked').each(function() {
            selectedEduCodes.push($(this).val());
        });

        if (selectedEduCodes.length > 0) {
            // 선택된 교육 코드가 있는 경우에만 모달을 띄움
            $('#statusModal').data('eduCodes', selectedEduCodes).modal('show');
        } else {
            alert("상태를 변경할 교육 과정을 선택해주세요.");
        }
    });


    // 상태변경 확인 버튼 클릭 시
    $('#confirmStatusChangeBtn').on('click', function() {
        var selectedStatus = $('input[name="statusRadio"]:checked').val();
        var selectedEduCode = [];
        $('input[name="rowCheck"]:checked').each(function() {
            selectedEduCode.push($(this).val());
        });

        if (selectedEduCode.length > 0) {
            $.ajax({
                url: '/admin/education/updateStatus',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({
                    eduCodes: selectedEduCode,
                    status: selectedStatus
                }),
                success: function(response) {
                    if (response.httpStatus === 'OK') {
                        alert('상태 변경이 완료되었습니다.');
                        location.reload();
                    } else {
                        alert('상태 변경에 실패했습니다.');
                    }
                },
                error: function() {
                    alert('서버와의 통신에 실패했습니다.');
                }
            });
            $('#statusModal').modal('hide');
        } else {
            alert("선택된 항목이 없습니다.");
        }
    });

    // Excel 다운로드 기능
    $('#excelDownloadBtn').on('click', function() {
        $('#searchForm').attr('action', '/admin/education/educationListExcelDown').submit();
    });

     // 과정 등록 버튼 클릭 시 등록 페이지로 이동
    $('#registerCourseBtn').on('click', function(event){
    event.preventDefault(); // 기본 동작 방지
    window.location.href = "<c:url value='/admin/education/educationRegistView'/>";
    });

});
</script>