package com.atos.lms.common.model;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class MenuVO implements GeneralModel {

    private String menuCode;
    private String menuName;
    private String parentCode;
    private String url;
    private int displayOrder;
    private int activeFlag;
    private String baseUrl;
    private List<MenuVO> subMenuItems = new ArrayList<>();
}
