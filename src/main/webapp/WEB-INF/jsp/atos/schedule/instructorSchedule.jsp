<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>



<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/common.css' />">
<!-- FullCalendar 6.1.10 JS/CSS 추가 -->
<script src="https://cdn.jsdelivr.net/npm/fullcalendar@6.1.10/index.global.min.js"></script>



<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />



<div class="wrap">

<div class="head-section" style="margin-bottom:20px;">
    <span>&nbsp;강사스케줄관리</span>
</div>

<form id="searchForm" name="searchForm" action="<c:url value='/admin/education/ischeduleList'/>" method="get">

    <div class="table-section">
        <table class="search-table">
            <tr>
				<th class="custom-th-width">강사 선택</th>
				<td>
				    <div class="d-flex">
				        <select name="instructor" id="instructorId" class="form-select search-selectle me-2" onchange="this.form.submit();">
				            <option value="">전체 강사</option>
				            <c:forEach var="instructor" items="${instructorList}">
				                <option value="${instructor.id}" <c:if test="${instructor.id == param.instructor}">selected="selected"</c:if>>${instructor.name}</option>
				            </c:forEach>
				        </select>
				    </div>
				</td>
            </tr>
        </table>
    </div>
</form>

<!-- FullCalendar 달력 -->
<div class="instructorCalendar"></div>


</div>



<!-- 모달 내용 포함 -->
<%@ include file="/WEB-INF/jsp/atos/schedule/instructorModal.jsp" %>
<%@ include file="/WEB-INF/jsp/atos/schedule/instructorEditModal.jsp" %>



<script>
    // FullCalendar 초기화 및 설정
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.querySelector('.instructorCalendar');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            locale: 'ko',
            headerToolbar: {
                left: 'prev,next today register',
                center: 'title',
                right: 'dayGridMonth,dayGridWeek,listMonth'
            },
            customButtons: {
                register: {
                    text: '등록',
                    click: function() {
                        $('#scheduleModal').modal('show');
                    }
                }
            },
            initialView: 'dayGridMonth',
            editable: false,
            navLinks: true,
            events: [
                <c:forEach var="schedule" items="${scheduleList}" varStatus="status">
                {
                    id: '${schedule.scheduleCode}',
                    title: '${schedule.name} - ${schedule.mainEvent}',
                    start: '${schedule.startDate}',
                    end: '${schedule.endDate}',
                    allDay: true,
                    color: '${schedule.scheduleColor}',
                    extendedProps: {
                        instructorId: '${schedule.instructor}',
                        instructorName: '${schedule.name}',
                        mainEvent: '${schedule.mainEvent}'
                    }
                }<c:if test="${!status.last}">,</c:if>
                </c:forEach>
            ],
            eventClick: function(info) {
                // 스케줄 정보를 수정 모달에 표시
                var event = info.event;

                // 강사 선택 드롭다운에서 해당 강사 선택하기
                $('#editModalInstructorId').val(event.extendedProps.instructorId).change();

                // 타이틀, 시작일, 종료일, 색상 설정
                $('#editMainEvent').val(event.extendedProps.mainEvent);
                $('#editStartDate').val(event.startStr);
                $('#editEndDate').val(event.endStr);
                $('#editScheduleColor').val(event.backgroundColor);

                // 수정 및 삭제 모달 띄우기
                $('#editScheduleModal').modal('show');

                // 수정 버튼 클릭 시 이벤트 등록
                $('#updateScheduleBtn').off('click').on('click', function() {
                    updateSchedule(event.id);
                });

                // 삭제 버튼 클릭 시 이벤트 등록
                $('#deleteScheduleBtn').off('click').on('click', function() {
                    deleteSchedule(event.id);
                });
            }
        });

        calendar.render();
        
        
        
        
        // 수정 기능 구현
        function updateSchedule(scheduleId) {
            var instructorId = $('#editModalInstructorId').val();
            var mainEvent = $('#editMainEvent').val();
            var startDate = $('#editStartDate').val();
            var endDate = $('#editEndDate').val();
            var scheduleColor = $('#editScheduleColor').val();

            if (!instructorId || !mainEvent || !startDate || !scheduleColor) {
                alert("모든 필수 입력값을 입력해주세요.");
                return;
            }

            var formDataJson = {
                scheduleCode: scheduleId,
                instructor: instructorId,
                mainEvent: mainEvent,
                startDate: startDate,
                scheduleColor: scheduleColor
            };
            
            if (endDate) {
                formDataJson.endDate = endDate;
            }

            $.ajax({
                type: 'POST',
                url: '<c:url value="/admin/education/updateSchedule"/>',
                contentType: 'application/json',
                data: JSON.stringify(formDataJson),
                success: function(response) {
                    if (response.message) {
                        alert(response.message);
                        $('#editScheduleModal').modal('hide');
                        window.location.reload();
                    } else {
                        alert('스케줄 수정에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error occurred: ", error);
                    alert('오류가 발생했습니다. 다시 시도해 주세요.');
                }
            });
        }

        // 삭제 기능 구현
        function deleteSchedule(scheduleId) {
            if (!confirm("정말로 삭제하시겠습니까?")) {
                return;
            }

            var formDataJson = {
                scheduleCode: scheduleId
            };

            $.ajax({
                type: 'POST',
                url: '<c:url value="/admin/education/deleteSchedule"/>',
                contentType: 'application/json',
                data: JSON.stringify(formDataJson),
                success: function(response) {
                    if (response.message) {
                        alert(response.message);
                        $('#editScheduleModal').modal('hide');
                        window.location.reload();
                    } else {
                        alert('스케줄 삭제에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error occurred: ", error);
                    alert('오류가 발생했습니다. 다시 시도해 주세요.');
                }
            });
        }
        
               
        
        // 종료 날짜에 하루 추가하기 위해 JavaScript로 처리
        calendar.getEvents().forEach(function(event) {
            if (event.end) {
                let endDate = new Date(event.end);
                endDate.setDate(endDate.getDate() + 1);
                event.setEnd(endDate);
            }
        });

     // 모달의 저장 버튼 클릭 시 이벤트 핸들러 등록
        $('#saveScheduleBtn').on('click', function(event) {
            event.preventDefault(); // 기본 동작인 폼 제출을 막음

            var instructorId = $('#modalInstructorId').val();
            var mainEvent = $('#mainEvent').val();
            var startDate = $('#startDate').val();
            var endDate = $('#endDate').val();
            var scheduleColor = $('#scheduleColor').val();

            if (!instructorId || !mainEvent || !startDate || !endDate || !scheduleColor) {
                alert("모든 필수 입력값을 입력해주세요.");
                return;
            }

            // 폼 데이터를 JSON 형식으로 변환
            var formDataJson = {
                instructor: instructorId,
                mainEvent: mainEvent,
                startDate: startDate,
                endDate: endDate,
                scheduleColor: scheduleColor
            };
            console.log("Form Data as JSON: ", formDataJson);
            
            $.ajax({
                type: 'POST',
                url: '<c:url value="/admin/education/registerSchedule"/>',
                contentType: 'application/json',  // JSON 형식으로 전송
                data: JSON.stringify(formDataJson), // 데이터를 JSON 문자열로 변환
                success: function(response) {
                    if (response.message) {
                        alert(response.message);
                        $('#scheduleModal').modal('hide'); // 모달 닫기

                        // 페이지 새로고침
                        window.location.reload(); // 전체 페이지를 새로고침하여 최신 데이터를 반영
                    } else {
                        alert('스케줄 등록에 실패했습니다.');
                    }
                },
                error: function(xhr, status, error) {
                    console.error("Error occurred: ", error);
                    alert('오류가 발생했습니다. 다시 시도해 주세요.');
                }
            });

        });
     
     
    });

  
</script>