<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=utf-8">
<title>로그인</title>
<!--  -->
<link type="text/css" rel="stylesheet" href="<c:url value='/css/login/login.css' />">
<!--  -->
<script type="text/javaScript">


	// ----------------------------------------------------------------------------------------------------
	// 로그인 및 회원가입 처리 함수: 로그인 및 회원가입, 아이디/비밀번호 찾기 등의 구체적인 동작을 수행하는 함수
	// ----------------------------------------------------------------------------------------------------
	
	/* actionLogin()
	 * 
	 * 이 함수는 사용자가 로그인 버튼을 클릭했을 때 호출됩니다.
	 * 아이디 또는 비밀번호가 입력되지 않은 경우 경고 메시지를 표시합니다.
	 * 입력이 올바른 경우 로그인 폼을 제출하여 서버로 전송합니다.
	 */
	function actionLogin() {
		if (document.loginForm.username.value == "") {
			alert("아이디를 입력하세요.");
		} else if (document.loginForm.password.value == "") {
			alert("비밀번호를 입력하세요.");
		} else {
			document.loginForm.action = "<c:url value='/admin/actionLogin'/>";
			document.loginForm.submit();
		}
	}
</script>
</head>
<body>
	<!-- 로그인 폼 -->
	<div class="login_form">
		<form name="loginForm" id="loginForm" action="<c:url value='/admin/actionLogin'/>" method="post" onsubmit="return actionLogin();">
			<fieldset>
				<!-- 로고 -->
				<img class="logoImg" src="<c:url value='/images/atos/logo.png'/>" alt="login title image" title="login title image">
				<!-- 로그인 입력 필드 -->
				<c:set var="errorMessage" value="${sessionScope.errorMessage}" />
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger">
                        ${errorMessage}
                    </div>
                    <c:remove var="errorMessage" scope="session" />
                </c:if>
				<div class="login_input">
					<ul>
						<!-- 아이디 -->
						<li>
							<label for="id">아이디</label>
							<input type="text" name="username" id="id" maxlength="20"  autocomplete="username" value="test">
						</li>

						<!-- 비밀번호 -->
						<li>
							<label for="password">비밀번호</label>
							<input type="password" name="password" id="password" maxlength="20" autocomplete="current-password" value="123456">
						</li>

						<li>
							<input type="button" class="btn_login" value="로그인" onclick="actionLogin()">
						</li>
					</ul>
				</div>
			</fieldset>
		</form>
	</div>
</body>
</html>
