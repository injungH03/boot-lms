package com.atos.lms.business.company.model;


import com.atos.lms.common.model.GeneralModel;
import lombok.Data;

import java.util.List;

@Data
public class CompanyDTO implements GeneralModel {

    private List<String> corpBizList;

    private String companyStatus;


}
