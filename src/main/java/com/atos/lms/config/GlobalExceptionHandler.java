package com.atos.lms.config;

import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.utl.ResponseHelper;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.NoHandlerFoundException;

import java.util.NoSuchElementException;

@ControllerAdvice
public class GlobalExceptionHandler {

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    @ExceptionHandler(NoSuchElementException.class)
    public Object handleNotFoundException(NoSuchElementException ex, HttpServletRequest request) {
        logger.warn("NoSuchElementException: ", ex);
        return buildErrorResponse("404", "Page Not Found", HttpStatus.NOT_FOUND, ex, request);
    }

    @ExceptionHandler(AccessDeniedException.class)
    public Object handleAccessDeniedException(AccessDeniedException ex, HttpServletRequest request) {
        logger.warn("AccessDeniedException: ", ex);
        return buildErrorResponse("403", "Access Denied", HttpStatus.FORBIDDEN, ex, request);
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public Object handleBadRequestException(IllegalArgumentException ex, HttpServletRequest request) {
        logger.warn("IllegalArgumentException: ", ex);
        return buildErrorResponse("400", "Bad Request", HttpStatus.BAD_REQUEST, ex, request);
    }

    @ExceptionHandler(AuthenticationException.class)
    public Object handleAuthenticationException(AuthenticationException ex, HttpServletRequest request) {
        logger.warn("AuthenticationException: ", ex);
        return buildErrorResponse("401", "Unauthorized Access", HttpStatus.UNAUTHORIZED, ex, request);
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public Object handleHttpMessageNotReadableException(HttpMessageNotReadableException ex, HttpServletRequest request) {
        logger.warn("HttpMessageNotReadableException: ", ex);
        return buildErrorResponse("400", "잘못된 요청 형식입니다.", HttpStatus.BAD_REQUEST, ex, request);
    }

    @ExceptionHandler(Exception.class)
    public Object handleInternalServerError(Exception ex, HttpServletRequest request) {
        logger.error("Exception: ", ex);
        return buildErrorResponse("500", "Internal Server Error", HttpStatus.INTERNAL_SERVER_ERROR, ex, request);
    }
    @ExceptionHandler(NoHandlerFoundException.class)
    public Object handleNoHandlerFoundException(NoHandlerFoundException ex, HttpServletRequest request) {
        logger.warn("NoHandlerFoundException: ", ex);
        return buildErrorResponse("404", "Page Not Found", HttpStatus.NOT_FOUND, ex, request);
    }

    private Object buildErrorResponse(String errorCode, String message, HttpStatus status, Exception ex, HttpServletRequest request) {
        if (isJsonRequest(request)) {
            ResponseVO<?> responseVO = ResponseHelper.error(errorCode, message, status, isDevEnvironment() ? ex.getMessage() : null);
            return new ResponseEntity<>(responseVO, status);
        } else {
            ModelAndView mav = new ModelAndView("atos/common/error/error");
            mav.addObject("errorCode", errorCode);
            mav.addObject("errorMessage", message);
            if (isDevEnvironment()) {
                mav.addObject("debugMessage", ex.getMessage());
            }
            return mav;
        }
    }

    // 요청이 JSON 응답을 필요로 하는지 확인
    private boolean isJsonRequest(HttpServletRequest request) {
        String acceptHeader = request.getHeader("Accept");
        String contentType = request.getContentType();
        return (acceptHeader != null && acceptHeader.contains("application/json")) ||
                (contentType != null && contentType.contains("application/json"));
    }

    // 개발 환경 여부 확인 (환경에 따라 로직 수정 필요)
    private boolean isDevEnvironment() {
        String env = System.getenv("APP_ENV");
        return "development".equalsIgnoreCase(env);
    }
}
