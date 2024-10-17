<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
.nav-tabs {
    display: flex;
    border-bottom: 1px solid #ddd;
}

.nav-tabs .nav-item {
    margin-bottom: -1px;
}

.nav-tabs .nav-item .nav-link {
    padding: 10px 20px;
    margin-right: 2px;
    background-color: #f9f9f9;
    border: 1px solid #ddd;
    border-radius: 4px 4px 0 0;
    color: #333;
    transition: all 0.3s ease;
}

.nav-tabs .nav-item .nav-link.active {
    background-color: white;
    border-bottom: 1px solid white;
    color: black;
    font-weight: bold;
}

.nav-tabs .nav-item .nav-link:hover {
    background-color: #e9ecef;
     color: black;
}
</style>    
<div class="nav-tabs">
    <ul class="nav nav-tabs">
        <li class="nav-item">
            <a class="nav-link <c:if test="${page == 'lectureDetail'}">active</c:if>" href="<c:url value='/admin/education/lectureDetail?lectureCode=${searchVO.lectureCode}&pageIndex=${searchVO.pageIndex }'/>">강의상세</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <c:if test="${page == 'lectureStudentList'}">active</c:if>" href="<c:url value='/admin/education/lectureStudentList?lectureCode=${searchVO.lectureCode}'/>">수강생목록</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <c:if test="${page == 'lectureAttendance'}">active</c:if>" href="/admin/education/lectureAttendance?lectureCode=${searchVO.lectureCode}">출석관리</a>
        </li>
        <li class="nav-item">
            <a class="nav-link <c:if test="${page == 'completion'}">active</c:if>" href="#">수료관리</a>
        </li>
        <!-- 추가 탭 -->
    </ul>
</div>
