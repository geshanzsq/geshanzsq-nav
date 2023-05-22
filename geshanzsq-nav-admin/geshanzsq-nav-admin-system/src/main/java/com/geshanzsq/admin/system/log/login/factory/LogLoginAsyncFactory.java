package com.geshanzsq.admin.system.log.login.factory;

import com.geshanzsq.admin.system.log.login.po.LogLogin;
import com.geshanzsq.admin.system.log.login.service.LogLoginService;
import com.geshanzsq.common.core.util.ip.AddressUtils;
import com.geshanzsq.common.core.util.ip.IpUtils;
import com.geshanzsq.common.core.util.servlet.ServletUtils;
import com.geshanzsq.common.core.util.spring.SpringUtils;
import eu.bitwalker.useragentutils.UserAgent;

import java.util.Date;
import java.util.TimerTask;

/**
 * 登录日志异步工厂
 *
 * @author geshanzsq
 * @date 2022/7/4
 */
public class LogLoginAsyncFactory {

    /**
     * 记录日志
     * @param username 用户名
     * @param status 状态
     * @param hintMessage 提示消息
     */
    public static TimerTask add(String username, Integer status, String hintMessage) {
        return add(null, username, status, hintMessage);
    }

    /**
     * 记录日志
     * @param userId 用户 id
     * @param username 用户名
     * @param status 状态
     * @param hintMessage 提示消息
     */
    public static TimerTask add(Long userId, String username, Integer status, String hintMessage) {
        // 获取客户端信息
        UserAgent userAgent = UserAgent.parseUserAgentString(ServletUtils.getRequest().getHeader("User-Agent"));
        String ip = IpUtils.getIpAddr(ServletUtils.getRequest());
        return new TimerTask() {
            @Override
            public void run() {
                String address = AddressUtils.getRealAddressByIP(ip);
                // 获取客户端操作系统
                String operateSystem = userAgent.getOperatingSystem().getName();
                // 获取客户端浏览器
                String browser = userAgent.getBrowser().getName();
                // 封装对象
                LogLogin logLogin = LogLogin.builder()
                        .userId(userId)
                        .username(username)
                        .ipAddress(ip)
                        .loginLocation(address)
                        .operateSystem(operateSystem)
                        .browserType(browser)
                        .hintMessage(hintMessage)
                        .status(status)
                        .gmtLogin(new Date())
                        .build();
                SpringUtils.getBean(LogLoginService.class).save(logLogin);
            }
        };
    }

}
