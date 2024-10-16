package com.atos.lms.common.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.http.HttpStatus;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
public class ResponseVO<T> implements GeneralModel {
    private HttpStatus httpStatus;
    private String message;
    private T result;
    private int count;
    private boolean status;
    private String errorCode;       // 선택적
    private String debugMessage;    // 선택적

    public int getCode() {
        return httpStatus.value();
    }
}
