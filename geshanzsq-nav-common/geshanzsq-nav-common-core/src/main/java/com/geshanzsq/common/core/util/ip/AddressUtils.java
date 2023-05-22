package com.geshanzsq.common.core.util.ip;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.geshanzsq.common.core.util.http.HttpUtils;
import com.geshanzsq.common.core.util.string.StrUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

/**
 * 地址工具类
 *
 * @author geshanzsq
 * @date 2022/7/3
 */
public class AddressUtils {

    private static final Logger log = LoggerFactory.getLogger(AddressUtils.class);

    /**
     * IP 地址查询
     */
    public static final String IP_URL = "http://whois.pconline.com.cn/ipJson.jsp";

    /**
     * 未知地址
     */
    public static final String UNKNOWN = "XX XX";

    public static String getRealAddressByIP(String ip) {
        if (StrUtils.isBlank(ip)) {
            return "";
        }
        // 内网不查询
        if (IpUtils.internalIp(ip)) {
            return "内网IP";
        }
        try {
            String responseStr = HttpUtils.sendGet(IP_URL, "ip=" + ip.split(",")[0] + "&json=true", "GBK");
            if (StrUtils.isBlank(responseStr)) {
                log.error("获取地理位置异常 {}", ip);
                return UNKNOWN;
            }
            JSONObject obj = JSON.parseObject(responseStr);
            String region = obj.getString("pro");
            String city = obj.getString("city");
            return String.format("%s %s", region, city);
        } catch (Exception e) {
            log.error("获取地理位置异常 {}", ip);
        }

        return UNKNOWN;
    }
}
