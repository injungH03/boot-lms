<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="sidebar">
    <c:forEach var="headerMenu" items="${headerMenus}">
        <div class="menu-group ${headerMenu.menuCode}-menu" style="display: none;">
            <h3>${headerMenu.menuName}</h3>
            <ul>
                <c:forEach var="subMenu" items="${headerMenu.subMenuItems}">
                    <li>
                        <a href="<c:url value='${subMenu.url}'/>" class="">
                                ${subMenu.menuName}
                        </a>
                    </li>
                </c:forEach>
            </ul>
        </div>
    </c:forEach>
</div>
<script>
$(document).ready(function() {
    // 사이드바에서 활성화된 메뉴 항목의 텍스트를 가져옴
    var activeMenuName = $('.sidebar a.active').text();

    // 기존의 span 텍스트를 가져옴
    var existingText = $('.head-section span').html();

    // 새로운 텍스트를 앞에 추가한 후 다시 설정
    $('.head-section span').html(activeMenuName + ' ' + existingText);
});
</script>
