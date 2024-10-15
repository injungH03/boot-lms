<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%--
  Created by IntelliJ IDEA.
  User: kwon
  Date: 24. 10. 8.
  Time: 오후 8:24
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>JSP TEST</title>
</head>
<body>
<h1>Hello World!</h1>

<h1>XSS 필터 테스트</h1>
<form:form action="test/xss" method="POST">
    <label for="input">입력:</label>
    <input type="text" id="input" name="input" value="<script>alert('XSS')</script>">
    <button type="submit">전송</button>
</form:form>


</body>
</html>
