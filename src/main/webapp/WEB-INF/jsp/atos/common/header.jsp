<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<div class="header">
	<a href="" >
		<img src="<c:url value='/images/logo.png'/>" style="height: 5vh;" alt="title logo" title="title logo">
	</a>
	<div class="logo">
		안전교육센터
	</div>
	<nav class="header-links">
		<c:forEach var="menuItem" items="${headerMenus}">
			<a href="<c:url value='${menuItem.url}'/>" class="menu-link" data-menucode="${menuItem.menuCode}">
				<c:out value="${menuItem.menuName}" />
			</a>
		</c:forEach>
	</nav>

	<div class="header-right">
		<span class="welcome-msg">
		    <sec:authentication property="principal.username" /> 님 환영합니다.
		    (<sec:authentication property="authorities" /> )
		</span>
		<form id="logoutForm" action="/admin/logout" method="POST">
		    <a href="#" class="logout-btn" id="logout">로그아웃</a>
		</form>
		<a href="" class="customer-center-btn">헤더타이틀</a>
		<a href="${siteMapUrl}" class="site-btn">사용자화면</a>
	</div>
</div>
<script>
$(document).ready(function () {
    $('#logout').on('click', function() {
        $('#logoutForm').submit();
    });

});
</script>

