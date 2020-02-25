package com.huatusoft.dcac.systemsetting.exception;

import com.huatusoft.dcac.base.exception.CustomException;
import com.huatusoft.dcac.base.response.message.ResultMessage;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 10:01
 */
public class SystemSettingException extends CustomException {

    private static final long serialVersionUID = -8764191822448875681L;

    public SystemSettingException(ResultMessage resultMessage) {
        super(resultMessage);
    }
}
