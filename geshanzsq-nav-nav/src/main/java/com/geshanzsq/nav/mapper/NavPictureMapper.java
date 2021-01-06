package com.geshanzsq.nav.mapper;

import com.geshanzsq.nav.domain.NavPicture;
import java.util.List;

/**
 * 导航图片Mapper接口
 * 
 * @author geshanzsq
 * @date 2020-09-12
 */
public interface NavPictureMapper 
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
     * 删除导航图片
     * 
     * @param pictureId 导航图片ID
     * @return 结果
     */
    public int deleteNavPictureById(Long pictureId);

    /**
     * 批量删除导航图片
     * 
     * @param pictureIds 需要删除的数据ID
     * @return 结果
     */
    public int deleteNavPictureByIds(Long[] pictureIds);

}
