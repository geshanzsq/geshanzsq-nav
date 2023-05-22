package com.geshanzsq.common.swagger.config;

import com.geshanzsq.common.swagger.property.SwaggerProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import springfox.documentation.builders.ApiInfoBuilder;
import springfox.documentation.builders.RequestHandlerSelectors;
import springfox.documentation.service.ApiInfo;
import springfox.documentation.service.Contact;
import springfox.documentation.spi.DocumentationType;
import springfox.documentation.spring.web.plugins.Docket;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

/**
 * Knife4j 接口文档配置
 *
 * @author geshanzsq
 * @date 2022/3/16
 */
@Configuration
@EnableSwagger2
public class SwaggerConfig {

    @Autowired
    private SwaggerProperty swaggerProperty;

    @Bean("defaultApi2")
    public Docket defaultApi2() {
        Docket docket = new Docket(DocumentationType.SWAGGER_2)
                // 是否启用
                .enable(swaggerProperty.isEnable())
                // API 基本信息，展示在文档的页面
                .apiInfo(apiInfo())
                // 设置哪些接口暴露给Swagger展示
                .select()
                //扫描所有有注解的api，用这种方式更灵活
                .apis(RequestHandlerSelectors.withMethodAnnotation(ApiOperation.class))
                .build();

        return docket;
    }

    /**
     * 基本信息
     */
    private ApiInfo apiInfo() {
        // 构建基本信息
        return new ApiInfoBuilder()
                // 标题
                .title(swaggerProperty.getTitle())
                // 描述
                .description(swaggerProperty.getDescription())
                // 作者信息
                .contact(new Contact(swaggerProperty.getAuthor(), swaggerProperty.getUrl(), swaggerProperty.getEmail()))
                // 版本
                .version(swaggerProperty.getVersion())
                .build();
    }

}
