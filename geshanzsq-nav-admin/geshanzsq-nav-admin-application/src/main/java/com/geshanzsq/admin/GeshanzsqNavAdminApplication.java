package com.geshanzsq.admin;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * 后台启动类
 *
 * @author geshanzsq
 * @date 2022/3/14
 */
@SpringBootApplication(scanBasePackages = "com.geshanzsq")
@MapperScan("com.geshanzsq.**.mapper")
public class GeshanzsqNavAdminApplication {

    public static void main(String[] args) {
        SpringApplication.run(GeshanzsqNavAdminApplication.class, args);
        System.out.println("(♥◠‿◠)ﾉﾞ  格姗导航启动成功   ლ(´ڡ`ლ)ﾞ ");
    }

}
