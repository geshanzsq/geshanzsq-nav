package com.geshanzsq.admin.core.bing.controller;

import com.geshanzsq.admin.core.bing.util.BingUtils;
import com.geshanzsq.admin.core.bing.vo.BingImageVO;
import com.geshanzsq.common.core.web.response.ResponseResult;
import com.geshanzsq.common.framework.web.controller.BaseController;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * 微软 Bing 图片下载
 *
 * @author geshanzsq
 * @date 2022/5/14
 */
@RestController
@RequestMapping("/bing")
@Api(tags = "微软 Bing")
public class BingController extends BaseController {


    @ApiOperation("获取 Bing 壁纸")
    @GetMapping("/getBingImage")
    public ResponseResult<BingImageVO> getBingImage() {
        String bingOneImage = BingUtils.getBingOneImage();
        BingImageVO bingImageVO = new BingImageVO(bingOneImage);
        return ResponseResult.success(bingImageVO);
    }

}
