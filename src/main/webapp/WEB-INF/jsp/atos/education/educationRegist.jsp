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
        <span>&nbsp;교육 과정 등록</span>
    </div>

<div class="table-section">

  <form id="registForm" method="post">
        <table class="search-table regist-table">
            <!-- 과정 선택 -->
             <tr>
			    <th>과정 선택*</th>
			    <td colspan="3">
			        <select name="category" id="category" class="form-select me-2 custom-width" required>
			            <option value="">과정 선택</option>
			            <c:forEach var="category" items="${categories}">
			                <option value="${category.code}">
			                    ${category.mainName}
			                    <!-- 소분류 관련 코드 제거 -->
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
                    <input type="text" id="title" name="title" class="form-control" required />
                </td>
            </tr>

            <!-- 교육 시간 -->
			<tr>
			    <th>교육 시간*</th>
			    <td colspan="3">
			        <input type="number" id="trainingTime" name="trainingTime" class="form-control" required />
			    </td>
			</tr>

            <!-- 수료 조건 -->
            <tr>
                <th>수료 조건*</th>
                <td colspan="3">
                    <select name="completionCriteria" id="completionCriteria" class="form-select" required>
                        <option value="">수료 조건 선택</option>
                        <c:forEach var="criteria" items="${completionCriteria}">
                            <option value="${criteria.completionCode}">
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
                    <input type="text" id="register" name="register" class="form-control" />
                </td>
            </tr>
            <!-- 과정 소개 및 과정 목표 -->
            <tr>
                <th>과정 소개*</th>
                <td colspan="3">
                    <textarea name="description" id="description" class="form-control" rows="5" required></textarea>
                </td>
            </tr>
            <tr>
                <th>과정 목표*</th>
                <td colspan="3">
                    <textarea name="objective" id="objective" class="form-control" rows="5" required></textarea>
                </td>
            </tr>

            <!-- 비고란 -->
            <tr>
                <th>비고</th>
                <td colspan="3">
                    <textarea name="note" id="note" class="form-control" rows="3"></textarea>
                </td>
            </tr>

        </table>

        <!-- 등록 및 목록 버튼 -->
        <div class="d-flex justify-content-between mt-3">
            <button type="submit" class="btn btn-success" id="submitBtn">등록</button>
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
            descriptionEditor = editor;  // description 필드에 대한 CKEditor 인스턴스 저장
        })
        .catch(error => {
            console.error('Description Editor 초기화 오류:', error);
        });

    ClassicEditor
        .create(document.querySelector('#objective'))
        .then(editor => {
            objectiveEditor = editor;  // objective 필드에 대한 CKEditor 인스턴스 저장
        })
        .catch(error => {
            console.error('Objective Editor 초기화 오류:', error);
        });


    // 교육 시간 입력란에 숫자만 입력 가능하도록 제한하고, 경고창 띄우기
 $('#trainingTime').on('input', function() {
    const trainingTimeValue = $(this).val();
    if (!/^\d+$/.test(trainingTimeValue)) {  // 숫자가 아닌 경우
        alert('숫자를 입력하세요.');  // 경고창 띄우기
        $(this).val('');  // 입력값을 초기화
    }
});

    // 한글 1500자, 영문 2000자 제한 기능
    function limitTextLength(text, maxKoreanChars, maxEnglishChars) {
        const koreanCharCount = (text.match(/[\u3131-\uD79D]/g) || []).length;  // 한글 글자 수
        const totalLength = text.length;
        const englishCharCount = totalLength - koreanCharCount;  // 전체 길이에서 한글 글자 수를 빼면 영문 글자 수

        // 한글과 영문 제한 체크
        if (koreanCharCount > maxKoreanChars || englishCharCount > maxEnglishChars) {
            alert(`한글은 ${maxKoreanChars}자, 영문은 ${maxEnglishChars}자로 제한됩니다.`);
            return true;  // 제한을 넘을 경우 true 리턴
        }
        return false;
    }

    // 과정 소개, 과정 목표, 비고에 한글 1500자, 영문 2000자 제한 적용
    $('#description, #objective, #note').on('input', function() {
        const editorContent = this.value || descriptionEditor.getData() || objectiveEditor.getData();  // CKEditor 데이터 가져오기
        if (limitTextLength(editorContent, 1500, 2000)) {
            this.value = editorContent.substring(0, 1500 + 2000);  // 한글과 영문 합쳐서 자르기
        }
    });

    // 폼 유효성 검사 초기화
    $("#registForm").validate({
        rules: {
            title: { required: true, maxlength: 300 },
            category: { required: true },
            trainingTime: { required: true, digits: true },  // 숫자만 입력 가능
            completionCriteria: { required: true },
            register: { maxlength: 100 },
            description: { required: true, maxlength: 1500 },  // CKEditor로 처리될 필드
            objective: { required: true, maxlength: 1500 },  // CKEditor로 처리될 필드
            note: { maxlength: 2000 }  // 비고는 영문 2000자로 제한
        },
        messages: {
            title: { required: "과정명을 입력하세요.", maxlength: "과정명은 최대 300자까지 입력 가능합니다." },
            category: { required: "과정을 선택하세요." },
            trainingTime: { required: "교육 시간을 입력하세요.", digits: "숫자를 입력하세요." },
            completionCriteria: { required: "수료 조건을 선택하세요." },
            register: { maxlength: "등록자는 최대 100자까지 입력 가능합니다." },
            description: { required: "과정 소개를 입력하세요.", maxlength: "과정 소개는 최대 1500자까지 입력 가능합니다." },
            objective: { required: "과정 목표를 입력하세요.", maxlength: "과정 목표는 최대 1500자까지 입력 가능합니다." },
            note: { maxlength: "비고는 최대 2000자까지 입력 가능합니다." }
        },
        errorElement: 'div',
        errorClass: 'invalid-feedback',
        highlight: function(element) {
            $(element).addClass('is-invalid');
        },
        unhighlight: function(element) {
            $(element).removeClass('is-invalid');
        }
    });

    // 폼 제출 이벤트 처리 (AJAX 처리로 수정)
    $('#registForm').on('submit', function(event) {
        event.preventDefault();  // 기본 폼 제출 방지

        if ($("#registForm").valid()) {
            // CKEditor에서 입력된 텍스트 가져오기
            const description = descriptionEditor.getData();
            const objective = objectiveEditor.getData();

            // 폼 데이터를 JSON 형태로 변환
            const educationData = {
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
                url: '<c:url value="/admin/education/educationInsert" />',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(educationData),
                success: function(response) {
                    if (response.status) {
                        alert(response.message || '교육 과정이 성공적으로 등록되었습니다.');
                        window.location.href = "<c:url value='/admin/education/educationList' />";
                    } else {
                        alert('등록에 실패했습니다: ' + response.message);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('등록 중 오류가 발생했습니다.');
                }
            });
        } else {
            alert('필수 입력란을 확인해주세요.');
        }
    });

});
</script>
