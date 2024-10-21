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
        <span>&nbsp;교육 상세정보</span>
    </div>

<div class="table-section">

    <!-- 교육 상세 정보를 보여주는 테이블 -->
    <table class="search-table detail-table">
        <tr>
            <th>교육명</th>
            <td>${educationDetail.title}</td>
            <th>교육분류</th>
            <td>
                <!-- 교육분류는 대분류와 중분류로 표시 -->
                ${educationDetail.mainName}
                <c:if test="${educationDetail.subName != null && !educationDetail.subName.isEmpty()}">
                    > ${educationDetail.subName}
                </c:if>
            </td>
        </tr>
        <tr>
            <th>수료조건</th>
            <td>
                <!-- 수료 조건을 진도율/시험 점수/설문 유무로 표시 -->
                [ 진도율: ${educationDetail.completionRate} ]
                [ 시험 점수: ${educationDetail.completionScore} ]
                [ 설문 유무: ${educationDetail.completionSurvey} ]
            </td>
            <th>교육시간</th>
            <td>${educationDetail.trainingTime}</td> <!-- 교육시간 명칭으로 표시 -->
        </tr>
        <tr>
            <th>등록일</th>
            <td>${educationDetail.regDate}</td>
            <th>등록자</th>
            <td>${educationDetail.register}</td>
        </tr>   
        <tr>
            <th>과정소개</th>
            <td colspan="3">
                <div class="text-container">
                    ${educationDetail.description}
                </div>
            </td>
        </tr>
        <tr>
            <th>과정목표</th>
            <td colspan="3">
                <div class="text-container">
                    ${educationDetail.objective}
                </div>
            </td>
        </tr>
        <tr>
            <th>비고</th>
            <td colspan="3">
                <div class="text-container">
                    ${educationDetail.note}
                </div>
            </td>
        </tr>
    </table>

    <!-- 버튼 그룹 -->
    <div class="mt-3">
        <button type="button" class="btn btn-success me-2" onclick="location.href='<c:url value='/education/educationUpdateView.do?eduCode=${educationDetail.eduCode}' />'">수정</button>
        <button type="button" class="btn btn-secondary me-2" onclick="location.href='<c:url value='/education/educationList.do' />'">목록</button>
        <button type="button" class="btn btn-danger" style="float:right" id="deleteBtn">삭제</button>
    </div>
</div>


</div>



<script>
$(document).ready(function() {
    $('#deleteBtn').on('click', function() {
        if(confirm("정말로 삭제하시겠습니까?")) {
            $.ajax({
                url: '/education/deleteEducation',
                method: 'POST',
                contentType: 'application/json',
                data: JSON.stringify({ eduCode: '${educationDetail.eduCode}' }),
                success: function(response) {
                    // 서버 응답의 HttpStatus를 사용하여 성공 여부를 판단
                    if (response.httpStatus === 'OK') {  
                        alert('삭제 완료되었습니다.');
                        location.href = '/education/educationList.do';
                    } else {
                        alert('삭제에 실패했습니다.');
                    }
                },
                error: function() {
                    alert('서버에서 오류가 발생했습니다.');
                }
            });
        }
    });
});
</script>