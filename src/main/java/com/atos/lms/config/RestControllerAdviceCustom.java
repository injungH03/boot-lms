package com.atos.lms.config;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.RestControllerAdvice;

import java.util.NoSuchElementException;

@RestControllerAdvice
public class RestControllerAdviceCustom {

    @ExceptionHandler(NoSuchElementException.class)
    public ResponseEntity<ErrorResponse> handleNotFoundException(NoSuchElementException ex) {
        System.err.println("handleNotFoundException 호출됨: " + ex.getMessage());
        ErrorResponse error = new ErrorResponse("404", "Page Not Found");
        return new ResponseEntity<>(error, HttpStatus.NOT_FOUND);
    }

    @ExceptionHandler(org.springframework.security.access.AccessDeniedException.class)
    public ResponseEntity<ErrorResponse> handleAccessDeniedException(org.springframework.security.access.AccessDeniedException ex) {
        System.err.println("handleAccessDeniedException 호출됨: " + ex.getMessage());
        ErrorResponse error = new ErrorResponse("403", "Access Denied");
        return new ResponseEntity<>(error, HttpStatus.FORBIDDEN);
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<ErrorResponse> handleBadRequestException(IllegalArgumentException ex) {
        System.err.println("handleBadRequestException 호출됨: " + ex.getMessage());
        ErrorResponse error = new ErrorResponse("400", "Bad Request");
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }

    @ExceptionHandler(org.springframework.security.core.AuthenticationException.class)
    public ResponseEntity<ErrorResponse> handleAuthenticationException(org.springframework.security.core.AuthenticationException ex) {
        System.err.println("handleAuthenticationException 호출됨: " + ex.getMessage());
        ErrorResponse error = new ErrorResponse("401", "Unauthorized Access");
        return new ResponseEntity<>(error, HttpStatus.UNAUTHORIZED);
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<ErrorResponse> handleInternalServerError(Exception ex) {
        System.err.println("handleInternalServerError 호출됨: " + ex.getMessage());
        ErrorResponse error = new ErrorResponse("500", "Internal Server Error");
        return new ResponseEntity<>(error, HttpStatus.INTERNAL_SERVER_ERROR);
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public ResponseEntity<ErrorResponse> handleHttpMessageNotReadableException(HttpMessageNotReadableException ex) {
        System.err.println("handleHttpMessageNotReadableException 호출됨: " + ex.getMessage());
        ErrorResponse error = new ErrorResponse("400", "잘못된 요청 형식입니다.");
        return new ResponseEntity<>(error, HttpStatus.BAD_REQUEST);
    }

    // 에러 응답을 위한 내부 클래스
    public static class ErrorResponse {
        private String errorCode;
        private String errorMessage;

        public ErrorResponse(String errorCode, String errorMessage) {
            this.errorCode = errorCode;
            this.errorMessage = errorMessage;
        }

        // Getters and Setters
        public String getErrorCode() {
            return errorCode;
        }

        public void setErrorCode(String errorCode) {
            this.errorCode = errorCode;
        }

        public String getErrorMessage() {
            return errorMessage;
        }

        public void setErrorMessage(String errorMessage) {
            this.errorMessage = errorMessage;
        }
    }
}

