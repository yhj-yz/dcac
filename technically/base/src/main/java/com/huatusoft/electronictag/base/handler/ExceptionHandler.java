package com.huatusoft.electronictag.base.handler;

import com.huatusoft.electronictag.base.exception.CustomException;

import java.io.IOException;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 13:35
 */
public interface ExceptionHandler {

    /**
     * 处理异常方法
     * @param e
     */
    String handlingException(CustomException e) throws IOException;


}
