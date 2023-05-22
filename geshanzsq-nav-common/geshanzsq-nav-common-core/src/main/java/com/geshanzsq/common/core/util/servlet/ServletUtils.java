package com.geshanzsq.common.core.util.servlet;

import com.alibaba.fastjson.JSON;
import com.geshanzsq.common.core.constant.HttpStatus;
import com.geshanzsq.common.core.web.response.ResponseResult;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 客户端工具类
 *
 * @author geshanzsq
 * @date 2022/3/19
 */
public class ServletUtils {

    /**
     * 渲染到客户端
     * @param responseResult
     * @param response
     */
    public static void renderString(ResponseResult responseResult, HttpServletResponse response) {
        renderString(JSON.toJSONString(responseResult), response);
    }

    /**
     * 渲染字符到客户端
     * @param str
     * @param response
     */
    public static void renderString(String str, HttpServletResponse response) {
        response.setStatus(HttpStatus.SUCCESS);
        response.setContentType("application/json");
        response.setCharacterEncoding("utf-8");
        try {
            response.getWriter().println(str);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    /**
     * 获取请求
     */
    public static HttpServletRequest getRequest() {
        return getRequestAttributes().getRequest();
    }

    /**
     * 请求属性
     */
    public static ServletRequestAttributes getRequestAttributes() {
        RequestAttributes requestAttributes = RequestContextHolder.getRequestAttributes();
        return (ServletRequestAttributes) requestAttributes;
    }

}
