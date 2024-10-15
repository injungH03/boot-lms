<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ckeditor" uri="http://ckeditor.com" %>
<%@ taglib prefix="egovc" uri="/WEB-INF/tlds/egovc.tld" %>
<!DOCTYPE html>
<html>
<head>
<title>${pageTitle }<spring:message code="title.update" /></title><!-- 게시글 답글 수정-->
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/jqueryui.css' />">
<link type="text/css" rel="stylesheet" href="<c:url value='/css/atos/test/boardtest.css' />">
<%-- <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFiles.js'/>" ></script> --%>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/utl/EgovCmmUtl.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>" ></script>
<script src="<c:url value='/js/egovframework/com/cmm/jquery.js' />"></script>
<script src="<c:url value='/js/egovframework/com/cmm/jqueryui.js' />"></script>
<script type="text/javascript">

/* ********************************************************
 * 초기화
 ******************************************************** */
function fn_egov_init() {
	
	var ckeditor_config = {
			filebrowserImageUploadUrl: '${pageContext.request.contextPath}/utl/wed/insertImageCk.do', // 파일 업로드를 처리 할 경로 설정.
		};

	CKEDITOR.replace('content',ckeditor_config);

	// 첫 입력란에 포커스..
	document.getElementById("TestBoardVO").title.focus();
}
/* ********************************************************
 * 저장처리화면
 ******************************************************** */
function fn_egov_updt_article(form) {
	
	CKEDITOR.instances.content.updateElement();
	
	form.submit();
}

</script>
</head>
<body onLoad="fn_egov_init();">

	<!-- javascript warning tag  -->
	<noscript class="noScriptTitle">	<spring:message code="common.noScriptTitle.msg" />	</noscript>

	<!-- 상단타이틀 -->
	<form:form modelAttribute="boardVO" action="${pageContext.request.contextPath}/test/updateBoard.do" method="post" onSubmit="fn_egov_updt_article(this);" enctype="multipart/form-data">
		<div class="wTableFrm">
			<h2>게시글 수정</h2>

			<!-- 수정폼 -->
			<table class="wTable">
				<caption>게시글 수정</caption>
				<colgroup>
					<col style="width: 20%;">
					<col style="width:;">
					<col style="width:;">
					<col style="width:;">
				</colgroup>
				<tbody>
					<tr>
						<th><label for="title">제목<span class="pilsu">*</span></label></th>
						<td class="left">
							<form:input path="title" title="제목 입력" size="70" maxlength="70" />
						</td>
					</tr>
					<!-- 글 내용  -->
					<tr>
						<th><label for="content">내용<span class="pilsu">*</span></label></th>
						<td class="nopd" colspan="3">
							<form:textarea path="content" title="내용 입력" id="content" cols="300" rows="20" />
						</td>
					</tr>
					<tr>
						<th><label for="writer">글쓴이 <span class="pilsu">*</span></label></th>
						<td class="left">
							<form:input path="writer" title="글쓴이" size="70" maxlength="50" />  
						</td>
					</tr>
					
					<!-- 첨부파일 시작 -->
					<c:set var="title">첨부파일</c:set>
					<tr>
						<th>첨부파일</th>
						<td class="nopd" colspan="3">
							<c:import url="/cmm/fms/selectFileInfsForUpdate.do" charEncoding="utf-8">
								<c:param name="param_atchFileId" value="${egovc:encrypt(boardVO.atchFileId)}" />
							</c:import>
						</td>
					</tr>
					<!-- 첨부파일 끝 -->
					<!-- 첨부파일 추가 시작 -->
					<c:set var="title">첨부파일 추가</c:set>
					<tr>
						<th><label for="file_1">첨부파일 추가</label> </th>
						<td class="nopd" colspan="3">
							<input name="file_1" id="egovComFileUploader" type="file" title="첨부파일" multiple/><!-- 첨부파일 -->
						    <div id="egovComFileList"></div>
						</td>
					</tr>
					<!-- 첨부파일 추가 끝 -->

				</tbody>
			</table>

			<!-- 하단 버튼 -->
			<div class="btn">
				<input type="submit" class="s_submit" value="수정" title="수정" /><!-- 수정 -->
				<span class="btn_s"><a href="<c:url value='/test/boardList.do'/>?pageIndex=${searchVO.pageIndex }">목록</a></span>
				<span class="btn_s"><a href="javascript:history.back();">취소</a></span>
			</div>
			<div style="clear: both;"></div>

		</div>

		<input name="pageIndex" type="hidden" value="<c:out value='${searchVO.pageIndex}'/>" />
		<input type="hidden" id="atchPosblFileNumber" name="atchPosblFileNumber" value="<c:out value='${searchVO.atchPosblFileNumber}'/>" />
		<input type="hidden" name="atchPosblFileSize" value="<c:out value='${searchVO.atchPosblFileSize}'/>" />
		<input type="hidden" name="atchFileId" value="<c:out value='${boardVO.atchFileId}'/>" />
		<input type="hidden" name="boardNum" value="<c:out value='${boardVO.boardNum}'/>" />
	</form:form>

<!-- 첨부파일 업로드 가능화일 설정 Start..-->  
<script type="text/javascript">
var maxFileNum = document.getElementById('atchPosblFileNumber').value;
if(maxFileNum==null || maxFileNum==""){
	maxFileNum = 3;
}
var multi_selector = new MultiSelector( document.getElementById( 'egovComFileList' ), maxFileNum );
multi_selector.addElement( document.getElementById( 'egovComFileUploader' ) );
</script> 
<!-- 첨부파일 업로드 가능화일 설정 End.-->
</body>
</html>
