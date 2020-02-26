package com.huatusoft.dcac.authentication.response.code;


import com.huatusoft.dcac.base.response.code.ResultCode;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 0:14
 */
public enum AuthenticationResultCode implements ResultCode {

    USER_IS_NOT_REGISTERED_CODE("401"),
    USER_ALREADY_EXISTS_CODE("402"),
    USER_HAS_DISABLED_CODE("403"),
    PASSWORD_WRONG_CODE("404"),
    USER_NOT_EXIST_CODE("405"),
    USER_IS_LOCKED_CODE("406"),
    USER_IS_LOGIN_CODE("407"),
    VERIFICATION_CODE_INPUT_IS_INCORRECT_CODE("408");

    private String code;

    AuthenticationResultCode(String code) {
        this.code = code;
    }

    @Override
    public String getCode() {
        return this.code;
    }
}
