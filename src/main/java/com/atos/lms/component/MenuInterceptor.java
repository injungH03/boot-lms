package com.atos.lms.component;

import com.atos.lms.common.model.MenuVO;
import com.atos.lms.common.service.MenuService;
import com.atos.lms.common.utl.GlobalsProperties;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.Cache;
import org.springframework.cache.CacheManager;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;
import java.util.Map;

@Component
public class MenuInterceptor implements HandlerInterceptor {

    private final MenuService menuService;
    private final GlobalsProperties globalsProperties;

    @Autowired
    public MenuInterceptor(MenuService menuService, GlobalsProperties globalsProperties) {
        this.menuService = menuService;
        this.globalsProperties = globalsProperties;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response,
                           Object handler, ModelAndView modelAndView) throws Exception {
        if (modelAndView != null) {
            // 헤더 메뉴와 서브 메뉴를 가져옴
            List<MenuVO> headerMenus = menuService.getHeaderMenus();
            Map<String, List<MenuVO>> subMenus = menuService.getSubMenus();

            // 서브 메뉴를 각 헤더 메뉴에 붙임
            for (MenuVO headerMenu : headerMenus) {
                headerMenu.setSubMenuItems(subMenus.get(headerMenu.getMenuCode()));
            }

            // JSP로 전달
            modelAndView.addObject("headerMenus", headerMenus);
            modelAndView.addObject("siteMapUrl", globalsProperties.getLocalReactUrl() + "/react-main");
        }
    }


}

