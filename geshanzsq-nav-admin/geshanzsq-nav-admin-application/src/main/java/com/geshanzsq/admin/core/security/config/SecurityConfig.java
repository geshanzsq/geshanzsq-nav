package com.geshanzsq.admin.core.security.config;

import com.geshanzsq.admin.core.security.auth.filter.TokenAuthenticationFilter;
import com.geshanzsq.common.framework.file.property.FileUploadProperty;
import com.geshanzsq.framework.security.handler.AuthenticationEntryPointImpl;
import com.geshanzsq.framework.security.handler.LogoutSuccessHandlerImpl;
import com.geshanzsq.framework.security.property.SecurityProperty;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

/**
 * Spring Security 配置
 *
 * @author geshanzsq
 * @date 2022/3/19
 */
@Configuration
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    /**
     * 自定义登录认证
     */
    @Autowired
    private UserDetailsService userDetailsService;

    /**
     * 认证失败处理
     */
    @Autowired
    private AuthenticationEntryPointImpl authenticationEntryPoint;

    /**
     * 自定义退出
     */
    @Autowired
    private LogoutSuccessHandlerImpl logoutSuccessHandler;

    /**
     * 令牌认证
     */
    @Autowired
    private TokenAuthenticationFilter tokenAuthenticationFilter;

    /**
     * 安全配置
     */
    @Autowired
    private SecurityProperty securityProperty;

    @Autowired
    private FileUploadProperty fileUploadProperty;


    /**
     * httpSecurity 配置
     *
     */
    @Override
    protected void configure(HttpSecurity httpSecurity) throws Exception {
        httpSecurity
                // CSRF禁用，因为不使用session
                .csrf().disable()
                // 认证失败处理
                .exceptionHandling().authenticationEntryPoint(authenticationEntryPoint)
                .and()
                // 基于 token，不需要 session
                .sessionManagement().sessionCreationPolicy(SessionCreationPolicy.STATELESS)
                .and()
                // 过滤请求
                .authorizeRequests()
                // 不用登录就能访问
                .antMatchers(securityProperty.getNotLoginUrls()).permitAll()
                .antMatchers(
                        HttpMethod.GET,
                        "/*.html",
                        "/**/*.html",
                        "/**/*.css",
                        "/**/*.js"
                ).permitAll()
                .antMatchers("/swagger-ui.html").permitAll()
                .antMatchers("/swagger-resources/**").permitAll()
                .antMatchers("/webjars/**").permitAll()
                .antMatchers("/*/api-docs").permitAll()
                .antMatchers("/doc.html").permitAll()
                // 文件预览
                .antMatchers(fileUploadProperty.getMapPrefix() + "/**").permitAll()
                // 除了上面，都需要认证
                .anyRequest().authenticated()
                .and()
                // 禁止 iframe 调用
                .headers().frameOptions().disable();
        // 自定义退出处理
        httpSecurity.logout().logoutUrl("/logout").logoutSuccessHandler(logoutSuccessHandler);
        // 令牌认证
        httpSecurity.addFilterBefore(tokenAuthenticationFilter, UsernamePasswordAuthenticationFilter.class);
    }

    /**
     * 身份认证
     * @param auth
     * @throws Exception
     */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(userDetailsService).passwordEncoder(bCryptPasswordEncoder());
    }

    /**
     * 解决无法直接注入 AuthenticationManager
     */
    @Bean
    @Override
    public AuthenticationManager authenticationManagerBean() throws Exception {
        return super.authenticationManagerBean();
    }

    /**
     * 哈希加密实现
     */
    @Bean
    public BCryptPasswordEncoder bCryptPasswordEncoder() {
        return new BCryptPasswordEncoder();
    }

}
