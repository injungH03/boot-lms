<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>

<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="wrap">
<div class="head-section">
	<span>&nbsp;<c:out value="${result.title}"/></span>
</div>
<div class="table-section">
	<%@ include file="/WEB-INF/jsp/atos/common/menutab.jsp" %>
    <form id="searchForm" name="searchForm" action="<c:url value='/admin/education/lectureAttendList'/>" method="get">
        <table class="search-table">
            <tr>
                <th>검색</th>
                <td colspan="5">
                    <div class="d-flex">
						<select name="searchCnd" class="form-select search-select me-2">
                            <option value="">전체</option>
                            <option value="2" <c:if test="${searchVO.searchCnd == '1'}">selected="selected"</c:if>>아이디</option>
                            <option value="3" <c:if test="${searchVO.searchCnd == '2'}">selected="selected"</c:if>>이름</option>
                        </select>
                        <input type="text" name="searchWrd" class="form-control search-input me-2" placeholder="검색어를 입력하세요" value='<c:out value="${searchVO.searchWrd}"/>' maxlength="100"/>

                        <button type="submit" class="btn-search">검색</button>
                    </div>
                </td>
            </tr>
        </table>
        <input type="hidden" name="lectureCode" value="${searchVO.lectureCode}">
        <input type="hidden" name="pageIndex" value="${searchVO.pageIndex}">
    </form>


<!-- 테이블 위에 버튼 섹션 -->
<div class="d-flex justify-content-between mb-2 mt-5">
    <div>
        Total: <strong>${totalcount }</strong>
    </div>
    <div>
    	<button class="btn-create-course" id="attendAllCheck">출석</button>
        <button class="btn-excel">EXCEL</button>
    </div>
</div>

<!-- 과정 테이블 섹션 -->
<div class="course-table-section">
    <table class="table table-bordered">
       <colgroup>
	        <col style="width: 5%;">
	        <col style="width: 15%;">
	        <col style="width: 15%;">
	        <col style="width: 10%;">
	        <col style="width: 5%;">
	        <col style="width: 10%;">
	        <col style="width: 10%;">
	        <col style="width: 10%;">
	        <col style="width: 5%;">
    	</colgroup>
        <thead>
            <tr>
                <th>No</th>
                <th>소속</th>
                <th>아이디</th>
                <th>이름</th>
                <th>상태</th>
                <th>입실시간</th>
                <th>퇴실시간</th>
                <th>관리</th>
                <th><input type="checkbox" id="checkAll"></th>
            </tr>
        </thead>
        <tbody>
        <c:forEach items="${resultList }" var="resultInfo" varStatus="status">
            <tr data-key="${resultInfo.attendCode}">
                <td><c:out value="${(searchVO.pageIndex-1) * searchVO.pageSize + status.index + 1}"/></td>
                <td><c:out value="${resultInfo.corpName }" /></td>
                <td><a href="#"><c:out value="${resultInfo.memberId }" /></a></td>
                <td><c:out value="${resultInfo.name }" /></td>
            	<td class="status">${resultInfo.status}</td>
            	<td class="entry-time">
            	    <span class="entry-text">${resultInfo.inTimeFormat}</span>
            	    <input type="time" class="form-control input-entry-time" style="display: none;" value="">
            	</td>
            	<td class="exit-time">
            	    <span class="exit-text">${resultInfo.outTimeFormat}</span>
            	    <input type="time" class="form-control input-exit-time" style="display: none;" value="">
            	</td>

                <td class="manage">
                    <div class="view-buttons">
                        <button class="btn-state attend">출석</button>
                        <button class="btn-state absent">결석</button>
                    </div>
                    <div class="edit-buttons" style="display: none;">
                        <button class="btn-save">저장</button>
                        <button class="btn-cancel">취소</button>
                </td>
                <td><input type="checkbox" name="rowCheck" value=""></td>
            </tr>
        </c:forEach>

        <c:if test="${fn:length(resultList) == 0}">
	        <tr>
	            <td colspan="9">조회된 결과가 존재하지 않습니다.</td>
	        </tr>
        </c:if>

        </tbody>
    </table>
</div>
    <div class="pagination">
        <pagination:pagination
                paginationInfo="${paginationInfo}"
                jsFunction="fn_select_linkPage"
                formId="searchForm" />
    </div>


</div>
</div>
<script>
$(document).ready(function() {
    // 전체 선택/해제 기능
    $('#checkAll').on('click', function() {
        $('tbody input[name="rowCheck"]').prop('checked', this.checked);
    });
    
    //체크박스 출석 체크
    $('#attendAllCheck').on('click', function() {
        var lectureCode = $('input[name=lectureCode]').val();
        var pageIndex = $('input[name=pageIndex]').val();

        var selectedAttends = [];
        var type = "A"

        $('tbody input[name="rowCheck"]:checked').each(function() {
            var attendCode = $(this).closest('tr').data('key');
            selectedAttends.push(attendCode);
        });

        if (selectedAttends.length === 0) {
            alert('수강생을 선택해주세요.');
            return;
        }

    	if(confirm("선택한 수강생은 강의 시작, 종료 시간으로 입실, 퇴실 시간이 자동 지정 됩니다.")){

    		myFetch({
                url: '/admin/education/attendSave',
                data: {
                    attendCodeList : selectedAttends,
                    type : type,
                    lectureCode : lectureCode
                },
                success: function(response) {
                    alert(response.message);
                    window.location.href = "<c:url value='/admin/education/lectureAttendance'/>?pageIndex=" + pageIndex + "&lectureCode=" + lectureCode;

                },
                error: function(error) {
                    console.error('오류 발생:', error);
                    alert('출석 오류');
                }
            });
    	}
    });
    
    //출석 버튼 클릭
    $(document).on('click', '.attend', function(event) {
        event.preventDefault();
        var lectureCode = $('input[name=lectureCode]').val();
        var $row = $(this).closest('tr');

        myFetch({
            url: '/admin/education/attendTime',
            data: {
                lectureCode : lectureCode
            },
            success: function(response) {
                var startTime = response.result.startTime;
                var endTime = response.result.endTime;

                $row.find('.entry-text').hide();
                $row.find('.exit-text').hide();
                $row.find('.input-entry-time').val(startTime).show();
                $row.find('.input-exit-time').val(endTime).show();

                $row.find('.view-buttons').hide();
                $row.find('.edit-buttons').show();

            },
            error: function(error) {
                console.error('오류 발생:', error);
                alert('출석 오류');
            }
        });
    });

    //취소 버튼 클릭 시
    $(document).on('click', '.btn-cancel', function(event) {
        event.preventDefault();
        var $row = $(this).closest('tr');

        $row.find('.input-entry-time').hide();
        $row.find('.input-exit-time').hide();
        $row.find('.entry-text').show();
        $row.find('.exit-text').show();

        $row.find('.edit-buttons').hide();
        $row.find('.view-buttons').show();

    });
    
 	//저장 버튼 클릭 시
    $(document).on('click', '.btn-save', function() {
        var pageIndex = $('input[name=pageIndex]').val();
        var lectureCode = $('input[name=lectureCode]').val();
        var $row = $(this).closest('tr');
        var key = $row.data('key');
        var type = "S";

        var newEntryTime = $row.find('.input-entry-time').val();
        var newExitTime = $row.find('.input-exit-time').val();

        myFetch({
            url: '/admin/education/attendSave',
            data: {
                attendCode : key,
                inTime :  newEntryTime,
                outTime : newExitTime,
                type : type
            },
            success: function(response) {
                alert(response.message);
                window.location.href = "<c:url value='/admin/education/lectureAttendance'/>?pageIndex=" + pageIndex + "&lectureCode=" + lectureCode;

            },
            error: function(error) {
                console.error('오류 발생:', error);
                alert('출석 오류');
            }
        });



    });

    // 결석 버튼 클릭 시
    $(document).on('click', '.absent', function() {
        var pageIndex = $('input[name=pageIndex]').val();
        var lectureCode = $('input[name=lectureCode]').val();
        var $row = $(this).closest('tr');
        var key = $row.data('key');
        var type = "F";

        myFetch({
            url: '/admin/education/attendSave',
            data: {
                attendCode : key,
                type : type
            },
            success: function(response) {
                alert(response.message);
                window.location.href = "<c:url value='/admin/education/lectureAttendance'/>?pageIndex=" + pageIndex + "&lectureCode=" + lectureCode;

            },
            error: function(error) {
                console.error('오류 발생:', error);
                alert('출석 오류');
            }
        });
    });

});
</script>