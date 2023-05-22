package com.geshanzsq.common.log.aspect;

import com.alibaba.fastjson.JSON;
import com.geshanzsq.common.core.util.ip.IpUtils;
import com.geshanzsq.common.core.util.servlet.ServletUtils;
import com.geshanzsq.common.framework.manager.AsyncManager;
import com.geshanzsq.common.log.annotation.Log;
import com.geshanzsq.common.log.dto.LogDTO;
import com.geshanzsq.common.log.enums.LogStatus;
import com.geshanzsq.common.log.factory.LogAsyncFactory;
import com.geshanzsq.framework.security.util.SecurityUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.AfterReturning;
import org.aspectj.lang.annotation.AfterThrowing;
import org.aspectj.lang.annotation.Aspect;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpMethod;
import org.springframework.stereotype.Component;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.HandlerMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.Collection;
import java.util.Date;
import java.util.Map;

/**
 * 日志切面
 *
 * @author geshanzsq
 * @date 2022/7/4
 */
@Aspect
@Component
public class LogAspect {

    private final Logger log = LoggerFactory.getLogger(LogAspect.class);

    /**
     * 请求完成后处理
     *
     * @param joinPoint     切点
     * @param logAnnotation 日志
     * @param returnResult  返回结果
     */
    @AfterReturning(pointcut = "@annotation(logAnnotation)", returning = "returnResult")
    public void afterReturning(JoinPoint joinPoint, Log logAnnotation, Object returnResult) {
        dealLog(joinPoint, logAnnotation, null, returnResult);
    }

    /**
     * 异常之后执行
     *
     * @param joinPoint     切点
     * @param logAnnotation 日志
     * @param exception     异常
     */
    @AfterThrowing(pointcut = "@annotation(logAnnotation)", throwing = "exception")
    public void afterThrowing(JoinPoint joinPoint, Log logAnnotation, Exception exception) {
        dealLog(joinPoint, logAnnotation, exception, null);
    }

    /**
     * 处理日志
     *
     * @param joinPoint     切点
     * @param logAnnotation 日志
     * @param exception     异常
     * @param returnResult  返回结果
     */
    private void dealLog(JoinPoint joinPoint, Log logAnnotation, Exception exception, Object returnResult) {
        try {
            LogDTO logDTO = new LogDTO();
            // 操作时间
            logDTO.setGmtOperate(new Date());

            try {
                // 当前用户
                logDTO.setUserId(SecurityUtils.getUserId());
            } catch (Exception e) {
            }

            HttpServletRequest request = ServletUtils.getRequest();

            // ip 地址
            String ip = IpUtils.getIpAddr(request);
            logDTO.setIpAddress(ip);
            logDTO.setRequestUrl(request.getRequestURI());

            // 状态
            if (exception != null) {
                logDTO.setStatus(LogStatus.ERROR.code);
                logDTO.setErrorMessage(exception.getMessage());
            } else {
                logDTO.setStatus(LogStatus.SUCCESS.code);
            }

            // 设置方法名称
            String className = joinPoint.getTarget().getClass().getName();
            String methodName = joinPoint.getSignature().getName();
            logDTO.setClassMethod(className + "." + methodName + "()");

            // 设置请求方式
            logDTO.setRequestMethod(ServletUtils.getRequest().getMethod());

            // 处理设置注解上的参数
            dealAnnotationParam(joinPoint, logAnnotation, logDTO, returnResult);

            // 异步推送到消息中心
            AsyncManager.me().execute(LogAsyncFactory.addLog(logDTO));
        } catch (Exception e) {
            log.error("操作日志记录前置通知异常，异常信息：{}", e.getMessage());
            e.printStackTrace();
        }


    }

    /**
     * 处理注解参数
     *
     * @param joinPoint     切点
     * @param logAnnotation 日志
     * @param logDTO        日志记录
     * @param returnResult  返回结果
     */
    private void dealAnnotationParam(JoinPoint joinPoint, Log logAnnotation, LogDTO logDTO, Object returnResult) {
        // 设置业务类型
        logDTO.setBusinessType(logAnnotation.businessType().code);
        // 设置模块名称
        logDTO.setModuleName(logAnnotation.moduleName());
        // 设置操作类型
        logDTO.setOperateType(logAnnotation.operateType().code);
        // 是否需要保存请求数据
        if (logAnnotation.isSaveRequestData()) {
            // 设置请求参数数据
            setRequestData(joinPoint, logDTO);
        }
        // 是否需要保存响应数据，参数和值
        if (logAnnotation.isSaveResponseData() && returnResult != null) {
            logDTO.setReturnResult(JSON.toJSONString(returnResult));
        }
    }

    /**
     * 设置请求参数数据
     */
    private void setRequestData(JoinPoint joinPoint, LogDTO logDTO) {
        String requestMethod = logDTO.getRequestMethod();
        if (HttpMethod.PUT.name().equals(requestMethod) || HttpMethod.POST.name().equals(requestMethod)) {
            String params = argsArrayToString(joinPoint.getArgs());
            logDTO.setRequestParam(params);
        } else {
            Map<?, ?> paramsMap = (Map<?, ?>) ServletUtils.getRequest().getAttribute(HandlerMapping.URI_TEMPLATE_VARIABLES_ATTRIBUTE);
            logDTO.setRequestParam(paramsMap.toString());
        }
    }

    /**
     * 数组参数转为字符串
     */
    private String argsArrayToString(Object[] paramsArray) {
        if (paramsArray == null) {
            return "";
        }
        StringBuilder params = new StringBuilder();
        for (Object param : paramsArray) {
            if (param != null && !isFilterObject(param)) {
                try {
                    Object jsonObj = JSON.toJSON(param);
                    params.append(jsonObj.toString());
                } catch (Exception e) {
                }
            }
        }
        return params.toString().trim();
    }


    /**
     * 判断是否需要过滤的对象。
     *
     * @param object 对象信息。
     * @return 如果是需要过滤的对象，则返回true；否则返回false。
     */
    @SuppressWarnings("rawtypes")
    public boolean isFilterObject(final Object object) {
        Class<?> clazz = object.getClass();
        if (clazz.isArray()) {
            return clazz.getComponentType().isAssignableFrom(MultipartFile.class);
        } else if (Collection.class.isAssignableFrom(clazz)) {
            Collection collection = (Collection) object;
            for (Object value : collection) {
                return value instanceof MultipartFile;
            }
        } else if (Map.class.isAssignableFrom(clazz)) {
            Map map = (Map) object;
            for (Object value : map.entrySet()) {
                Map.Entry entry = (Map.Entry) value;
                return entry.getValue() instanceof MultipartFile;
            }
        }
        return object instanceof MultipartFile || object instanceof HttpServletRequest || object instanceof HttpServletResponse
                || object instanceof BindingResult;
    }

}
