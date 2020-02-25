package com.huatusoft.electronictag.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/6 16:40
 */
@Target(ElementType.METHOD) // 方法注解
@Retention(RetentionPolicy.RUNTIME) // 运行时可见
public @interface ManagerLog {
    /**
     * 记录日志的操作模块
     */
    String operateModel();

    /**
     * 记录日志的操作描述
     */
    String description();
}
