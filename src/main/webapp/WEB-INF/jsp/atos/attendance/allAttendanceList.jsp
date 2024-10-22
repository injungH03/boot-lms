<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>



<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/common.css' />">
<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />



<div class="wrap">

  <div class="head-section" style="margin-bottom:20px;">
        <span>&nbsp;교육 과정 목록</span>
    </div>

<form id="searchForm" name="searchForm" action="<c:url value='/admin/education/attendanceList'/>" method="get">
 <input type="hidden" name="pageIndex" value="${attendanceSearchVO.pageIndex}">

    <div class="table-section">
        
<!-- 과정 선택 -->
        <table class="search-table">
            <tr>
                <th class="custom-th-width">과정명</th>
                <td>
                    <div class="d-flex">
						<select name="lectureCode" class="form-select search-selectle me-2">
						    <option value="0">전체</option>
                        <c:forEach var="lecture" items="${educationList}"> 
	                        <option value="${lecture.eduCode}" 
							    <c:if test="${lecture.eduCode == attendanceSearchVO.lectureCode}">selected="selected"</c:if>>
							    ${lecture.title}
							</option>
                        </c:forEach>
						</select>
                    </div>
                </td>
            </tr>

<!-- 출석일 선택 -->
            <tr>
                <th>출석일</th>
                <td colspan="3">
                    <div class="d-flex">
                        <input type="date" name="srcStartDate" id="startDate" class="form-control me-2 custom-width" 
                               value="${attendanceSearchVO.srcStartDate}"/>
                        <input type="date" name="srcEndDate" id="endDate" class="form-control me-2  custom-width" 
                               value="${attendanceSearchVO.srcEndDate}"/>
                    </div>
                </td>
            </tr>

<!-- 검색 조건 -->
            <tr>
                <th>검색</th>
                <td>
                    <div class="d-flex">                  
                        <select name="searchCnd" class="form-select search-select me-2">
                            <option value="">전체</option>
                            <option value="0" <c:if test="${attendanceSearchVO.searchCnd == '0'}">selected</c:if>>회원명</option>
                            <option value="1" <c:if test="${attendanceSearchVO.searchCnd == '1'}">selected</c:if>>업체명</option>
                        </select>
                        <input type="text" name="searchWrd" class="form-control search-input me-2" placeholder="검색어를 입력하세요" value='<c:out value="${attendanceSearchVO.searchWrd}"/>'/>
                        <button type="submit" class="btn-search">검색</button>
                    </div>
                </td>
            </tr>
        </table>
    


    <!-- 테이블 위에 버튼 섹션 -->
    <div class="d-flex justify-content-between mb-2 mt-5">
        <div>Total: <strong>${paginationInfo.totalRecordCount}건</strong></div>
        <div>
            <button class="btn-create-course" id="attendAllCheckIn">입실처리</button>
            <button class="btn-create-course" id="attendAllCheckOut">퇴실처리</button>
            <button class="btn-create-course" id="attendAllAbsence">결석처리</button>
            <button class="btn-excel" id="excelDownloadBtn">EXCEL</button>
        </div>
    </div>

    <!-- 과정 테이블 섹션 -->
    <div class="course-table-section">
        <table class="table table-bordered">
        <colgroup>
                <col style="width: 3%;">
                <col style="width: 15%;">
                <col style="width: 15%;">
                <col style="width: 20%;">
                <col style="width: 7%;">
                <col style="width: 9%;">
                <col style="width: 7%;">
                <col style="width: 7%;">
                <col style="width: 12%;">
                <col style="width: 3%;">
            </colgroup>
            <thead>
                <tr>
                    <th>No</th>
                    <th>소속</th>
                    <th>과정명</th>
                    <th>수강생</th>
                    <th>상태</th>
                    <th>출석일</th>
                    <th>입실시간</th>
                    <th>퇴실시간</th>
                    <th>출결</th>
                    <th><input type="checkbox" id="checkAll"></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="resultInfo" items="${resultList}" varStatus="status">
                    <tr>
                        <td>${(attendanceSearchVO.pageIndex - 1) * attendanceSearchVO.recordCountPerPage + status.index + 1}</td>
                        <td>${resultInfo.corpName}</td> <!-- 소속 -->
                        <td>${resultInfo.title}</td> <!-- 과정명 추가 -->
                        <td>${resultInfo.memberId}(${resultInfo.name})</td> <!-- 수강생 아이디(이름) -->
                        <td>${resultInfo.statusName}</td> <!-- 상태 -->
                        <td>${resultInfo.attendDate}</td> <!-- 출석일 -->
                        <td>${resultInfo.inTime}</td> <!-- 입실 시간 -->
                        <td>${resultInfo.outTime}</td> <!-- 퇴실 시간 -->
                        <td class="manage">                  
                            <!-- 입실 버튼: 입실 시간이 이미 있을 경우 비활성화 -->
                            <button class="btn-state attend"
                                data-attend-code="${resultInfo.attendCode}" 
                                <c:if test="${resultInfo.inTime != null || resultInfo.statusName == '결석'}">style="pointer-events: none; opacity: 0.5;"</c:if>>
                                입실
                            </button>
                            
                            <!-- 퇴실 버튼: 퇴실 시간이 이미 있을 경우 비활성화 -->
                            <button class="btn-state absent"
                                data-attend-code="${resultInfo.attendCode}" 
                                <c:if test="${resultInfo.outTime != null || resultInfo.statusName == '결석'}">style="pointer-events: none; opacity: 0.5;"</c:if>>
                                퇴실
                            </button>
                
                        </td>
                        <td><input type="checkbox" name="rowCheck" value="${resultInfo.attendCode}"></td>
                    </tr>
                </c:forEach>
                <c:if test="${fn:length(resultList) == 0}">
                    <tr>
                        <td colspan="9">조회된 결과가 없습니다.</td>
                    </tr>
                </c:if>
            </tbody>
        </table>
    </div>


            <div class="pagination justify-content-center">
                <pagination:pagination paginationInfo="${paginationInfo}" jsFunction="fn_select_linkPage" formId="searchForm" />
            </div>


        
    </div>
</form>





</div>




<!-- 입실, 퇴실, 모달 -->
<div class="modal fade" id="attendanceModal" tabindex="-1" aria-labelledby="attendanceModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="attendanceModalLabel">시간 입력</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <div class="mb-3" id="dateInputContainer">
          <label for="modalDateInput" class="form-label">출석일</label>
          <input type="date" class="form-control" id="modalDateInput">
        </div>
        <div class="mb-3">
          <label for="modalTimeInput" class="form-label">시간</label>
          <input type="time" class="form-control" id="modalTimeInput">
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="confirmTimeBtn">확인</button>
      </div>
    </div>
  </div>
</div>













<script>

$(document).ready(function() {
	
 // 입실 버튼 클릭 시
    $('.btn-state.attend').click(function() {
        var attendCode = $(this).data('attend-code');

        $.ajax({
            url: "<c:url value='/admin/education/checkIn' />",
            type: "POST",
            data: { attendCode: attendCode },
            success: function(response) {
                // response.status 확인 후 처리
                if (response.status) {
                    alert(response.message || "입실 처리가 완료되었습니다.");
                    location.reload(); // 페이지 새로고침
                } else {
                    alert(response.message || "입실 처리에 실패하였습니다.");
                }
            },
            error: function() {
                alert("입실 처리 중 오류가 발생하였습니다.");
            }
        });
    });

    // 퇴실 버튼 클릭 시
    $('.btn-state.absent').click(function() {
        var attendCode = $(this).data('attend-code');

        $.ajax({
            url: "<c:url value='/admin/education/checkOut' />",
            type: "POST",
            contentType: "application/json",  // JSON 형식으로 전송
            data: JSON.stringify({ attendCodes: [attendCode] }),  // 배열로 전달
            success: function(response) {
                // response === "success" 확인 후 처리
                if (response === "success") {
                    alert("퇴실 처리가 완료되었습니다.");
                    location.reload(); // 페이지 새로고침
                } else {
                    alert(response.message || "퇴실 처리에 실패하였습니다.");
                }
            },
            error: function(xhr) {
                if (xhr.status === 400) {
                    alert(xhr.responseText || "입실 처리가 완료되지 않은 출석 코드입니다.");
                } else {
                    alert("퇴실 처리 중 오류가 발생하였습니다.");
                }
            }
        });
    });
	 
	
    // 전체 선택/해제 기능
    $('#checkAll').on('click', function() {
        $('tbody input[name="rowCheck"]').prop('checked', this.checked);
    });


    
    /* 전체 버튼 */
    
    const attendanceModal = new bootstrap.Modal(document.getElementById('attendanceModal'));

 // 전체입실 버튼 클릭 시
    $('#attendAllCheckIn').click(function() {
        console.log("전체입실 버튼 클릭됨");
        actionType = 'checkIn';
        selectedAttendanceCodes = [];
        $('input[name="rowCheck"]:checked').each(function() {
            selectedAttendanceCodes.push($(this).val());
        });

        if (selectedAttendanceCodes.length === 0) {
            alert("입실 처리할 수강생을 선택해주세요.");
            return;
        }

        // 출석일을 당일로, 입실 시간을 09:00으로 설정
        const currentDate = new Date().toISOString().split('T')[0]; // YYYY-MM-DD 형식으로 현재 날짜 가져오기
        $('#modalDateInput').val(currentDate); // 출석일 설정
        $('#modalTimeInput').val('09:00'); // 입실 시간 기본 설정

        $('#dateInputContainer').show();
        attendanceModal.show();  // 모달창 띄우기
    });

    // 전체퇴실 버튼 클릭 시
    $('#attendAllCheckOut').click(function() {
        console.log("전체퇴실 버튼 클릭됨");
        actionType = 'checkOut';
        selectedAttendanceCodes = [];
        $('input[name="rowCheck"]:checked').each(function() {
            selectedAttendanceCodes.push($(this).val());
        });

        if (selectedAttendanceCodes.length === 0) {
            alert("퇴실 처리할 수강생을 선택해주세요.");
            return;
        }

        // 퇴실 시간을 18:00으로 설정 (출석일은 숨김)
        $('#modalTimeInput').val('18:00'); // 퇴실 시간 기본 설정
        $('#dateInputContainer').hide();
        attendanceModal.show();  // 모달창 띄우기
    });

    // 모달 확인 버튼 클릭 시
    $('#confirmTimeBtn').click(function() {
        console.log("모달 확인 버튼 클릭됨");
        const date = $('#modalDateInput').val();
        const time = $('#modalTimeInput').val();

        if (!time) {
            alert("시간을 입력해주세요.");
            return;
        }

        let url = '';
        let data = { attendCodes: selectedAttendanceCodes };

        if (actionType === 'checkIn') {
            if (!date) {
                alert("날짜를 입력해주세요.");
                return;
            }
            url = "<c:url value='/admin/education/checkInAll' />";
            data.inTime = time;
            data.attendDate = date;
        } else if (actionType === 'checkOut') {
            url = "<c:url value='/admin/education/checkOutAll' />";
            data.outTime = time;
        }

        $.ajax({
            url: url,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function(response) {
                if (response === 'success') {
                    alert(actionType === 'checkIn' ? "전체 입실 처리가 완료되었습니다." : "전체 퇴실 처리가 완료되었습니다.");
                    location.reload(); // 페이지 새로고침
                } else {
                    alert(actionType === 'checkIn' ? "전체 입실 처리에 실패하였습니다." : "전체 퇴실 처리에 실패하였습니다.");
                }
            },
            error: function(xhr, status, error) {
                console.error("Error status:", status);
                console.error("Error details:", error);
                alert(actionType === 'checkIn' ? "전체 입실 처리 중 오류가 발생하였습니다." : "전체 퇴실 처리 중 오류가 발생하였습니다.");
            }
        });

        attendanceModal.hide();  // 모달 닫기
    });

    
 // 결석 처리 버튼 클릭 시
    $('#attendAllAbsence').click(function() {
        console.log("결석 처리 버튼 클릭됨");
        selectedAttendanceCodes = [];
        $('input[name="rowCheck"]:checked').each(function() {
            selectedAttendanceCodes.push($(this).val());
        });

        if (selectedAttendanceCodes.length === 0) {
            alert("결석 처리할 수강생을 선택해주세요.");
            return;
        }

        // 결석처리 확인 메시지
        if (!confirm("결석처리를 하시겠습니까?")) {
            return; // 사용자가 취소 버튼을 누른 경우, 함수 종료
        }

        $.ajax({
            url: "<c:url value='/admin/education/allAbsence' />",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ attendCodes: selectedAttendanceCodes }),
            success: function(response) {
                if (response === 'success') {
                    alert("전체 결석 처리가 완료되었습니다.");

                    // 상태 업데이트 및 버튼 비활성화
                    selectedAttendanceCodes.forEach(function(code) {
                        var row = $('tr').find('span[data-attend-code="' + code + '"]').closest('tr');
                        
                        // 입실 시간, 퇴실 시간, 출석일을 null로 설정
                        row.find('td:nth-child(6)').text(''); // 입실시간
                        row.find('td:nth-child(7)').text(''); // 퇴실시간
                        row.find('td:nth-child(5)').text(''); // 출석일
                        
                        // 상태를 결석으로 업데이트
                        row.find('td:nth-child(4)').text('결석'); 
                        
                        // 입실/퇴실 버튼 비활성화
                        row.find('.status-box.status-attend').css('pointer-events', 'none').css('opacity', '0.5');
                        row.find('.status-box.status-absent').css('pointer-events', 'none').css('opacity', '0.5');
                    });

                } else {
                    alert("전체 결석 처리에 실패하였습니다.");
                }
            },
            error: function() {
                alert("전체 결석 처리 중 오류가 발생하였습니다.");
            }
        });
    });
 
 
 
    // 엑셀 다운로드 버튼 클릭 시
    $('#excelDown').on('click', function(){
        const attendanceForm = $('#allAttendancenForm');  // 현재 form 선택
        const originalAction = attendanceForm.attr('action');

        // 엑셀 다운로드 경로로 form action 설정
        attendanceForm.attr('action', '<c:url value="/admin/education/attendanceExcelDownload"/>');
        
        attendanceForm.submit();  // form 제출로 검색 조건과 함께 전송
        
        attendanceForm.attr('action', originalAction);  // action 원래 경로로 복구
    });

}); 

</script>