<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="page" value="lecture" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery.js'/>" ></script>
    <script type="text/javascript" src="<c:url value='/js/atos/common/fetchFunction.js'/>" ></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/atos/lecture/lecture.css' />">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <title>수강정보</title>
</head>
<body>
	<div class="menu-section">
	    <ul class="nav nav-tabs" id="infoTab" role="tablist">
	        <li class="nav-item" role="presentation">
	            <a class="nav-link <c:if test="${page == 'member'}">active</c:if>" id="member-info-tab" href="<c:url value='/education/studentDetailPopup.do'/>" role="tab">회원정보</a>
	        </li>
	        <li class="nav-item" role="presentation">
	            <a class="nav-link <c:if test="${page == 'lecture'}">active</c:if>" id="lecture-info-tab" href="<c:url value='/education/studentLecturePopup.do'/>" role="tab">수강정보</a>
	        </li>
	        <li class="nav-item" role="presentation">
	            <a class="nav-link" id="additional-info-tab" href="#" role="tab">추가정보</a>
	        </li>
	    </ul>
	</div>
    <!-- 콘텐츠 영역 -->
    <div class="popup-wrapper">

	    <div class="menu-span">
			<span>수강 중인 과정</span>
		</div>
        <table class="table table-bordered course-table">
	        <colgroup>
		        <col style="width: 5%;">
		        <col style="width: 10%;">
		        <col style="width: 20%;">
		        <col style="width: 15%;">
		        <col style="width: 10%;">
	    	</colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>구분</th>
                    <th>과정명</th>
                    <th>과정날짜</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
            	<tr>
            		<td>1</td>
            		<td>관리감독자</td>
            		<td>테스트과정1</td>
            		<td>2024-10-11</td>
            		<td>미수료</td>
            	</tr>

            </tbody>
        </table>
        
        <div class="menu-span">
			<span>종료된 과정</span>
		</div>
        <table class="table table-bordered course-table">
	        <colgroup>
		        <col style="width: 5%;">
		        <col style="width: 10%;">
		        <col style="width: 20%;">
		        <col style="width: 15%;">
		        <col style="width: 10%;">
	    	</colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>구분</th>
                    <th>과정명</th>
                    <th>과정날짜</th>
                    <th>상태</th>
                </tr>
            </thead>
            <tbody>
            	<tr>
            		<td>1</td>
            		<td>관리감독자</td>
            		<td>테스트과정1</td>
            		<td>2024-10-11</td>
            		<td>미수료</td>
            	</tr>

            </tbody>
        </table>
    </div>

    <!-- jQuery를 사용하여 메뉴 탭 클릭 시 active 효과 적용 -->
<script>
    $(document).ready(function() {
/*         $('.nav-link').on('click', function(e) {
            e.preventDefault(); // 기본 링크 동작 방지

            // 모든 탭에서 active 클래스 제거
            $('.nav-link').removeClass('active');

            // 클릭된 탭에 active 클래스 추가
            $(this).addClass('active');

            var target = $(this).attr('id');
            if(target === 'member-info-tab') {
                window.location.href = "<c:url value='/education/studentDetailPopup.do'/>";
            } else if(target === 'lecture-info-tab') {
                window.location.href = "<c:url value='/education/studentLecturePopup.do'/>";
            } else if(target === 'additional-info-tab') {
                window.location.href = '';
            }
        }); */
    });
</script>
</body>
</html>
