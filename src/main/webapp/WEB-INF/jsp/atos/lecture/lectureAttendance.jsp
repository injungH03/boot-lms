<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/atos/lecture/lecture.css' />">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">

<div class="head-section">
	<span>&nbsp;2024년 관리감독자 (제조업)</span>
</div>
<div class="table-section">
	<%@ include file="/WEB-INF/jsp/atos/common/menutab.jsp" %>
    <form method="get" action="">
        <table class="search-table">
            <tr>
                <th>검색</th>
                <td>
                    <div class="d-flex">
                        <select name="searchType" class="form-select search-select me-2">
                            <option value="전체">전체</option>
                        </select>
                        <input type="text" name="searchKeyword" class="form-control search-input me-2" placeholder="검색어를 입력하세요" />
                        <button type="submit" class="btn-search">검색</button>
                    </div>
                </td>
            </tr>
        </table>
    </form>


<!-- 테이블 위에 버튼 섹션 -->
<div class="d-flex justify-content-between mb-2 mt-5">
    <div>
        Total: <strong>38건</strong>
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
	        <col style="width: 10%;">
	        <col style="width: 20%;">
	        <col style="width: 15%;">
	        <col style="width: 10%;">
	        <col style="width: 10%;">
	        <col style="width: 10%;">
	        <col style="width: 5%;">
    	</colgroup>
        <thead>
            <tr>
                <th>No</th>
                <th>소속</th>
                <th>수강생</th>
                <th>상태</th>
                <th>입실시간</th>
                <th>퇴실시간</th>
                <th>관리</th>
                <th><input type="checkbox" id="checkAll"></th>
            </tr>
        </thead>
        <tbody>
            <tr data-id="1">
                <td>1</td>
                <td>아토스</td>
                <td>아이디/이름</td>
            	<td class="status">출석</td>
            	<td class="entry-time">오전 9시 00분</td>
            	<td class="exit-time">오후 6시 00분</td>
                <td class="manage">
                	<span class="status-box me-2 status-신청 attend">출석</span>
                	<span class="status-box status-종료 absent">결석</span>
                </td>
                <td><input type="checkbox" name="rowCheck" value=""></td>
            </tr>

        </tbody>
    </table>
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
    	if(confirm("선택한 수강생은 강의 시작, 종료 시간으로 입실, 퇴실 시간이 자동 지정 됩니다.")){
    		
    	}
    });
    
    //출석 버튼 클릭
    $(document).on('click', '.attend', function() {
        var $row = $(this).closest('tr');
        var id = $row.data('id');

        $.ajax({
            url: '/get-lecture-times', // 실제 엔드포인트로 변경
            method: 'GET',
            data: { id: id }, // 필요에 따라 파라미터 수정
            dataType: 'json',
            success: function(response) {
                if(response.success) { // ResponseVO에 success 필드가 있다고 가정
                    var lectureStartTime = response.data.lectureStartTime; // "09:00"
                    var lectureEndTime = response.data.lectureEndTime; // "18:00"

                    // 입실시간과 퇴실시간을 시간 입력 폼으로 변경하고 기본값 설정
                    $row.find('.entry-time').html('<input type="time" class="input-entry-time" value="' + lectureStartTime + '">');
                    $row.find('.exit-time').html('<input type="time" class="input-exit-time" value="' + lectureEndTime + '">');

                    // 관리 버튼을 저장 버튼으로 변경
                    $row.find('.manage').html('<button class="btn-save">저장</button>');
                } else {
                    alert('강의 시간 정보를 불러오는데 실패했습니다: ' + response.message);
                }
            },
            error: function() {
                alert('서버와의 통신 중 오류가 발생했습니다.');
            }
        });
    });
    
 	//저장 버튼 클릭 시
    $(document).on('click', '.btn-save', function() {
        var $row = $(this).closest('tr');
        var id = $row.data('id');
        var newStatus = '출석';
        var newEntryTime = $row.find('.input-entry-time').val();
        var newExitTime = $row.find('.input-exit-time').val();

        // AJAX 요청을 통해 서버로 데이터 전송
        $.ajax({
            url: '/update-attendance', // 실제 엔드포인트로 변경
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                id: id,
                status: newStatus,
                entryTime: newEntryTime,
                exitTime: newExitTime
            }),
            success: function(response) {
                // 서버 응답에 따라 처리
                if(response.success) { // ResponseVO에 success 필드가 있다고 가정
                    // 시간을 다시 오전/오후 형식으로 변환
                    var formattedEntryTime = formatTimeToKorean(newEntryTime);
                    var formattedExitTime = formatTimeToKorean(newExitTime);

                    // 테이블 업데이트
                    $row.find('.status').text(newStatus);
                    $row.find('.entry-time').text(formattedEntryTime);
                    $row.find('.exit-time').text(formattedExitTime);
                    $row.find('.manage').html(
                        '<button class="btn-attend">출석</button> ' +
                        '<button class="btn-absent">결석</button>'
                    );
                    alert('출석 정보가 저장되었습니다.');
                } else {
                    alert('저장에 실패했습니다: ' + response.message);
                }
            },
            error: function() {
                alert('서버와의 통신 중 오류가 발생했습니다.');
            }
        });
    });

    // 결석 버튼 클릭 시
    $(document).on('click', '.absent', function() {
        var $row = $(this).closest('tr');
        var id = $row.data('id');
        var newStatus = '결석';
        var newEntryTime = '';
        var newExitTime = '';

        // AJAX 요청을 통해 서버로 데이터 전송
        $.ajax({
            url: '/update-attendance', // 실제 엔드포인트로 변경
            method: 'POST',
            contentType: 'application/json',
            data: JSON.stringify({
                id: id,
                status: newStatus,
                entryTime: newEntryTime,
                exitTime: newExitTime
            }),
            success: function(response) {
                if(response.success) { // ResponseVO에 success 필드가 있다고 가정
                    // 테이블 업데이트
                    $row.find('.status').text(newStatus);
                    $row.find('.entry-time').text('-');
                    $row.find('.exit-time').text('-');
                    $row.find('.manage').html(
                        '<button class="btn-attend">출석</button> ' +
                        '<button class="btn-absent">결석</button>'
                    );
                    alert('결석 정보가 저장되었습니다.');
                } else {
                    alert('저장에 실패했습니다: ' + response.message);
                }
            },
            error: function() {
                alert('서버와의 통신 중 오류가 발생했습니다.');
            }
        });
    });

    // 시간 형식 변환 함수 (24시간 형식 -> 오전/오후)
    function formatTimeToKorean(timeStr) {
        if (!timeStr) return '-';
        var [hour, minute] = timeStr.split(':');
        hour = parseInt(hour);
        minute = parseInt(minute);
        var period = '오전';

        if (hour >= 12) {
            period = '오후';
            if (hour > 12) hour -= 12;
        }
        if (hour === 0) hour = 12;

        return period + ' ' + hour + '시 ' + ('0' + minute).slice(-2) + '분';
    }
	

});
</script>