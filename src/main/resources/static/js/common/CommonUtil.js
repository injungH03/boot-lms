/****************************************************************
 *
 * 파일명 : CommonUtil.js
 * 설명  : 공통 함수 정의
 *
 * 작성일         작성자        작성내용
 * ----------   ---------   ----------------------------
 * 2024.10.02   김권영        필드 정렬 최초 작성
 *
 * 수정일         수정자        수정내용
 * ----------   ---------   ----------------------------
 * 2024.10.07   김권영        전화번호 함수 추가
 * 2024.10.12   김권영        공통 페이징 함수 추가
 *
 */

//사용법 : th에 data-sort="컬럼명" 추가, VO 객체에 sortField, sortOrder 추가
function handleSort(tableSelector, formSelector, initialSortField, initialSortOrder) {
    // 동적 CSS 추가: sorted-asc와 sorted-desc 클래스 스타일 추가
    var styleElement = document.createElement('style');
    styleElement.innerHTML =
        'th.sorted-asc::after {' +
        '    content: " ▲";' +
        '}' +
        'th.sorted-desc::after {' +
        '    content: " ▼";' +
        '}';
    document.head.appendChild(styleElement);

    // 폼에 hidden input이 있는지 확인하고, 없으면 생성하며 초기 값을 설정
    if ($(formSelector).find('input[name="sortField"]').length === 0) {
        $('<input>').attr({
            type: 'hidden',
            name: 'sortField',
            id: 'sortField',
            value: initialSortField // 초기 값을 설정
        }).appendTo(formSelector);
    }

    if ($(formSelector).find('input[name="sortOrder"]').length === 0) {
        $('<input>').attr({
            type: 'hidden',
            name: 'sortOrder',
            id: 'sortOrder',
            value: initialSortOrder // 초기 값을 설정
        }).appendTo(formSelector);
    }

    // 기존 정렬 상태에 맞게 클래스 설정
    if (initialSortField && initialSortOrder) {
        $(tableSelector).find('th').removeClass('sorted-asc sorted-desc'); // 모든 헤더에서 정렬 클래스를 제거
        $(tableSelector).find('th[data-sort="' + initialSortField + '"]').addClass('sorted-' + initialSortOrder.toLowerCase());
    }

    // 테이블 헤더의 정렬 필드 클릭 시 이벤트 처리
    $(tableSelector).find('th[data-sort]').on('click', function() {
        var clickedSortField = $(this).data('sort');

        // 현재 정렬 필드와 순서를 가져옴
        var currentSortField = $(formSelector).find('input[name="sortField"]').val();
        var currentSortOrder = $(formSelector).find('input[name="sortOrder"]').val();

        // 새로운 정렬 순서 설정 (기본: ASC, 동일 필드 클릭 시 토글)
        var newSortOrder = 'ASC';
        if (currentSortField === clickedSortField) {
            newSortOrder = currentSortOrder === 'ASC' ? 'DESC' : 'ASC';
        }

        // 새로운 정렬 필드 및 순서를 hidden input에 설정
        $(formSelector).find('input[name="sortField"]').val(clickedSortField);
        $(formSelector).find('input[name="sortOrder"]').val(newSortOrder);

        // 정렬 상태에 맞게 클래스 설정
        $(tableSelector).find('th').removeClass('sorted-asc sorted-desc'); // 모든 헤더에서 정렬 클래스를 제거
        $(this).addClass('sorted-' + newSortOrder.toLowerCase()); // 클릭한 헤더에 새로운 정렬 클래스 추가

        // 폼 제출
        $(formSelector).submit();
    });
}


function autoHyphenForPhone(selector) {
    $(selector).on('input', function(e) {
        var input = $(this).val().replace(/[^0-9]/g, '');  // 숫자 이외의 문자 제거
        var formattedInput = '';

        // 입력 값이 11자리까지만 입력 가능 (010-1234-5678 형식이므로 11자리)
        if (input.length > 11) {
            input = input.substring(0, 11);  // 최대 11자리까지만 유지
        }

        // 하이픈 추가
        if (input.length >= 4 && input.length <= 7) {
            formattedInput = input.slice(0, 3) + '-' + input.slice(3);
        } else if (input.length > 7) {
            formattedInput = input.slice(0, 3) + '-' + input.slice(3, 7) + '-' + input.slice(7);
        } else {
            formattedInput = input;
        }

        // 입력 필드에 포맷된 값 다시 설정
        $(this).val(formattedInput);
    });

    // 백스페이스로 하이픈을 처리할 수 있게 keydown 이벤트 사용
    $(selector).on('keydown', function(e) {
        var input = $(this).val();
        if (e.key === 'Backspace') {
            if (input.slice(-1) === '-') {
                $(this).val(input.slice(0, -1));  // 마지막 문자가 하이픈이면 하이픈만 삭제
            }
        }
    });
}

function fn_select_linkPage(formId, pageNo){
    var form = document.getElementById(formId);

    var existingPageInput = form.querySelector('input[name="pageIndex"]');
    if (existingPageInput) {
        existingPageInput.value = pageNo;
    } else {
        var input = document.createElement('input');
        input.type = 'hidden';
        input.name = 'pageIndex';
        input.value = pageNo;
        form.appendChild(input);
    }

    form.submit();
}
