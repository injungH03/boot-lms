<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="pagination" uri="/WEB-INF/customtag/pagination.tld" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>


<script src="https://cdn.ckeditor.com/ckeditor5/39.0.0/classic/ckeditor.js"></script>
<link type="text/css" rel="stylesheet" href="<c:url value='/css/common/common.css' />">


<jsp:include page="/WEB-INF/jsp/atos/common/layout.jsp" />

<div class="wrap">

  <div class="head-section" style="margin-bottom:20px;">
        <span>&nbsp;교육 과정 수정</span>
    </div>

 <div class="table-section">

 <table class="search-table regist-table">
   <form id="registForm" method="post">
            <!-- 과정 선택 -->
            <tr>
                <th>과정 선택*</th>
                <td colspan="3">
                    <select name="category" id="category" class="form-select me-2" required>
                        <c:forEach var="category" items="${categories}">
                            <option value="${category.code}" <c:if test="${category.code == educationDetail.category}">selected</c:if>>
                                ${category.mainName}
                                <c:if test="${category.subName != null}"> > ${category.subName}</c:if>
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <!-- 과정명 -->
            <tr>
                <th>과정명*</th>
                <td colspan="3">
                    <input type="text" id="title" name="title" class="form-control" value="${educationDetail.title}" required />
                </td>
            </tr>

            <!-- 교육 시간 -->
			<tr>
			    <th>교육 시간*</th>
			    <td colspan="3">
			        <input type="text" id="trainingTime" name="trainingTime" class="form-control" value="${educationDetail.trainingTime}" required />
			    </td>
			</tr>

            <!-- 수료 조건 -->
            <tr>
                <th>수료 조건*</th>
                <td colspan="3">
                    <select name="completionCriteria" id="completionCriteria" class="form-select" required>
                        <c:forEach var="criteria" items="${completionCriteria}">
                            <option value="${criteria.completionCode}" <c:if test="${criteria.completionCode == educationDetail.completionCriteria}">selected</c:if>>
                                [ 코드: ${criteria.completionCode} ] [ 진도율: ${criteria.completionRate} ] 
                                [ 시험 점수: ${criteria.completionScore} ] [ 설문 유무: ${criteria.completionSurvey} ]
                            </option>
                        </c:forEach>
                    </select>
                </td>
            </tr>

            <!-- 등록자 -->
            <tr>
                <th>등록자</th>
                <td colspan="3">
                    <input type="text" id="register" name="register" class="form-control" value="${educationDetail.register}" />
                </td>
            </tr>

            <!-- 과정 소개 및 과정 목표 -->
            <tr>
                <th>과정 소개*</th>
                <td colspan="3">
                    <textarea name="description" id="description" class="form-control" rows="5" required>${educationDetail.description}</textarea>
                </td>
            </tr>
            <tr>
                <th>과정 목표*</th>
                <td colspan="3">
                    <textarea name="objective" id="objective" class="form-control" rows="5" required>${educationDetail.objective}</textarea>
                </td>
            </tr>

            <!-- 비고란 -->
            <tr>
                <th>비고</th>
                <td colspan="3">
                    <textarea name="note" id="note" class="form-control" rows="3">${educationDetail.note}</textarea>
                </td>
            </tr>
        </table>

        <!-- 수정 및 목록 버튼 -->
        <div class="d-flex justify-content-between mt-3">
            <button type="submit" class="btn btn-primary">수정</button>
            <button type="button" class="btn btn-secondary" onclick="window.location.href='<c:url value='/admin/education/educationList' />'">목록</button>
        </div>
    </form>
</div>

</div>



<script>

$(document).ready(function() {

    let descriptionEditor;
    let objectiveEditor;

    // CKEditor 설정 및 초기화
    ClassicEditor
        .create(document.querySelector('#description'))
        .then(editor => {
            descriptionEditor = editor;
        })
        .catch(error => {
            console.error('Description Editor 초기화 오류:', error);
        });

    ClassicEditor
        .create(document.querySelector('#objective'))
        .then(editor => {
            objectiveEditor = editor;
        })
        .catch(error => {
            console.error('Objective Editor 초기화 오류:', error);
        });

    // 폼 제출 이벤트 처리 (AJAX 처리)
   $('#registForm').on('submit', function(event) {
    event.preventDefault();  // 기본 폼 제출 방지

    if ($("#registForm").valid()) {
        // CKEditor에서 입력된 텍스트 가져오기
        const description = descriptionEditor.getData();
        const objective = objectiveEditor.getData();

        // 폼 데이터를 JSON 형태로 변환
        const educationData = {
            eduCode: "${educationDetail.eduCode}",  // 수정 시 eduCode 필요
            title: $('#title').val(),
            category: $('#category').val(),
            trainingTime: parseInt($('#trainingTime').val(), 10),
            description: description,
            objective: objective,
            completionCriteria: $('#completionCriteria').val(),
            note: $('#note').val(),
            register: $('#register').val()
        };

        // 서버로 JSON 데이터 전송
        $.ajax({
            url: '<c:url value="/admin/education/educationUpdate" />',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(educationData),
            success: function(response) {
                if (response.status) {  // 서버에서 성공 상태로 응답할 경우
                    alert(response.message || '교육 과정이 성공적으로 수정되었습니다.');
                    window.location.href = "<c:url value='/admin/education/educationList' />";  // 성공 시 목록으로 이동
                } else {
                    alert('수정에 실패했습니다: ' + response.message);  // 실패 시 처리
                }
            },
            error: function(jqXHR, textStatus, errorThrown) {
                alert('수정 중 오류가 발생했습니다.');  // 서버 통신 오류 처리
            }
        });
    } else {
        alert('필수 입력란을 확인해주세요.');
    }
});
});


</script>