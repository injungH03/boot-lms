<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/common.css' />">
<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="head-section" style="margin-bottom:20px;">
	<span>&nbsp;업체목록</span>
</div>

<form id="searchForm" name="searchForm" action="<c:url value='/education/lectureList.do'/>" method="get">
<input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">

<div class="table-section">

    <table class="search-table">
        <tr>
             <th class="custom-th-width">상태</th>
             <td colspan="2">
                <div class="d-flex">
                   <select id="status" name="statusCode">
					<option value="">선택</option>
					<c:forEach var="status" items="${status}">
						<option value="${status.statusCode }"
							<c:if test="${status.statusCode == companySearchVO.statusCode}">selected</c:if>>
							${status.statusName }
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
                        <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>회사명</option>
                        <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>담당자명</option>
                        <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>사업자등록번호</option>
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
            Total: <strong>${totalcount}건</strong>
        </div>
        <div>
            <button class="btn-create-course" id="">상태변경</button>
            <button class="btn-excel">EXCEL</button>
            <button class="btn-create-course" id="">업체등록</button>
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
                    <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.index + 1}"/></td>
                    <td class="left"><a href="<c:url value='/admin/company/companyDetail' />?bizRegNo=${resultInfo.bizRegNo}&pageIndex=${searchVO.pageIndex}"><c:out value="${resultInfo.regDate}" /></a></td>
                    <td><c:out value="${resultInfo.corpName}" /></td>
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

<script>
    // 전체 선택/해제 기능
    $('#checkAll').on('click', function() {
        $('tbody input[name="rowCheck"]').prop('checked', this.checked);
    });
</script>