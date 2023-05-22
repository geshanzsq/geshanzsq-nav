package com.geshanzsq.common.framework.config;

import com.geshanzsq.common.framework.file.property.FileUploadProperty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

/**
 * 资源配置
 *
 * @author geshanzsq
 * @date 2022/9/3
 */
@Configuration
public class ResourceConfig implements WebMvcConfigurer {

    @Autowired
    private FileUploadProperty fileUploadProperty;

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 资源文件映射，可通过当前项目就能访问
        registry.addResourceHandler(fileUploadProperty.getMapPrefix() + "/**")
                .addResourceLocations("file:" + fileUploadProperty.getBasePath() + "/");
    }
}
