/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.electronictag.common.util;

import com.huatusoft.electronictag.common.exception.DataStoreReadException;

import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.Validator;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public class ValidatorUtils {

    private static Validator validator = Validation.buildDefaultValidatorFactory().getValidator();

    /**
     * 数据验证
     *
     * @param target
     *            验证对象
     * @param prefix
     *            错误消息前缀
     * @param groups
     *            验证组
     * @throws Exception
     */
    public static void isValid(Object target, String prefix, Class<?>... groups) throws Exception {
        Set<ConstraintViolation<Object>> constraintViolations = validator.validate(target, groups);
        if (!constraintViolations.isEmpty()) {
            List<String> msg = new ArrayList<String>();
            Iterator<ConstraintViolation<Object>> iterator = constraintViolations.iterator();
            while (iterator.hasNext()) {
                ConstraintViolation<Object> next = iterator.next();
                msg.add(next.getMessage());
            }
            throw new DataStoreReadException(prefix + msg.toString());
        }
    }
}
