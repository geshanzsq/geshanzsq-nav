package com.geshanzsq.common.swagger.property;

import lombok.Data;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * Knife4j 相关属性配置
 *
 * @author geshanzsq
 * @date 2022/3/17
 */
@Configuration
@ConfigurationProperties(prefix = "swagger")
@Data
public class SwaggerProperty {

    /**
     * 标题
     */
    private String title;

    /**
     * 描述
     */
    private String description;

    /**
     * 作者
     */
    private String author;

    /**
     * 地址
     */
    private String url;

    /**
     * 邮箱
     */
    private String email;

    /**
     * 版本号
     */
    private String version;

    /**
     * 是否启用
     */
    private boolean enable;

}
