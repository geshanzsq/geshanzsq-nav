package com.geshanzsq.nav.service.impl;

import com.geshanzsq.common.config.GeshanzsqNavConfig;
import com.geshanzsq.common.utils.DateUtils;
import com.geshanzsq.common.utils.file.FileUploadUtils;
import com.geshanzsq.nav.domain.NavPicture;
import com.geshanzsq.nav.mapper.NavPictureMapper;
import com.geshanzsq.nav.service.INavPictureService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.List;

/**
 * 导航图片Service业务层处理
 * 
 * @author geshanzsq
 * @date 2020-09-12
 */
@Service
public class NavPictureServiceImpl implements INavPictureService
{
    @Autowired
    private NavPictureMapper navPictureMapper;

    /**
     * 查询导航图片
     * 
     * @param pictureId 导航图片ID
     * @return 导航图片
     */
    @Override
    public NavPicture selectNavPictureById(Long pictureId)
    {
        return navPictureMapper.selectNavPictureById(pictureId);
    }

    /**
     * 查询导航图片列表
     * 
     * @param navPicture 导航图片
     * @return 导航图片
     */
    @Override
    public List<NavPicture> selectNavPictureList(NavPicture navPicture)
    {
        return navPictureMapper.selectNavPictureList(navPicture);
    }

    /**
     * 新增导航图片
     * 
     * @param navPicture 导航图片
     * @return 结果
     */
    @Override
    public int insertNavPicture(NavPicture navPicture)
    {
        navPicture.setCreateTime(DateUtils.getNowDate());
        return navPictureMapper.insertNavPicture(navPicture);
    }

    /**
     * 修改导航图片
     * 
     * @param navPicture 导航图片
     * @return 结果
     */
    @Override
    public int updateNavPicture(NavPicture navPicture)
    {
        navPicture.setUpdateTime(DateUtils.getNowDate());
        return navPictureMapper.updateNavPicture(navPicture);
    }

    /**
     * 批量删除导航图片
     * 
     * @param pictureIds 需要删除的导航图片ID
     * @return 结果
     */
    @Override
    public int deleteNavPictureByIds(Long[] pictureIds)
    {
        return navPictureMapper.deleteNavPictureByIds(pictureIds);
    }

    /**
     * 删除导航图片信息
     * 
     * @param pictureId 导航图片ID
     * @return 结果
     */
    @Override
    public int deleteNavPictureById(Long pictureId)
    {
        return navPictureMapper.deleteNavPictureById(pictureId);
    }

    /**
     * 通过md5获取图片
     */
    @Override
    public NavPicture selectPictureByPictureMd5(String pictureMd5) {
        if (StringUtils.isBlank(pictureMd5)) {
            return null;
        }
        NavPicture navPicture = new NavPicture();
        navPicture.setPictureMd5(pictureMd5);
        List<NavPicture> navPictureList = navPictureMapper.selectNavPictureList(navPicture);
        return navPictureList.size() == 0 ? null : navPictureList.get(0);
    }

    /**
     * 获取网站上传路径
     */
    @Override
    public String getUploadFileName(String username,String modulePath, MultipartFile file) throws IOException {
        // 上传文件路径
        String filePath = GeshanzsqNavConfig.getUploadSitePath();
        // 上传并返回新文件名称
        String fileName = "";
        // 获取文件的md5
        String fileMd5 = FileUploadUtils.getFileMd5(file);
        NavPicture navPicture = selectPictureByPictureMd5(fileMd5);

        if (navPicture == null) {
            // 不存在，上传
            fileName = FileUploadUtils.uploadSite(filePath, modulePath, file);
            navPicture = new NavPicture();
            navPicture.setPicturePath(fileName);
            navPicture.setCreateBy(username);
            navPicture.setPictureOld(file.getOriginalFilename());
            navPicture.setPictureMd5(fileMd5);
            insertNavPicture(navPicture);
        } else {
            // 存在，直接获取已经上传
            fileName = navPicture.getPicturePath();
        }
        return fileName;
    }
}
