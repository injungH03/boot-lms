<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="java.time.Instant" %>
<%
    int maxInactiveInterval = session.getMaxInactiveInterval(); // 1800초 (30분)
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
		<a href="" class="customer-center-btn">로그인연장</a>
		<a href="${siteMapUrl}" class="site-btn">사용자화면</a>
	</div>
</div>
<script>
$(document).ready(function () {
    $('#logout').on('click', function(e) {
        e.preventDefault();
        $('#logoutForm').submit();
    });

    // 세션 타임아웃 (밀리초 단위)
    var sessionTimeout = <%= maxInactiveInterval * 1000 %>; // 1800000ms (30분)

    // 로그인 시점의 타임스탬프 저장
    if (!localStorage.getItem('loginTime')) {
        var loginTime = new Date().getTime();
        localStorage.setItem('loginTime', loginTime);
    } else {
        var loginTime = parseInt(localStorage.getItem('loginTime'));
    }

    // 로그인 연장 시점의 타임스탬프 업데이트
    function extendSession() {
        var newLoginTime = new Date().getTime();
        localStorage.setItem('loginTime', newLoginTime);
    }

    function startTimer(display) {
        function updateTimer() {
            var currentTime = new Date().getTime();
            var elapsed = currentTime - loginTime;
            var remaining = Math.floor((sessionTimeout - elapsed) / 1000); // 초 단위

            if (remaining <= 0) {
                display.textContent = "세션이 만료되었습니다.";
                clearInterval(window.sessionTimerInterval);
                // 자동 로그아웃 또는 로그인 페이지로 이동
                window.location.href = "/admin/logout"; // 로그아웃 URL
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
    startTimer(display);

    // 로그인 연장 버튼 클릭 시 세션 연장
    $('#extend-login').on('click', function (e) {
        e.preventDefault();
        $.ajax({
            url: '/admin/extend-session',
            method: 'GET',
            success: function (response) {
                if (response === 'success') {
                    extendSession();
                    clearInterval(window.sessionTimerInterval);
                    startTimer(display);
                    alert("세션이 연장되었습니다.");
                } else {
                    alert("세션 연장에 실패했습니다.");
                }
            },
            error: function () {
                alert("세션 연장에 실패했습니다.");
            }
        });
    });

});
</script>

