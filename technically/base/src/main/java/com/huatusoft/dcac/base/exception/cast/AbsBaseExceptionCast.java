package com.huatusoft.dcac.base.exception.cast;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/11 17:24
 */
public abstract class AbsBaseExceptionCast implements BaseExceptionCast{
    @Override
    public void castRumTimeException(String message) {
        throw new RuntimeException(message);
    }
}
