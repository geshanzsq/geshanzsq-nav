package com.geshanzsq.common.framework.file.service.impl;

import cn.hutool.core.lang.UUID;
import com.geshanzsq.common.core.util.message.MessageUtils;
import com.geshanzsq.common.core.util.string.StrUtils;
import com.geshanzsq.common.framework.file.exception.FileException;
import com.geshanzsq.common.framework.file.property.FileUploadProperty;
import com.geshanzsq.common.framework.file.service.FileService;
import com.geshanzsq.common.framework.file.util.FileUploadUtils;
import com.geshanzsq.common.framework.file.util.MimeTypeUtils;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.time.DateFormatUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.util.Date;

/**
 * 文件
 *
 * @author geshanzsq
 * @date 2022/9/2
 */
@Service
public class FileServiceImpl implements FileService {

    private final static Logger log = LoggerFactory.getLogger(FileServiceImpl.class);

    @Autowired
    private FileUploadProperty fileUploadProperty;

    /**
     * 文件上传
     * @param file 文件
     * @param allowExtensions 允许上传文件类型
     * @return 文件全路径
     */
    @Override
    public String upload(MultipartFile file, String[] allowExtensions) {
        return upload(fileUploadProperty.getBasePath(), file, allowExtensions);
    }

    /**
     * 文件上传
     * @param file 文件
     * @return 文件全路径
     */
    @Override
    public String upload(MultipartFile file) {
        return upload(fileUploadProperty.getBasePath(), file, MimeTypeUtils.DEFAULT_ALLOWED_EXTENSION);
    }

    /**
     * 文件上传
     * @param file 文件
     * @return 文件全路径
     */
    @Override
    public String uploadImage(MultipartFile file) {
        return upload(fileUploadProperty.getFileImageBasePath(), file, MimeTypeUtils.IMAGE_EXTENSION);
    }

    /**
     * 文件上传
     * @param baseDirectory 基本目录
     * @param file 文件
     * @param allowExtensions 允许上传文件类型
     * @return 文件全路径
     */
    private String upload(String baseDirectory, MultipartFile file, String[] allowExtensions) {
        // 1 校验文件名称长度
        int fileNameLength = file.getOriginalFilename().length();
        if (fileNameLength > fileUploadProperty.getNameMaxLength()) {
            String message = StrUtils.format(MessageUtils.message("file.upload.file.name.max.length"),
                    fileUploadProperty.getNameMaxLength());
            throw new FileException(message);
        }

        // 2 校验文件大小
        long fileSize = file.getSize();
        if (fileSize != -1 && fileSize > fileUploadProperty.getFileMaxSize()) {
            throw new FileException(MessageUtils.message("file.upload.file.size.max"));
        }

        // 3 校验文件类型是否符合
        // 获取文件后缀名
        String extension = FileUploadUtils.getExtension(file);
        // 后缀名是否允许
        boolean isAllowedExtension = FileUploadUtils.isAllowedExtension(extension, allowExtensions);
        if (!isAllowedExtension) {
            throw new FileException(MessageUtils.message("file.upload.file.type.not.allow"));
        }

        // 4 文件上传路径
        String filePathName = FileUploadUtils.getUploadFilePath(extension);
        File absoluteFile = null;
        try {
            // 4.1 获取上传的真实文件
             absoluteFile = FileUploadUtils.getAbsoluteFile(baseDirectory, filePathName);
            // 4.2 将内存文件写入磁盘中
            file.transferTo(absoluteFile);
        } catch (IOException e) {
            log.error("文件上传失败：{}", e.getMessage());
            throw new FileException(MessageUtils.message("file.upload.fail"));
        }
        // 4.3 获取文件映射的地址
        String fileMapPath = getFileMapPath(baseDirectory, filePathName);
        return fileMapPath;
    }

    /**
     * 图片上传
     *
     * @param moduleName 模块名
     * @param file 文件
     * @return 文件全路径
     */
    @Override
    public String uploadPicture(String moduleName, MultipartFile file) {
        return upload(fileUploadProperty.getBasePath() + "/" + moduleName, file, MimeTypeUtils.IMAGE_EXTENSION);
    }

    /**
     * 获取文件映射的地址
     * @param baseDirectory 基本路径
     * @param filePathName 文件路径和名称
     * @return
     */
    private String getFileMapPath(String baseDirectory, String filePathName) {
        // 文件完整路径
        String fileFullPath = baseDirectory + filePathName;
        // 去除基本路径
        if (StrUtils.startsWith(fileFullPath, fileUploadProperty.getBasePath())) {
            fileFullPath = fileFullPath.replaceFirst(fileUploadProperty.getBasePath(), "");
        }
        // 文件域名地址不为空，则拼接域名和路径
        if (StrUtils.isNotBlank(fileUploadProperty.getDomain())) {
            return fileUploadProperty.getDomain() + fileFullPath;
        }
        // 拼接项目映射地址
        return fileUploadProperty.getMapPrefix() + fileFullPath;
    }

}
