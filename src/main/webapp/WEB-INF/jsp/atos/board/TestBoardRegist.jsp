<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/egovframework/com/cmm/jqueryui.css' />">
<script src="<c:url value='/js/egovframework/com/cmm/jquery.js' />"></script>
<script src="<c:url value='/js/egovframework/com/cmm/jqueryui.js' />"></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/fms/EgovMultiFile.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/utl/EgovCmmUtl.js'/>" ></script>
<script type="text/javascript" src="<c:url value='/html/egovframework/com/cmm/utl/ckeditor/ckeditor.js?t=B37D54V'/>" ></script>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/atos/test/boardtest.css' />">
<script>



function fn_egov_init(){
	
	//filebrowserUploadUrl: '${pageContext.request.contextPath}/utl/wed/insertImage.do', // 파일 업로드를 처리 할 경로 설정.
	var ckeditor_config = {
		//filebrowserImageUploadUrl: '${pageContext.request.contextPath}/utl/wed/insertImageCk.do', // 파일 업로드를 처리 할 경로 설정.
		filebrowserImageUploadUrl: '${pageContext.request.contextPath}/ckUploadImage', // 파일 업로드를 처리 할 경로 설정(CK필터).
	};
	CKEDITOR.replace('content',ckeditor_config);
	
	// 첫 입력란에 포커스
	document.getElementById("boardVO").title.focus();
	

	}
function fn_egov_regist_article(form) {
	CKEDITOR.instances.content.updateElement();
	
	form.submit();

}

$(document).ready(function() {
    fn_egov_init();
});

</script>

</head>
<body>

<!-- javascript warning tag  -->
<noscript class="noScriptTitle"><spring:message code="common.noScriptTitle.msg" /></noscript>

<form:form modelAttribute="boardVO" name="board" action="${pageContext.request.contextPath}/test/insertBoard.do" method="post" onSubmit="fn_egov_regist_article(this);"  enctype="multipart/form-data"> 
<div class="wTableFrm">
	<!-- 타이틀 -->
	<h2>게시글 등록</h2><!-- 게시글 등록 -->

	<!-- 등록폼 -->
	<table class="wTable" >
	<caption>게시글 등록</caption>
	<colgroup>
		<col style="width: 20%;">
		<col style="width: ;">
		<col style="width: ;">
		<col style="width: ;">
	</colgroup>
	<tbody>
		<tr>
			<th><label for="title">제목 <span class="pilsu">*</span></label></th>
			<td class="left">
			    <form:input path="title" title="제목 입력" size="70" maxlength="70" />
			</td>
		</tr>
		<tr>
			<th><label for="content">내용 <span class="pilsu">*</span></label></th>
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
		<tr>
			<th><label for="file_1">첨부파일</label> </th>
			<td class="nopd" colspan="3">
				<input name="file_1" id="egovComFileUploader" type="file" title="첨부파일" multiple/><!-- 첨부파일 -->
			    <div id="egovComFileList"></div>
			</td>
		</tr>

	</tbody>
	</table>

	<!-- 하단 버튼 -->
	<div class="btn">
		<input type="submit" class="s_submit" value="등록" title="등록" />
		<span class="btn_s"><a href="<c:url value='/test/boardList.do'/>">목록</a></span>
	</div><div style="clear:both;"></div>
	
</div>

<input type="hidden" name="pageIndex"  value="<c:out value='${searchVO.pageIndex}'/>"/>
<input type="hidden" id="atchPosblFileNumber" name="atchPosblFileNumber" value="<c:out value='${searchVO.atchPosblFileNumber}'/>" />
<input type="hidden" name="atchPosblFileSize" value="<c:out value='${searchVO.atchPosblFileSize}'/>" />

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
