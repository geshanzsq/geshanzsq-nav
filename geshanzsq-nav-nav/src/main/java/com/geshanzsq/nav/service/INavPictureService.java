package com.geshanzsq.nav.service;

import com.geshanzsq.nav.domain.NavPicture;
import org.springframework.web.multipart.MultipartFile;
import java.io.IOException;
import java.util.List;

/**
 * 导航图片Service接口
 * 
 * @author geshanzsq
 * @date 2020-09-12
 */
public interface INavPictureService 
{
    /**
     * 查询导航图片
     * 
     * @param pictureId 导航图片ID
     * @return 导航图片
     */
    public NavPicture selectNavPictureById(Long pictureId);

    /**
     * 查询导航图片列表
     * 
     * @param navPicture 导航图片
     * @return 导航图片集合
     */
    public List<NavPicture> selectNavPictureList(NavPicture navPicture);

    /**
     * 新增导航图片
     * 
     * @param navPicture 导航图片
     * @return 结果
     */
    public int insertNavPicture(NavPicture navPicture);

    /**
     * 修改导航图片
     * 
     * @param navPicture 导航图片
     * @return 结果
     */
    public int updateNavPicture(NavPicture navPicture);

    /**
     * 批量删除导航图片
     * 
     * @param pictureIds 需要删除的导航图片ID
     * @return 结果
     */
    public int deleteNavPictureByIds(Long[] pictureIds);

    /**
     * 删除导航图片信息
     * 
     * @param pictureId 导航图片ID
     * @return 结果
     */
    public int deleteNavPictureById(Long pictureId);


    /**
     * 通过md5获取图片
     */
    NavPicture selectPictureByPictureMd5(String pictureMd5);

    /**
     * 获取网站上传路径
     */
    String getUploadFileName(String username,String modulePath, MultipartFile file) throws IOException;
}
