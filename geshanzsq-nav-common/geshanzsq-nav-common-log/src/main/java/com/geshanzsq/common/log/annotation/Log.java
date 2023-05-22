package com.geshanzsq.common.log.annotation;

import com.geshanzsq.common.log.enums.BusinessType;
import com.geshanzsq.common.log.enums.OperateType;

import java.lang.annotation.*;

/**
 * 自定义日志注解
 *
 * @author geshanzsq
 * @date 2022/7/4
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Log {

    /**
     * 模块名称
     */
    String moduleName() default "";

    /**
     * 业务类型
     */
    BusinessType businessType() default BusinessType.OTHER;

    /**
     * 操作类型
     */
    OperateType operateType() default OperateType.ADMIN;

    /**
     * 是否保存请求数据
     */
    boolean isSaveRequestData() default true;

    /**
     * 是否保存响应数据
     */
    boolean isSaveResponseData() default true;

}
