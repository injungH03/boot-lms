<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>



<!-- 모달 내용 -->
<div class="modal fade" id="scheduleModal" tabindex="-1" aria-labelledby="scheduleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="scheduleModalLabel">스케줄 등록</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
      </div>
      <div class="modal-body">
        <form id="scheduleForm">
          <div class="mb-3">
            <label for="modalInstructorId" class="form-label">강사명</label>
            <select name="instructor" id="modalInstructorId" class="form-select search-selectle me-2" required>
              <option value="">강사 선택</option>
              <!-- 강사 목록 표시 -->
              <c:forEach var="instructor" items="${instructorList}">
                <option value="${instructor.id}">${instructor.name}</option>
              </c:forEach>
            </select>
          </div>
          <div class="mb-3">
            <label for="mainEvent" class="form-label">타이틀</label>
            <input type="text" class="form-control" id="mainEvent" name="mainEvent" required>
          </div>
          <div class="mb-3">
            <label for="startDate" class="form-label">시작일</label>
            <input type="date" class="form-control" id="startDate" name="startDate" required>
          </div>
          <div class="mb-3">
            <label for="endDate" class="form-label">종료일</label>
            <input type="date" class="form-control" id="endDate" name="endDate" required>
          </div>
          <div class="mb-3">
            <label for="scheduleColor" class="form-label">색상 선택</label>
            <input type="color" class="form-control" id="scheduleColor" name="scheduleColor" required>
          </div>
        </form>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-primary" id="saveScheduleBtn">저장</button>
      </div>
    </div>
  </div>
</div>
