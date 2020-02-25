package com.huatusoft.dcac.systemsetting.exception.cast;

import com.huatusoft.dcac.base.exception.CustomException;
import com.huatusoft.dcac.base.exception.cast.AbsBaseExceptionCast;
import com.huatusoft.dcac.base.response.message.ResultMessage;
import com.huatusoft.dcac.systemsetting.exception.SystemSettingException;
import com.huatusoft.dcac.systemsetting.response.message.SystemSettingResultMessage;

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
