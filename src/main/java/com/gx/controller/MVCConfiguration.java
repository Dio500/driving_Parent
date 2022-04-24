package com.gx.controller;

import org.springframework.context.annotation.Configuration;
import org.springframework.core.Ordered;
import org.springframework.web.servlet.config.annotation.ViewControllerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurationSupport;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class MVCConfiguration implements WebMvcConfigurer  {
    @Override
    //输入http://localhost:8070重定向到登录方法
    public void addViewControllers(ViewControllerRegistry registry) {
        registry.addViewController("/").setViewName("redirect:/LoginServlet/Login");//默认访问页面
        registry.setOrder(Ordered.HIGHEST_PRECEDENCE);//最先执行过滤
        WebMvcConfigurer.super.addViewControllers(registry);
    }
}
