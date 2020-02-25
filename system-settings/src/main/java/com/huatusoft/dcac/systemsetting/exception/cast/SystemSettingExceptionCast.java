package com.huatusoft.dcac.systemsetting.exception.cast;

import com.huatusoft.dcac.systemsetting.exception.SystemSettingException;
import com.huatusoft.dcac.systemsetting.response.message.SystemSettingResultMessage;
import org.springframework.stereotype.Component;

/**
 * @author WangShun
 */
@Component
public class SystemSettingExceptionCast extends AbsSystemSettingExceptionCast {

    @Override
    public void castSystemSettingException(SystemSettingResultMessage message) throws SystemSettingException {
        throw new SystemSettingException(message);
    }
}