package com.huatusoft.dcac.systemsetting.response.message;

import com.huatusoft.dcac.base.response.message.ResultMessage;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 0:26
 */
public enum SystemSettingResultMessage implements ResultMessage {
    BASE_PLATFORM_IP_CANNOT_BE_EMPTY_MESSAGE("基础平台IP地址不能为空"),
    BASE_PLATFORM_IP_FORMAT_IS_INCORRECT_MESSAGE("基础平台IP地址输入不合法"),
    BASE_PLATFORM_PORT_CANNOT_BE_EMPTY_MESSAGE("基础平台端口号不能为空"),
    BASE_PLATFORM_PORT_FORMAT_IS_INCORRECT_MESSAGE("基础平台端口号输入不合法"),
    BASE_PLATFORM_APP_ID_CANNOT_BE_EMPTY_MESSAGE("基础平台子系统注册ID不能为空"),
    BASE_PLATFORM_SECRET_CANNOT_BE_EMPTY_MESSAGE("基础平台注册授权码不能为空"),
    NO_ACCESS_MESSAGE("没有访问权限"),
    IP_ADDRESS_IS_ILLEGAL_MESSAGE("IP地址输入不合法"),
    IP_DOES_NOT_EXIST_MESSAGE("IP地址不存在");
    private String message;

    SystemSettingResultMessage(String message) {
        this.message = message;
    }

    @Override
    public String getMessage() {
        return this.message;
    }
}
