/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.common.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.lang.reflect.Method;

public class ReflectUtils{

    private static final Logger LOGGER = LoggerFactory.getLogger(ReflectUtils.class);

    public static void setter(Object obj, String toSet, Object value, Class<?> paraTypes) {
        try {
            Method target = obj.getClass().getMethod("set" + upperFirst(toSet), paraTypes);
            target.invoke(obj, value);
        } catch (Exception e) {
            LOGGER.error(e.toString());
        }
    }

    public static Object getter(Object obj, String toGet) {
        Object result = null;
        try {
            Method target = obj.getClass().getMethod("get" + upperFirst(toGet));
            result = target.invoke(obj);
        } catch (Exception e) {
            LOGGER.error(e.toString());
        }
        return result;
    }

    public static String upperFirst(String toUpper) {
        return toUpper.substring(0, 1).toUpperCase() + toUpper.substring(1);
    }
}

