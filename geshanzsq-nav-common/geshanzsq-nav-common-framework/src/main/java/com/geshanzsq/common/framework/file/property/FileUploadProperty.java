package com.geshanzsq.common.framework.file.property;

import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.autoconfigure.web.servlet.MultipartProperties;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

/**
 * 文件上传配置
 *
 * @author geshanzsq
 * @date 2022/8/25
 */
@Data
@Configuration
@ConfigurationProperties(prefix = "file-upload")
public class FileUploadProperty {

    @Autowired
    private MultipartProperties multipartProperties;

    /**
     * 文件名称最大长度
     */
    private Long nameMaxLength = 200L;

    /**
     * 文件最大限制
     */
    private Long maxSize;

    /**
     * 上传基本路径
     */
    private String basePath;

    /**
     * 文件映射前缀
     */
    private String mapPrefix;

    /**
     * 文件域名地址
     */
    private String domain;

    /**
     * 图片上传基本路径
     */
    public String getFileImageBasePath() {
        return basePath + "/image";
    }

    public Long getFileMaxSize() {
        return multipartProperties.getMaxFileSize().toBytes();
    }
}
