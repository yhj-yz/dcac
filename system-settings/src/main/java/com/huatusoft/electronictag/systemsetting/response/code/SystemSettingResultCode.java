package com.huatusoft.electronictag.systemsetting.response.code;


import com.huatusoft.electronictag.base.response.code.ResultCode;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 0:14
 */
public enum SystemSettingResultCode implements ResultCode {

    BASE_PLATFORM_IP_CANNOT_BE_EMPTY_CODE("501"),
    BASE_PLATFORM_IP_FORMAT_IS_INCORRECT_CODE("502"),
    BASE_PLATFORM_PORT_CANNOT_BE_EMPTY_CODE("503"),
    BASE_PLATFORM_PORT_FORMAT_IS_INCORRECT_CODE("504"),
    BASE_PLATFORM_APP_ID_CANNOT_BE_EMPTY_CODE("505"),
    BASE_PLATFORM_SECRET_CANNOT_BE_EMPTY_CODE("506"),
    NO_ACCESS_CODE("507"),
    IP_ADDRESS_IS_ILLEGAL_CODE("508"),
    IP_DOES_NOT_EXIST_CODE("509");
    private String code;

    SystemSettingResultCode(String code) {
        this.code = code;
    }

    @Override
    public String getCode() {
        return this.code;
    }
}
