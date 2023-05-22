package com.geshanzsq.common.core.util.id;

import java.util.UUID;

/**
 * ID 生成器工具
 *
 * @author geshanzsq
 * @date 2022/5/2
 */
public class IdUtils {

    /**
     * 简化的UUID，去掉了横线
     */
    public static String simpleUUID() {
        return UUID.randomUUID().toString().replaceAll("-", "");
    }

}
