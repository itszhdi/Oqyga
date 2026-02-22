package com.oqyga.OqygaBackend.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Path;
import java.nio.file.Paths;

@Configuration
public class MvcConfig implements WebMvcConfigurer {

    @Value("${file.upload-dir}")
    private String uploadDir;

    @Value("${file.upload-url-path}")
    private String uploadUrlPath;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        Path path = Paths.get(uploadDir).toAbsolutePath().normalize();
        String uploadPath = path.toUri().toString();

        String urlPath = uploadUrlPath;
        if (!urlPath.startsWith("/")) urlPath = "/" + urlPath;
        if (!urlPath.endsWith("/")) urlPath = urlPath + "/";

        registry.addResourceHandler(urlPath + "**")
                .addResourceLocations(uploadPath);
    }
}