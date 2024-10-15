package com.atos.lms.business.member.model;

import com.atos.lms.common.model.GeneralModel;
import lombok.Data;

@Data
public class RoleVO implements GeneralModel {

    private String roleCode;
    private String roleName;

}
