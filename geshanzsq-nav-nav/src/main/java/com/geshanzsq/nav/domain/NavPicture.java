package com.geshanzsq.nav.domain;

import com.geshanzsq.common.annotation.Excel;
import com.geshanzsq.common.core.domain.BaseEntity;
import lombok.Data;

import java.io.Serializable;

/**
 * 导航图片对象 nav_picture
 * 
 * @author geshanzsq
 * @date 2020-09-12
 */
@Data
public class NavPicture extends BaseEntity implements Serializable {
    private static final long serialVersionUID = 1L;

    /** 主键 */
    private Long pictureId;

    /** 图片路径 */
    @Excel(name = "图片路径")
    private String picturePath;

    /** 原图片名称 */
    @Excel(name = "原图片名称")
    private String pictureOld;

    private String pictureMd5;

    /** 状态，0 保存，1 停用 */
    @Excel(name = "状态，0 保存，1 停用")
    private Integer status;

    public NavPicture() {
    }
}
