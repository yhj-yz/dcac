package com.huatusoft.electronictag.systemsetting.exception.cast;

import com.huatusoft.electronictag.base.exception.CustomException;
import com.huatusoft.electronictag.base.exception.cast.AbsBaseExceptionCast;
import com.huatusoft.electronictag.base.response.message.ResultMessage;
import com.huatusoft.electronictag.systemsetting.exception.SystemSettingException;
import com.huatusoft.electronictag.systemsetting.response.message.SystemSettingResultMessage;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/11 16:46
 */
public abstract class AbsSystemSettingExceptionCast extends AbsBaseExceptionCast {

    public abstract void castSystemSettingException(SystemSettingResultMessage message) throws SystemSettingException;

    @Override
    public void castCustomerException(ResultMessage resultMessage) throws CustomException {
        if(resultMessage instanceof SystemSettingResultMessage) {
            castSystemSettingException(((SystemSettingResultMessage) resultMessage));
        }
    }

    @Override
    public void castCustomerException(ResultMessage resultMessage, Object data) throws CustomException {
        if(resultMessage instanceof SystemSettingResultMessage) {
            castSystemSettingException(((SystemSettingResultMessage) resultMessage));
        }
    }
    
}
