package com.geshanzsq.common.framework.file.service;

import org.springframework.web.multipart.MultipartFile;

/**
 * 文件
 *
 * @author geshanzsq
 * @date 2022/9/2
 */
public interface FileService {

    /**
     * 文件上传
     * @param file 文件
     * @param allowExtensions 允许上传文件类型
     * @return 文件全路径
     */
    String upload(MultipartFile file, String[] allowExtensions);

    /**
     * 文件上传
     * @param file 文件
     * @return 文件全路径
     */
    String upload(MultipartFile file);

    /**
     * 图片上传
     * @param file 文件
     * @return 文件全路径
     */
    String uploadImage(MultipartFile file);

    /**
     * 图片上传
     *
     * @param moduleName 模块名
     * @param file 文件
     * @return 文件全路径
     */
    String uploadPicture(String moduleName, MultipartFile file);

}
