package com.atos.lms.business.exam.model;

import com.atos.lms.common.model.GeneralModel;
import com.atos.lms.common.model.MasterVO;
import lombok.Data;
import lombok.EqualsAndHashCode;

@EqualsAndHashCode(callSuper = true)
@Data
public class TestBoardVO extends MasterVO implements GeneralModel {

    private int boardNum;
    private String writer;
    private String title;
    private String content;
    private String regDate;
    private String atchFileId;

}
