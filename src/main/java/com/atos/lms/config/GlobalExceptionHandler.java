package com.atos.lms.config;

import com.atos.lms.common.model.ResponseVO;
import com.atos.lms.common.utl.GlobalsProperties;
import com.atos.lms.common.utl.ResponseHelper;
import jakarta.servlet.http.HttpServletRequest;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
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

    private final GlobalsProperties globalsProperties;

    private static final Logger logger = LoggerFactory.getLogger(GlobalExceptionHandler.class);

    public GlobalExceptionHandler(GlobalsProperties globalsProperties) {
        this.globalsProperties = globalsProperties;
    }

    @ExceptionHandler(NoSuchElementException.class)
    public Object handleNotFoundException(NoSuchElementException ex, HttpServletRequest request) {
        logger.warn("NoSuchElementException: ", ex);
        if (isJsonRequest(request)) {
            return buildJsonErrorResponse("404", "Page Not Found", HttpStatus.NOT_FOUND, ex);
        } else {
            return buildHtmlErrorResponse("404", "Page Not Found", ex);
        }
    }

    @ExceptionHandler(AccessDeniedException.class)
    public Object handleAccessDeniedException(AccessDeniedException ex, HttpServletRequest request) {
        logger.warn("AccessDeniedException: ", ex);
        if (isJsonRequest(request)) {
            return buildJsonErrorResponse("403", "Access Denied", HttpStatus.FORBIDDEN, ex);
        } else {
            return buildHtmlErrorResponse("403", "Access Denied", ex);
        }
    }

    @ExceptionHandler(IllegalArgumentException.class)
    public Object handleBadRequestException(IllegalArgumentException ex, HttpServletRequest request) {
        logger.warn("IllegalArgumentException: ", ex);
        if (isJsonRequest(request)) {
            return buildJsonErrorResponse("400", ex.getMessage(), HttpStatus.BAD_REQUEST, ex);
        } else {
            return buildHtmlErrorResponse("400", ex.getMessage(), ex);
        }
    }

    @ExceptionHandler(AuthenticationException.class)
    public Object handleAuthenticationException(AuthenticationException ex, HttpServletRequest request) {
        logger.warn("AuthenticationException: ", ex);
        if (isJsonRequest(request)) {
            return buildJsonErrorResponse("401", "Unauthorized Access", HttpStatus.UNAUTHORIZED, ex);
        } else {
            return buildHtmlErrorResponse("401", "Unauthorized Access", ex);
        }
    }

    @ExceptionHandler(HttpMessageNotReadableException.class)
    public Object handleHttpMessageNotReadableException(HttpMessageNotReadableException ex, HttpServletRequest request) {
        logger.warn("HttpMessageNotReadableException: ", ex);
        if (isJsonRequest(request)) {
            return buildJsonErrorResponse("400", "잘못된 요청 형식입니다.", HttpStatus.BAD_REQUEST, ex);
        } else {
            return buildHtmlErrorResponse("400", "잘못된 요청 형식입니다.", ex);
        }
    }

    @ExceptionHandler(NoHandlerFoundException.class)
    public Object handleNoHandlerFoundException(NoHandlerFoundException ex, HttpServletRequest request) {
        logger.warn("NoHandlerFoundException: ", ex);
        if (isJsonRequest(request)) {
            return buildJsonErrorResponse("404", "Page Not Found", HttpStatus.NOT_FOUND, ex);
        } else {
            return buildHtmlErrorResponse("404", "Page Not Found", ex);
        }
    }

    @ExceptionHandler(Exception.class)
    public Object handleInternalServerError(Exception ex, HttpServletRequest request) {
        logger.error("Exception: ", ex);
        if (isJsonRequest(request)) {
            return buildJsonErrorResponse("500", "Internal Server Error", HttpStatus.INTERNAL_SERVER_ERROR, ex);
        } else {
            return buildHtmlErrorResponse("500", "Internal Server Error", ex);
        }
    }

    private ResponseEntity<ResponseVO<Void>> buildJsonErrorResponse(String errorCode, String message, HttpStatus status, Exception ex) {
        ResponseVO<Void> responseVO = ResponseHelper.error(errorCode, message, status, isDevEnvironment() ? ex.getMessage() : null);
        return new ResponseEntity<>(responseVO, status);
    }

    private ModelAndView buildHtmlErrorResponse(String errorCode, String message, Exception ex) {
        ModelAndView mav = new ModelAndView("atos/common/error/error");
        mav.addObject("errorCode", errorCode);
        mav.addObject("errorMessage", message);
        if (isDevEnvironment()) {
            mav.addObject("debugMessage", ex.getMessage());
        }
        return mav;
    }

    private boolean isJsonRequest(HttpServletRequest request) {
        String acceptHeader = request.getHeader("Accept");
        return acceptHeader != null && acceptHeader.contains(MediaType.APPLICATION_JSON_VALUE);
    }

    private boolean isDevEnvironment() {
        String env = globalsProperties.getLocalDev();
        return "development".equalsIgnoreCase(env);
    }
}

