<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="wTableFrm">
	<!-- 타이틀 -->
	<h2>게시글 상세조회</h2>

	<!-- 상세조회 -->
	<table class="wTable">
	<caption>게시글 상세조회</caption>
	<colgroup>
		<col style="width: ;">
		<col style="width: ;">
		<col style="width: ;">
		<col style="width: ;">
		<col style="width: ;">
		<col style="width: ;">
	</colgroup>
	<tbody>
		<!-- 글 제목 -->
		<tr>
			<th>글제목</th>
			<td colspan="4" class="left"><c:out value="${result.title}"/></td>
		</tr>
		<!-- 작성자, 작성시각, 조회수 -->
		<tr>
			<th>작성자</th>
			<td class="left"><c:out value="${result.writer}"/></td>
		</tr>
		<tr>
			<th>작성일</th>
			<td class="left"><c:out value="${result.regDate}"/></td>
		</tr>
		<!-- 글 내용 -->
		<tr>
			<th class="vtop">글내용</th>
			<td colspan="4" class="cnt">
				<c:out value="${result.content}" escapeXml="false" />
			</td>
		</tr>
		<!-- 첨부파일  -->
<%--		<c:if test="${not empty result.atchFileId}">
		<tr>
			<th>첨부파일</th>
			<td colspan="5">
				<c:import url="/cmm/fms/selectFileInfs.do" charEncoding="utf-8">
				<c:param name="param_atchFileId" value="${egovc:encrypt(result.atchFileId)}" />
			</c:import>
			</td>
		</tr>
	  	</c:if>--%>
		
	</tbody>
	</table>
	
	<!-- 하단 버튼 -->
	<div class="btn">
		<form name="articleForm" action="<c:url value='/test/updateBoardView.do'/>" method="post" style="float:left;">
			<input type="submit" class="s_submit" value="수정" title="수정" /><!-- 수정 -->
			<input type="hidden" name="boardNum" value="${result.boardNum }" />
			<input type="hidden" name="pageIndex" value="${searchVO.pageIndex }" />

		</form>
		<form name="formDelete" action="<c:url value='/cop/bbs/deleteArticle.do'/>" method="post" style="float:left; margin:0 0 0 3px;">
			<input type="submit" class="s_submit" value="삭제" title="삭제" onclick="fn_egov_delete_article(this.form); return false;"><!-- 삭제 -->
<%-- 			<input name="nttId" type="hidden" value="<c:out value="${result.nttId}" />">
			<input name="bbsId" type="hidden" value="<c:out value="${boardMasterVO.bbsId}" />"> --%>
		</form>
		<form name="formList" action="<c:url value='/test/boardList.do'/>" method="post" style="float:left; margin:0 0 0 3px;">
			<input type="submit" class="s_submit" value="목록"><!-- 목록 -->
			<input type="hidden" name="pageIndex" value="${searchVO.pageIndex }" >
		</form>
		
	</div><div style="clear:both;"></div>
	
</div>
