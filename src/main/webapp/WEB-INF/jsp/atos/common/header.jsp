<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="java.time.Instant" %>
<%
    long lastAccessedTime = session.getLastAccessedTime();
    int maxInactiveInterval = session.getMaxInactiveInterval();
    long expiryTime = lastAccessedTime + (maxInactiveInterval * 1000L);
%>
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
		    (<sec:authentication property="authorities" /> )<br>
		    남은 세션 시간: <span id="session-timer"></span>
		</span>
		<form id="logoutForm" action="/admin/logout" method="POST">
		    <a href="#" class="logout-btn" id="logout">로그아웃</a>
		</form>
		<a href="" class="customer-center-btn">헤드버튼</a>
		<a href="${siteMapUrl}" class="site-btn">사용자화면</a>
	</div>
</div>
<script>
$(document).ready(function () {
    $('#logout').on('click', function(e) {
        e.preventDefault();
        $('#logoutForm').submit();
    });

   var sessionExpiryTime = <%= expiryTime %>;

   function startTimer(expiryTime, display) {
       if (window.sessionTimerInterval) {
           clearInterval(window.sessionTimerInterval);
       }

       function updateTimer() {
           var currentTime = new Date().getTime();
           var remaining = Math.floor((expiryTime - currentTime) / 1000); // 초 단위
           if (remaining <= 0) {
               display.textContent = "세션이 만료되었습니다.";
               clearInterval(window.sessionTimerInterval);
               window.location.href = "/admin/logout";
               return;
           }
           var minutes = Math.floor(remaining / 60);
           var seconds = remaining % 60;
           minutes = minutes < 10 ? "0" + minutes : minutes;
           seconds = seconds < 10 ? "0" + seconds : seconds;
           display.textContent = minutes + ":" + seconds;
       }

       updateTimer();
       window.sessionTimerInterval = setInterval(updateTimer, 1000);
   }

   var display = document.getElementById('session-timer');
   startTimer(sessionExpiryTime, display);


});
</script>

