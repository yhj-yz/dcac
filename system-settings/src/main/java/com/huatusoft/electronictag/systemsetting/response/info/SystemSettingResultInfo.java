package com.huatusoft.electronictag.systemsetting.response.info;

import com.huatusoft.electronictag.base.response.code.ResultCode;
import com.huatusoft.electronictag.base.response.message.ResultMessage;
import com.huatusoft.electronictag.systemsetting.response.code.SystemSettingResultCode;
import com.huatusoft.electronictag.systemsetting.response.message.SystemSettingResultMessage;
import lombok.Getter;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/29 13:02
 */
@Getter
public enum SystemSettingResultInfo implements ResultCode, ResultMessage {
    BASE_PLATFORM_IP_CANNOT_BE_EMPTY_INFO(SystemSettingResultCode.BASE_PLATFORM_IP_CANNOT_BE_EMPTY_CODE, SystemSettingResultMessage.BASE_PLATFORM_IP_CANNOT_BE_EMPTY_MESSAGE),
    BASE_PLATFORM_IP_FORMAT_IS_INCORRECT_INFO(SystemSettingResultCode.BASE_PLATFORM_IP_FORMAT_IS_INCORRECT_CODE, SystemSettingResultMessage.BASE_PLATFORM_IP_FORMAT_IS_INCORRECT_MESSAGE),
    BASE_PLATFORM_PORT_CANNOT_BE_EMPTY_INFO(SystemSettingResultCode.BASE_PLATFORM_PORT_CANNOT_BE_EMPTY_CODE, SystemSettingResultMessage.BASE_PLATFORM_PORT_FORMAT_IS_INCORRECT_MESSAGE),
    BASE_PLATFORM_PORT_FORMAT_IS_INCORRECT_INFO(SystemSettingResultCode.BASE_PLATFORM_PORT_FORMAT_IS_INCORRECT_CODE,SystemSettingResultMessage.BASE_PLATFORM_PORT_FORMAT_IS_INCORRECT_MESSAGE),
    BASE_PLATFORM_APP_ID_CANNOT_BE_EMPTY_INFO(SystemSettingResultCode.BASE_PLATFORM_APP_ID_CANNOT_BE_EMPTY_CODE,SystemSettingResultMessage.BASE_PLATFORM_APP_ID_CANNOT_BE_EMPTY_MESSAGE),
    BASE_PLATFORM_SECRET_CANNOT_BE_EMPTY_INFO(SystemSettingResultCode.BASE_PLATFORM_SECRET_CANNOT_BE_EMPTY_CODE, SystemSettingResultMessage.BASE_PLATFORM_SECRET_CANNOT_BE_EMPTY_MESSAGE),
    NO_ACCESS_INFO(SystemSettingResultCode.NO_ACCESS_CODE, SystemSettingResultMessage.NO_ACCESS_MESSAGE),
    IP_ADDRESS_IS_ILLEGAL_INFO(SystemSettingResultCode.IP_ADDRESS_IS_ILLEGAL_CODE, SystemSettingResultMessage.IP_ADDRESS_IS_ILLEGAL_MESSAGE),
    IP_DOES_NOT_EXIST_INFO(SystemSettingResultCode.IP_DOES_NOT_EXIST_CODE,SystemSettingResultMessage.IP_DOES_NOT_EXIST_MESSAGE);
    private SystemSettingResultCode resultCode;
    private SystemSettingResultMessage resultMessage;

    SystemSettingResultInfo(SystemSettingResultCode resultCode, SystemSettingResultMessage resultMessage) {
        this.resultCode = resultCode;
        this.resultMessage = resultMessage;
    }

    @Override
    public String getCode() {
        return resultCode.getCode();
    }

    @Override
    public String getMessage() {
        return resultMessage.getMessage();
    }

    public static SystemSettingResultCode getResultCodeByMessage(SystemSettingResultMessage message) {
        return SystemSettingResultInfo.valueOf(message.name().replace("_MESSAGE", "_INFO")).getResultCode();
    }

    public static SystemSettingResultMessage getResultMessageByCode(SystemSettingResultCode code) {
        return SystemSettingResultInfo.valueOf(code.name().replace("_CODE", "_INFO")).getResultMessage();
    }
}
