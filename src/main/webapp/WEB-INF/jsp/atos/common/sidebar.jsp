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



