package com.atos.lms.config;

import com.nimbusds.oauth2.sdk.ErrorResponse;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.AccessDeniedException;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.servlet.ModelAndView;

import javax.security.sasl.AuthenticationException;
import java.util.NoSuchElementException;

@ControllerAdvice
public class ControllerAdviceCustom {

    @ExceptionHandler(NoSuchElementException.class)
    @ResponseStatus(HttpStatus.NOT_FOUND)
    public String handleNotFoundException(Model model) {
        model.addAttribute("errorCode", "404");
        model.addAttribute("errorMessage", "Page Not Found");
        return "atos/common/error/error";
    }

    @ExceptionHandler(AccessDeniedException.class)
    @ResponseStatus(HttpStatus.FORBIDDEN)
    public String handleForbiddenException(Model model) {
        model.addAttribute("errorCode", "403");
        model.addAttribute("errorMessage", "Access Denied");
        return "atos/common/error/error";
    }

    @ExceptionHandler(IllegalArgumentException.class)
    @ResponseStatus(HttpStatus.BAD_REQUEST)
    public String handleBadRequestException(Model model) {
        model.addAttribute("errorCode", "400");
        model.addAttribute("errorMessage", "Bad Request");
        return "atos/common/error/error";
    }

    @ExceptionHandler(AuthenticationException.class)
    @ResponseStatus(HttpStatus.UNAUTHORIZED)
    public String handleUnauthorizedException(Model model) {
        model.addAttribute("errorCode", "401");
        model.addAttribute("errorMessage", "Unauthorized Access");
        return "atos/common/error/error";
    }

    @ExceptionHandler(Exception.class)
    @ResponseStatus(HttpStatus.INTERNAL_SERVER_ERROR)
    public String handleInternalServerError(Model model) {
        model.addAttribute("errorCode", "500");
        model.addAttribute("errorMessage", "Internal Server Error");
        return "atos/common/error/error";
    }


    @ModelAttribute
    public void addAttributes(Model model) {
        model.addAttribute("pageTitle", "안전교육센터");  // 기본 타이틀
    }

}

