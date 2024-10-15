<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><c:out value="${pageTitle}" /></title>
  <script type="text/javascript" src="<c:url value='/js/common/CommonUtil.js'/>" ></script>
  <script type="text/javascript" src="<c:url value='/js/common/FetchFunction.js'/>" ></script>
  <script type="text/javascript" src="<c:url value='/js/jquery/jquery.js'/>" ></script>
  <link type="text/css" rel="stylesheet" href="<c:url value='/css/common/paging.css' />">
  <link type="text/css" rel="stylesheet" href="<c:url value='/css/common/style.css' />">
  <link type="text/css" rel="stylesheet" href="<c:url value='/css/common/common.css' />">
  <!-- 부트스트랩  -->
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</head>
<script type="text/javascript">
  $(document).ready(function () {
    var csrfParameterName = '${_csrf.parameterName}';  // CSRF 파라미터 이름
    var csrfTokenValue = '${_csrf.token}';            // CSRF 토큰 값

    console.log("CSRF Token Name: " + csrfParameterName);
    console.log("CSRF Token Value: " + csrfTokenValue);


    // 1. 로컬 스토리지에서 활성화된 헤더 및 서브 메뉴 정보 로드
    var activeHeaderMenu = localStorage.getItem('activeHeaderMenu') || $('.header-links a:first').data('menuCode');
    var activeSubMenu = localStorage.getItem('activeSubMenu') || null;

    // 2. 현재 URL을 가져와서 서브 메뉴 상태와 비교
    var currentUrl = window.location.pathname;

    // 3. 활성화된 상태로 메뉴 보여주기
    activateMenus(activeHeaderMenu, activeSubMenu, currentUrl);

    // 4. 헤더 메뉴 클릭 시 이벤트 처리
    $('.header-links a').on('click', function (e) {
      e.preventDefault();
      var clickedHeaderMenuCode = $(this).data('menucode');  // 헤더 메뉴 코드

      // 로컬 스토리지에 저장
      localStorage.setItem('activeHeaderMenu', clickedHeaderMenuCode);
      localStorage.removeItem('activeSubMenu'); // 서브 메뉴는 초기화

      // 활성화된 헤더 메뉴에 맞는 서브 메뉴 표시
      activateMenus(clickedHeaderMenuCode, null, null);
    });

    // 5. 서브 메뉴 클릭 시 이벤트 처리
    $('.sidebar a').on('click', function (e) {
      var clickedSubMenuUrl = $(this).attr('href');

      // 로컬 스토리지에 저장
      localStorage.setItem('activeSubMenu', clickedSubMenuUrl);

      // 서브 메뉴 상태 업데이트
      activateMenus(localStorage.getItem('activeHeaderMenu'), clickedSubMenuUrl, clickedSubMenuUrl);
    });

    // 활성화된 메뉴 표시 함수
    function activateMenus(activeHeaderMenu, activeSubMenu, currentUrl) {
      // 모든 메뉴 숨기기
      $('.sidebar .menu-group').hide();

      // 현재 활성화된 헤더 메뉴에 해당하는 서브 메뉴 보이기
      $('.' + activeHeaderMenu + '-menu').show();

      // 헤더 메뉴 활성화
      $('.header-links a').removeClass('active');
      $('.header-links a[data-menucode="' + activeHeaderMenu + '"]').addClass('active');

      // 현재 URL을 기준으로 서브 메뉴 활성화
      $('.sidebar a').removeClass('active');
      if (currentUrl) {
        $('.sidebar a').each(function () {
          var menuUrl = $(this).attr('href');
          if (menuUrl === currentUrl || menuUrl === activeSubMenu) {
            $(this).addClass('active');
          }
        });
      }
    }
  });


</script>
<!-- Header Section -->
<header class="dashboard-header">
  <jsp:include page="/WEB-INF/jsp/atos/common/header.jsp" />
</header>

<!-- Sidebar Section -->
<aside class="dashboard-sidebar">
  <jsp:include page="/WEB-INF/jsp/atos/common/sidebar.jsp" />
</aside>

<body>


