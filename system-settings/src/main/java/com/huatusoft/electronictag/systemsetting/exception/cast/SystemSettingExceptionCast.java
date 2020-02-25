package com.huatusoft.electronictag.systemsetting.exception.cast;

import com.huatusoft.electronictag.systemsetting.exception.SystemSettingException;
import com.huatusoft.electronictag.systemsetting.response.message.SystemSettingResultMessage;
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