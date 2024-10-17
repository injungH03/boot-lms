<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<c:set var="page" value="member" />
<!DOCTYPE html>
<html lang="ko">
<head>
    <script type="text/javascript" src="<c:url value='/js/egovframework/com/cmm/jquery.js'/>" ></script>
    <script type="text/javascript" src="<c:url value='/js/atos/common/fetchFunction.js'/>" ></script>
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
	<link type="text/css" rel="stylesheet" href="<c:url value='/css/atos/lecture/lecture.css' />">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <meta charset="UTF-8">
    <title>회원정보</title>
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
			<span>회원정보 상세 조회</span>
		</div>
        <table class="search-table detail-table">
            <tr>
                <th>아이디</th>
                <td><c:out value="${member.id }" /></td>
                <th>생년월일</th>
                <td><c:out value="${member.birthdate }" /></td>
            </tr>
            <tr>
                <th>이름</th>
                <td><c:out value="${member.name }" /></td>
                <th>주소</th>
                <td><c:out value="${member.addr1 }" />&nbsp;<c:out value="${member.addr2 }" /></td>
            </tr>
            <tr>
                <th>전화번호</th>
                <td><c:out value="${member.phone }" /></td>
                <th>이메일</th>
                <td><c:out value="${member.email }" /></td>
            </tr>
            <tr>
                <th>우편번호</th>
                <td><c:out value="${member.postalCode }" /></td>
                <th>소속기업</th>
                <td><c:out value="${member.company }" /></td>
            </tr>
            <tr>
                <th>소속부서</th>
                <td><c:out value="${member.department }" /></td>
                <th>직책</th>
                <td><c:out value="${member.position }" /></td>
            </tr>
            <tr>
                <th>사업자등록번호</th>
                <td><c:out value="${member.businessNumber }" /></td>
                <th>대표전화번호</th>
                <td><c:out value="${member.representativePhone }" /></td>
            </tr>
            <tr>
                <th>사업장명</th>
                <td><c:out value="${member.businessName }" /></td>
                <th>대표자명</th>
                <td><c:out value="${member.representativeName }" /></td>
            </tr>
            <tr>
                <th>업태</th>
                <td><c:out value="${member.businessType }" /></td>
                <th>종목</th>
                <td><c:out value="${member.item }" /></td>
            </tr>
            <tr>
                <th>사업장주소</th>
                <td colspan="3"><c:out value="${member.businessAddress }" /></td>
            </tr>
        </table>
    </div>

    <!-- jQuery를 사용하여 메뉴 탭 클릭 시 active 효과 적용 -->
    <script>
        $(document).ready(function() {
/*             $('.nav-link').on('click', function(e) {
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
