package com.atos.lms.common.service;

import com.atos.lms.common.model.MenuVO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuService {

    private final MenuDAO menuDAO;

    @Autowired
    public MenuService(MenuDAO menuDAO) {
        this.menuDAO = menuDAO;
    }

    @Cacheable("headerMenus")
    public List<MenuVO> getHeaderMenus() {
        System.out.println("헤더메뉴 캐싱 데이터베이스 조회 확인");
        return menuDAO.selectHeaderMenu();
    }

    @Cacheable("subMenus")
    public Map<String, List<MenuVO>> getSubMenus() {
        System.out.println("서브메뉴 캐싱 데이터베이스 조회 확인");
        List<MenuVO> allSubMenus = menuDAO.selectSubMenu();
        Map<String, List<MenuVO>> subMenuMap = new HashMap<>();
        for (MenuVO menu : allSubMenus) {
            subMenuMap.computeIfAbsent(menu.getParentCode(), k -> new ArrayList<>()).add(menu);
        }
        return subMenuMap;
    }
}
