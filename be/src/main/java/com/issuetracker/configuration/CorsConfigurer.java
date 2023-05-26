package com.issuetracker.configuration;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.CorsRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class CorsConfigurer implements WebMvcConfigurer {
    @Override
    public void addCorsMappings(CorsRegistry registry) {
        registry.addMapping("/")
                .allowedOrigins("http://13.209.93.177/", "http://localhost:3000")//TODO : 테스트용으로 모든 도메인 임시 허용
                .allowedMethods("*")
                .allowedHeaders("*");
    }
}
