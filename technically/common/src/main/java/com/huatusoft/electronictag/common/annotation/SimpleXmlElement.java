/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.electronictag.common.annotation;

import java.lang.annotation.ElementType;
import java.lang.annotation.Retention;
import java.lang.annotation.RetentionPolicy;
import java.lang.annotation.Target;

@Target({ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
public @interface SimpleXmlElement {
    String value() default "";
}
