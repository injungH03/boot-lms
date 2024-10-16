<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Error - Something went wrong</title>
    <style>
        .error-container {
            font-family: Arial, sans-serif;
            background-color: #f8f9fa;
            color: #333;
            text-align: center;
            padding: 50px;
        }
        .error-title {
            font-size: 3em;
            color: #ff4757;
        }
        .error-message {
            font-size: 1.2em;
            margin: 20px 0;
        }
        .error-btn {
            display: inline-block;
            padding: 10px 20px;
            margin-top: 30px;
            font-size: 1em;
            color: #fff;
            background-color: #007bff;
            border: none;
            border-radius: 5px;
            text-decoration: none;
            transition: background-color 0.3s;
        }
        .error-btn:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>

<div class="error-container">
    <h1 class="error-title">서버 오류</h1>
    <p class="error-message">${errorMessage} ${errorCode}</p>
    <p class="error-message">관리자에 문의 하세요</p>
    <span>${debugMessage}</span>
    <a href="/" class="error-btn">Go to Homepage</a>

</div>

</body>
</html>
