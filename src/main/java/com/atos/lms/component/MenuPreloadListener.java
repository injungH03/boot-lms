package com.atos.lms.component;

import com.atos.lms.common.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.cache.CacheManager;
import org.springframework.context.ApplicationListener;
import org.springframework.context.event.ContextClosedEvent;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.stereotype.Component;

@Component
public class MenuPreloadListener implements ApplicationListener<ContextRefreshedEvent> {

    private final MenuService menuService;
    private final CacheManager cacheManager;

    @Autowired
    public MenuPreloadListener(MenuService menuService, CacheManager cacheManager) {
        this.menuService = menuService;
        this.cacheManager = cacheManager;
    }


    @Override
    public void onApplicationEvent(ContextRefreshedEvent  event) {
        cacheManager.getCache("headerMenus").put("headerMenus", menuService.getHeaderMenus());
        cacheManager.getCache("subMenus").put("subMenus", menuService.getSubMenus());

        System.out.println("메뉴가 캐시에 저장되었습니다.");
    }
}
