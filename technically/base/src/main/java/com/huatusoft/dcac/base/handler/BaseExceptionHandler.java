package com.huatusoft.dcac.base.handler;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.common.bo.CommonAttributes;
import com.huatusoft.dcac.base.exception.CustomException;
import com.huatusoft.dcac.base.response.message.ResultMessage;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 13:43
 */
public class BaseExceptionHandler extends BaseController {

    protected Object data;

    protected ResultMessage resultMessage;

    /**
     * 获取异常发生时传递的数据
     * @param e
     */
    protected Object getData(CustomException e) {
        String[] messageAndData = e.getMessage().split(CommonAttributes.DATA_SEPARATOR);
        if(messageAndData.length > 1) {
            data = messageAndData[1];
        }
        return data;
    }

    protected <E extends Enum> ResultMessage getResultMessage(CustomException e, Class<E> resultMessageClass) {
        String[] messageAndData = e.getMessage().split(CommonAttributes.DATA_SEPARATOR);
        if(messageAndData.length >= 1) {
            resultMessage = (ResultMessage) Enum.valueOf(resultMessageClass, messageAndData[0]);
        }
        return resultMessage;
    }
}
