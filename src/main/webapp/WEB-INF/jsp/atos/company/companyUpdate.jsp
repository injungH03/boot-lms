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





<div class="head-section">
	<span>&nbsp;업체 정보 수정</span>
</div>
<div class="table-section">

        <form id="companyUpdateForm" method="post" enctype="multipart/form-data">

            <table class="search-table regist-table">
                <tr>
                    <th>사업장명</th>
                    <td><input type="text" name="corpName" class="form-control custom-width" value="<c:out value='${company.corpName}'/>" placeholder="사업장명을 입력하세요" /></td>
                    <th>사업자등록번호</th>
                    <td><input type="text" id="bizRegNo" name="bizRegNo" class="form-control custom-width" value="<c:out value='${company.bizRegNo}'/>" placeholder="사업자등록번호를 입력하세요" readonly /></td>
                </tr>
                <tr>
                    <th>주소</th>
                    <td colspan="4">
                        <div class="d-flex align-items-center">
                            <input type="text" id="zipcode" name="zipcode" class="form-control me-2 custom-width" value="<c:out value='${company.zipcode}'/>" placeholder="우편번호를 검색해주세요" readonly />
                            <button type="button" class="btn btn-sm btn-primary" id="addressSearchButton">주소검색</button>
                        </div>
                        <br />
                        <input type="text" id="address" name="addr1" class="form-control me-2 custom-width" value="<c:out value='${company.addr1}'/>" placeholder="주소를 검색해주세요" readonly />
                        <input type="text" id="detailedAddress" name="addr2" class="form-control mt-2 custom-width" value="<c:out value='${company.addr2}'/>" placeholder="상세주소를 입력하세요" />
                    </td>
                </tr>
                <tr>
                    <th>대표자명</th>
                    <td><input type="text" name="repName" class="form-control custom-width" value="<c:out value='${company.repName}'/>" placeholder="대표자명을 입력하세요" /></td>
                    <th>업태</th>
                    <td><input type="text" name="bizType" class="form-control custom-width" value="<c:out value='${company.bizType}'/>" placeholder="업태를 입력하세요" /></td>
                </tr>
                <tr>
                    <th>종목</th>
                    <td><input type="text" name="bizItem" class="form-control custom-width" value="<c:out value='${company.bizItem}'/>" placeholder="종목을 입력하세요" /></td>
                    <th>전화번호</th>
                    <td><input type="text" name="phoneNo" class="form-control custom-width" value="<c:out value='${company.phoneNo}'/>" placeholder="전화번호를 입력하세요" /></td>
                </tr>
                <tr>
                    <th>세금계산서 메일</th>
                    <td><input type="email" name="taxInvoice" class="form-control custom-width" value="<c:out value='${company.taxInvoice}'/>" placeholder="이메일을 입력하세요" /></td>
                </tr>
                <tr>
                    <th>직원 수</th>
                    <td><input type="number" name="empCount" class="form-control custom-width" value="<c:out value='${company.empCount}'/>" min="1" max="100" placeholder="직원 수를 입력하세요" /></td>
                    <th>교육 인원</th>
                    <td><input type="number" name="trainCount" class="form-control custom-width" value="<c:out value='${company.trainCount}'/>" min="1" max="100" placeholder="교육 인원을 입력하세요" /></td>
                </tr>
                <tr>
                    <th>메모</th>
                    <td colspan="3"><textarea id="memo" name="memo" class="form-control" rows="4"><c:out value='${company.memo}'/></textarea></td>
                </tr>
                <tr>
                    <th>교육 담당자명</th>
                    <td><input type="text" name="trainManager" class="form-control custom-width" value="<c:out value='${company.trainManager}'/>" placeholder="담당자명을 입력하세요" /></td>
                </tr>
                <tr>
                    <th>교육 담당자 이메일</th>
                    <td><input type="email" name="trainEmail" class="form-control custom-width" value="<c:out value='${company.trainEmail}'/>" placeholder="이메일을 입력하세요" /></td>
                    <th>교육 담당자 휴대폰</th>
                    <td><input type="tel" name="trainPhone" class="form-control custom-width" value="<c:out value='${company.trainPhone}'/>" placeholder="휴대폰 번호를 입력하세요" /></td>
                </tr>
                <tr>
                    <th>계산서 담당자명</th>
                    <td><input type="text" name="taxManager" class="form-control custom-width" value="<c:out value='${company.taxManager}'/>" placeholder="담당자명을 입력하세요" /></td>
                </tr>
                <tr>
                    <th>계산서 담당자 이메일</th>
                    <td><input type="email" name="taxEmail" class="form-control custom-width" value="<c:out value='${company.taxEmail}'/>" placeholder="이메일을 입력하세요" /></td>
                    <th>계산서 담당자 휴대폰</th>
                    <td><input type="tel" name="taxPhone" class="form-control custom-width" value="<c:out value='${company.taxPhone}'/>" placeholder="휴대폰 번호를 입력하세요" /></td>
                </tr>
            </table>


            <div class="d-flex justify-content-between mt-3">
                <button type="button" class="btn btn-success" id="submitBtn">수정</button>
                <button type="button" class="btn btn-secondary" id="btnList">목록</button>
            </div>

        </form>
    </div>



</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 수정 버튼 클릭 시 업체 수정 요청
        document.getElementById('submitBtn').addEventListener('click', function(event) {
            event.preventDefault(); // 기본 폼 제출 방지
            var formData = $('#companyUpdateForm').serializeArray();
            var jsonData = {};
            $(formData).each(function(index, obj) {
                jsonData[obj.name] = obj.value;
            });

            $.ajax({
                url: '<c:url value="/admin/company/companyUpdate" />',
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(jsonData),
                success: function(response) {
                    alert(response.message || "수정이 완료되었습니다.");
                    window.location.href = "<c:url value='/admin/company/companyList' />";
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    alert('수정에 실패하였습니다.');
                }
            });
        });

        // 목록 버튼 클릭 시
        document.getElementById('btnList').addEventListener('click', function() {
            window.location.href = "<c:url value='/admin/company/companyList' />";
        });

        // 주소 검색 버튼 클릭 시
        $('#addressSearchButton').on('click', function() {
            new daum.Postcode({
                oncomplete: function(data) {
                    // 우편번호와 주소를 각각 설정
                    $('#zipcode').val(data.zonecode); // 우편번호 설정
                    $('#address').val(data.address); // 기본 주소 설정

                    // 상세주소 입력 필드로 포커스를 이동
                    $('#detailedAddress').focus();
                }
            }).open();
        });




    });



</script>
