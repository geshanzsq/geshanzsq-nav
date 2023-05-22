package com.geshanzsq.common.framework.mybatis.plugin.interceptor;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.geshanzsq.common.core.util.id.IdWorker;
import com.geshanzsq.common.framework.mybatis.plugin.constant.FieldConstant;
import org.apache.ibatis.binding.MapperMethod;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.SqlCommandType;
import org.apache.ibatis.plugin.Invocation;

import java.lang.reflect.Field;
import java.util.Date;
import java.util.Map;

/**
 * MyBatis 拦截器
 *
 * @author geshanzsq
 * @date 2022/8/7
 */
public class InsertUpdateMyBatisInterceptor {

    /**
     * 调用拦截
     *
     * @param invocation    调用器
     * @param currentUserId 当前用户 id
     */
    public static Object intercept(Invocation invocation, Long currentUserId) throws Throwable {
        MappedStatement statement = (MappedStatement) invocation.getArgs()[0];
        // 获取执行的 SQL 语句类型
        SqlCommandType sqlCommandType = statement.getSqlCommandType();
        // 拦截插入和更新操作，如果不是，则跳过
        if (!SqlCommandType.INSERT.equals(sqlCommandType) && !SqlCommandType.UPDATE.equals(sqlCommandType)) {
            return invocation.proceed();
        }

        // 获取对应的参数类
        Object parameter = invocation.getArgs()[1];
        if (parameter == null) {
            return invocation.proceed();
        }

        // 获取实体对象，如果属于 ParamMap （单个操作），则从参数 param1 获取，否则为 parameter (批量操作)
        Object clazz = null;
        if (parameter instanceof MapperMethod.ParamMap) {
            // 单个操作
            String paramKey = "param1";
            String paramEtKey = "et";
            if (((Map) parameter).containsKey(paramKey)) {
                clazz = ((Map) parameter).get(paramKey);
            } else if (((Map) parameter).containsKey(paramEtKey)) {
                clazz = ((Map) parameter).get(paramEtKey);
            }
        } else {
            // 批量操作
            clazz = parameter;
        }
        setParameter(sqlCommandType, clazz, currentUserId);

        return invocation.proceed();
    }

    /**
     * 设置参数
     *
     * @param sqlCommandType SQL 语句类型
     * @param clazz          参数对象
     * @param operateUserId  操作人用户 id
     */
    private static void setParameter(SqlCommandType sqlCommandType, Object clazz, Long operateUserId) {
        if (SqlCommandType.INSERT.equals(sqlCommandType)) {
            // 插入
            // 设置主键
            setParameterIdValue(clazz);
            // 创建时间
            setParameterValue(clazz, FieldConstant.GMT_CREATE, new Date());
            // 创建人用户 id
            setParameterValue(clazz, FieldConstant.CREATE_USER_ID, operateUserId);
        } else if (SqlCommandType.UPDATE.equals(sqlCommandType)) {
            // 修改
            // 修改时间
            setParameterValue(clazz, FieldConstant.GMT_MODIFY, new Date());
            // 修改人用户 id
            setParameterValue(clazz, FieldConstant.MODIFY_USER_ID, operateUserId);
        }
    }

    /**
     * 设置主键值
     *
     * @param clazz 参数对象类
     */
    private static void setParameterIdValue(Object clazz) {
        Field field = null;
        try {
            field = clazz.getClass().getDeclaredField(FieldConstant.ID);
        } catch (NoSuchFieldException e) {
            return;
        }
        // 设置允许访问
        field.setAccessible(true);
        try {
            Object value = field.get(clazz);
            // 如果值不为空，则不设置
            if (value != null) {
                return;
            }
            // 值为空，判断是否为自增长
            TableId tableId = field.getAnnotation(TableId.class);
            if (tableId != null && tableId.type() != null && IdType.AUTO.getKey() == tableId.type().getKey()) {
                return;
            }
            field.set(clazz, IdWorker.nextId());
        } catch (IllegalAccessException e) {
            return;
        }
    }

    /**
     * 设置参数值
     *
     * @param clazz     参数对象类
     * @param fieldName 属性名称
     * @param value     属性值
     */
    private static void setParameterValue(Object clazz, String fieldName, Object value) {
        Field field = null;
        try {
            field = clazz.getClass().getDeclaredField(fieldName);
        } catch (NoSuchFieldException e) {
            return;
        }
        // 设置允许访问
        field.setAccessible(true);
        try {
            field.set(clazz, value);
        } catch (IllegalAccessException e) {
            return;
        }
    }
}
