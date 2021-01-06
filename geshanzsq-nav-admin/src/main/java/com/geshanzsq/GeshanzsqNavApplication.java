package com.geshanzsq;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;

/**
 * 启动程序
 * 
 * @author geshanzsq
 */
@SpringBootApplication(exclude = { DataSourceAutoConfiguration.class })
public class GeshanzsqNavApplication
{
    public static void main(String[] args)
    {
        SpringApplication.run(GeshanzsqNavApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  格姗知识圈导航系统启动成功   ლ(´ڡ`ლ)ﾞ  ");
    }
}
