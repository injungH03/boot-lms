package com.atos.lms.common.service;

import com.atos.lms.common.model.MenuVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MenuDAO {

    List<MenuVO> selectHeaderMenu();

    List<MenuVO> selectSubMenu();

}
