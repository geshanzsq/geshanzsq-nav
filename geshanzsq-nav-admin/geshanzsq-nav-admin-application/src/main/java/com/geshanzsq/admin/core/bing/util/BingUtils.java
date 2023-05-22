package com.geshanzsq.admin.core.bing.util;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.geshanzsq.common.core.util.http.HttpUtils;

/**
 * 微软 Bing 工具类
 *
 * @author geshanzsq
 * @date 2022/5/14
 */
public class BingUtils {

    private static final String BING_URL = "https://cn.bing.com/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=zh-CN";

    /**
     * 获取Bing图片
     * @return
     */
    public static String getBingOneImage() {
        String resultStr = HttpUtils.sendGet(BING_URL,null);
        JSONObject jsonObject = JSON.parseObject(resultStr);
        JSONObject imageObject = jsonObject.getJSONArray("images").getJSONObject(0);
        return "https://cn.bing.com" + imageObject.getString("url");
    }

}
