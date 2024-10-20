package com.atos.lms.business.member.model;

import com.atos.lms.common.model.GeneralModel;
import lombok.Data;

import java.util.List;

@Data
public class MemberAllDTO implements GeneralModel {

    private List<MemberVO> previewData;
    private String corpBiz;
}
