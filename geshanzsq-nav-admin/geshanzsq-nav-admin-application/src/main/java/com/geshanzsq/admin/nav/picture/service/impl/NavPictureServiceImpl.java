package com.geshanzsq.admin.nav.picture.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.geshanzsq.admin.nav.picture.mapper.NavPictureMapper;
import com.geshanzsq.admin.nav.picture.po.NavPicture;
import com.geshanzsq.admin.nav.picture.service.NavPictureService;
import com.geshanzsq.common.framework.file.service.FileService;
import com.geshanzsq.common.framework.file.util.FileUploadUtils;
import com.geshanzsq.common.framework.web.service.impl.BaseServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

/**
 * 导航图片
 *
 * @author geshanzsq
 * @date 2022/11/26
 */
@Service
public class NavPictureServiceImpl extends BaseServiceImpl<NavPictureMapper, NavPicture> implements NavPictureService {

    @Autowired
    private NavPictureMapper navPictureMapper;

    @Autowired
    private FileService fileService;


    /**
     * 获取图片上传路径
     *
     * @param modulePath 模块路径
     * @param file 文件
     * @return
     * @throws IOException
     */
    @Override
    public NavPicture getUploadFilePath(String modulePath, MultipartFile file) {
        // 获取文件的 md5
        String fileMd5 = FileUploadUtils.getFileMd5(file);
        // 判断数据库是否存在此文件，如果存在，则直接返回，否则上传文件
        LambdaQueryWrapper<NavPicture> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(NavPicture::getPictureMd5, fileMd5);
        wrapper.select(NavPicture::getPicturePath);
        List<NavPicture> pictureList = navPictureMapper.selectList(wrapper);
        if (!CollectionUtils.isEmpty(pictureList)) {
            return pictureList.get(0);
        }

        // 上传文件
        String filePath = fileService.uploadPicture(modulePath, file);

        // 图片信息插入数据库
        NavPicture navPicture = new NavPicture();
        navPicture.setPictureOriginalName(file.getOriginalFilename());
        navPicture.setPicturePath(filePath);
        navPicture.setPictureMd5(fileMd5);
        navPictureMapper.insert(navPicture);

        return navPicture;
    }
}
