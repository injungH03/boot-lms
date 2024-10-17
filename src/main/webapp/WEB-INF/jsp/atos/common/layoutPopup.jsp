<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <script type="text/javascript" src="<c:url value='/js/common/CommonUtil.js'/>" ></script>
    <script type="text/javascript" src="<c:url value='/js/common/FetchFunction.js'/>" ></script>
    <script type="text/javascript" src="<c:url value='/js/jquery/jquery.js'/>" ></script>

	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/common/common.css' />">
    <link type="text/css" rel="stylesheet" href="<c:url value='/css/common/paging.css' />">

    <meta charset="UTF-8">
    <style>
        * {
	        font-size: 13px;
        }
    </style>
    <title>${pageTitle}</title>
    <body>

        