package com.atos.lms.common.model;

import lombok.Builder;
import lombok.Data;
import org.springframework.http.HttpStatus;

import java.util.List;

@Data
@Builder
public class ResponseVO implements GeneralModel {
    private HttpStatus httpStatus;
    private String message;
    private List<?> result;
    private int count;
    private boolean status;

    public int getCode() {
        return httpStatus.value();
    }
}
