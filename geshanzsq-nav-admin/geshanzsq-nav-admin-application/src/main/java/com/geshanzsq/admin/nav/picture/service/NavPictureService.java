package com.geshanzsq.admin.nav.picture.service;

import com.geshanzsq.admin.nav.picture.po.NavPicture;
import com.geshanzsq.common.framework.web.service.BaseService;
import org.springframework.web.multipart.MultipartFile;

/**
 * 导航图片
 *
 * @author geshanzsq
 * @date 2022/11/26
 */
public interface NavPictureService extends BaseService<NavPicture> {

    /**
     * 获取图片上传路径
     *
     * @param modulePath 模块路径
     * @param file 文件
     */
    NavPicture getUploadFilePath(String modulePath, MultipartFile file);

}
