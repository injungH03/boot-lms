/****************************************************************
 *
 * 파일명 : FetchFunction.js
 * 설명  : 비동기(ajax,fetch) 함수 공통 일반화
 * 사용법 : myFetch 호출
 *
 * 작성일         작성자        작성내용
 * ----------   ---------   ----------------------------
 * 2024.09.02   김권영        함수 작성
 *
 * 수정일         수정자        수정내용
 * ----------   ---------   ----------------------------
 * 2024.09.16   김권영        String 데이터 추가
 * 2024.10.08   김권영        헤더 및 폼데이터 파일 업로드 처리 추가
 * 2024.10.12   김권영        보안 csrf토큰 추가
 * 2024.10.16   김권영        에러 ResponseVO 활용
 */

const myFetch = (args) => {
    let body;
    let contentType = "application/json; charset=utf-8";
    let processData = true;
	let headers = {
        "Accept": "application/json"
    };

    // CSRF 토큰을 헤더에 추가 (JSP에서 선언된 전역 변수 사용)
    if (typeof csrfParameterName !== 'undefined' && typeof csrfTokenValue !== 'undefined') {
        headers[csrfParameterName] = csrfTokenValue;
    }

    if (args.isFormData) {
	    const formElement = document.getElementById(args.data);
        if (!(formElement instanceof HTMLFormElement)) {
            console.error(`Element with id '${args.data}' is not a form element.`);
            return; // 폼 요소가 아닌 경우 함수 종료
        }

		body = new FormData(formElement);

        contentType = false; // jQuery가 contentType을 설정하지 않도록 함
        processData = false; // jQuery가 데이터를 처리하지 않도록 함
    } else if (typeof(args.data) === "string") {
        body = {};
        $('#' + args.data).serializeArray().forEach(function(item) {
            body[item.name] = item.value;
        });
        body = JSON.stringify(body);
    } else {
        body = JSON.stringify(args.data);
    }

    $.ajax({
        type: "POST",
        url: args.url,
        data: body,
        contentType: contentType,
        processData: processData,
        dataType: "json",
		headers: headers
    }).done(resp => {
        args.success(resp);
    }).fail(err => {
              if (args.error != null) {
                  if (err.responseJSON && typeof err.responseJSON === 'object') {
                      const response = err.responseJSON;
                      const errorMessage = response.message || '알 수 없는 오류가 발생했습니다.';
                      args.error(errorMessage);
                  } else {
                      args.error(typeof (err.responseText) === 'string' ? err.responseText : JSON.stringify(err));
                  }
              }
          });
      };