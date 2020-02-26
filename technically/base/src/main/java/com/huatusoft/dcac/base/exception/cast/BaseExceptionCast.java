package com.huatusoft.dcac.base.exception.cast;

import com.huatusoft.dcac.base.exception.CustomException;
import com.huatusoft.dcac.base.response.message.ResultMessage;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/11 16:33
 */
public interface BaseExceptionCast {

    /**
     * 将resultMessage转换为自定义异常抛出
     *
     * @param resultMessage 结果数据
     * @throws CustomException
     */
    void castCustomerException(ResultMessage resultMessage) throws CustomException;

    /**
     * 将resultMessage转换为自定义异常抛出
     *
     * @param resultMessage 结果数据
     * @param data          需要传递的信息
     * @throws CustomException
     */
    void castCustomerException(ResultMessage resultMessage, Object data) throws CustomException;

    /**
     * 抛出运行时异常
     *
     * @param message 出现异常的原因
     */
    void castRumTimeException(String message);

}
