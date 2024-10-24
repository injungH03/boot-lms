<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />
<link type="text/css" rel="stylesheet" href="<c:url value='/css/boardtest.css' />">
<div class="board">
    <form:form name="boardForm" id="searchForm" action="<c:url value='/admin/member/boardList'/>" method="get">
        <h1>게시판 목록</h1>
        <div class="search_box">
            <ul>
                <li>
                    <select name="searchCnd" title="검색 조건 선택">
                        <option value="0" <c:if test="${searchVO.searchCnd == '0'}">selected="selected"</c:if>>글제목</option>
                        <option value="1" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>글내용</option>
                        <option value="2" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>작성자</option>
                    </select>
                </li>
                <li>
                    <input class="s_input" name="searchWrd" type="text" size="35" title="검색 조건 입력" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="155" >
                    <input type="submit" class="s_btn" value="조회" title="조회 버튼" />
                    <span class="btn_b"><a href="<c:url value='/test/insertBoardView.do' />" title="등록 버튼">등록</a></span>
                </li>
            </ul>
        </div>
    </form:form>
    
    <table class="board_list">
    <colgroup>
        <col style="width: 10%;">
        <col style="width: 40%;">
        <col style="width: 19%;">
        <col style="width: 19%;">
    </colgroup>
    <thead>
    <tr>
        <th>번호</th>
        <th class="board_th_link">글제목</th>
        <th>작성자명</th>
        <th>작성일</th>
    </tr>
    </thead>
    <tbody class="ov">
        <c:forEach items="${resultList}" var="resultInfo" varStatus="status">
        <tr>
            <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.index + 1}"/></td>
            <td class="left"><a href="<c:url value='/admin/member/boardDetail' />?boardNum=${resultInfo.boardNum}&pageIndex=${searchVO.pageIndex}"><c:out value="${resultInfo.title}" /></a></td>
            <td><c:out value='${resultInfo.writer}'/></td>
            <td><c:out value='${resultInfo.regDate}'/></td>
        </tr>
        </c:forEach>
        <c:if test="${fn:length(resultList) == 0}">
        <tr>
            <td colspan="4">조회된 결과가 존재하지 않습니다.</td>
        </tr>
        </c:if>
    </tbody>
    </table>

    <div class="pagination">
        <pagination:pagination
                paginationInfo="${paginationInfo}"
                jsFunction="fn_select_linkPage"
                formId="searchForm" />
    </div>
</div>
