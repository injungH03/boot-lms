package com.atos.lms.common.utl;

import com.atos.lms.common.model.ResponseVO;
import org.springframework.http.HttpStatus;

import java.util.Collection;

public class ResponseHelper {

    // 성공 응답 (메시지만)
    public static <T> ResponseVO<T> success(String message) {
        return ResponseVO.<T>builder()
                .httpStatus(HttpStatus.OK)
                .message(message)
                .status(true)
                .build();
    }

    // 성공 응답 (메시지와 결과 포함)
    public static <T> ResponseVO<T> successWithResult(String message, T result) {
        int count = 0;
        if (result instanceof Collection) {
            count = ((Collection<?>) result).size();
        }
        return ResponseVO.<T>builder()
                .httpStatus(HttpStatus.OK)
                .message(message)
                .result(result)
                .count(count)
                .status(true)
                .build();
    }
    // 성공 응답 (데이터 만)
    public static <T> ResponseVO<T> successWithResult(T result) {
        int count = 0;
        if (result instanceof Collection) {
            count = ((Collection<?>) result).size();
        }
        return ResponseVO.<T>builder()
                .httpStatus(HttpStatus.OK)
                .result(result)
                .count(count)
                .status(true)
                .build();
    }

    // 에러 응답
    public static <T> ResponseVO<T> error(String errorCode, String message, HttpStatus status, String debugMessage) {
        return ResponseVO.<T>builder()
                .httpStatus(status)
                .message(message)
                .status(false)
                .errorCode(errorCode)
                .debugMessage(debugMessage)
                .build();
    }


}

