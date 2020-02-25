package com.huatusoft.electronictag.authentication.response.info;

import com.huatusoft.electronictag.authentication.response.code.AuthenticationResultCode;
import com.huatusoft.electronictag.authentication.response.message.AuthenticationResultMessage;
import com.huatusoft.electronictag.base.response.code.ResultCode;
import com.huatusoft.electronictag.base.response.message.ResultMessage;
import lombok.Getter;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/29 13:02
 */
@Getter
public enum AuthenticationResultInfo implements ResultCode, ResultMessage {

    USER_IS_NOT_REGISTERED_INFO(AuthenticationResultCode.USER_IS_NOT_REGISTERED_CODE, AuthenticationResultMessage.USER_IS_NOT_REGISTERED_MESSAGE),
    USER_ALREADY_EXISTS_INFO(AuthenticationResultCode.USER_ALREADY_EXISTS_CODE, AuthenticationResultMessage.USER_ALREADY_EXISTS_MESSAGE),
    PASSWORD_WRONG_INFO(AuthenticationResultCode.PASSWORD_WRONG_CODE, AuthenticationResultMessage.PASSWORD_WRONG_MESSAGE),
    USER_NOT_EXIST_INFO(AuthenticationResultCode.USER_NOT_EXIST_CODE, AuthenticationResultMessage.USER_NOT_EXIST_MESSAGE),
    USER_IS_LOCKED_INFO(AuthenticationResultCode.USER_IS_LOCKED_CODE, AuthenticationResultMessage.USER_IS_LOCKED_MESSAGE),
    USER_IS_LOGIN_INFO(AuthenticationResultCode.USER_IS_LOGIN_CODE, AuthenticationResultMessage.USER_IS_LOGIN_MESSAGE),
    USER_HAS_DISABLED_INFO(AuthenticationResultCode.USER_HAS_DISABLED_CODE, AuthenticationResultMessage.USER_HAS_DISABLED_MESSAGE),
    VERIFICATION_CODE_INPUT_IS_INCORRECT_INFO(AuthenticationResultCode.VERIFICATION_CODE_INPUT_IS_INCORRECT_CODE,AuthenticationResultMessage.VERIFICATION_CODE_INPUT_IS_INCORRECT_MESSAGE);
    private AuthenticationResultCode resultCode;
    private AuthenticationResultMessage resultMessage;

    AuthenticationResultInfo(AuthenticationResultCode resultCode, AuthenticationResultMessage resultMessage) {
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

    public static AuthenticationResultCode getResultCodeByMessage(AuthenticationResultMessage message) {
        return AuthenticationResultInfo.valueOf(message.name().replace("_MESSAGE", "_INFO")).getResultCode();
    }

    public static AuthenticationResultMessage getResultMessageByCode(AuthenticationResultCode code) {
        return AuthenticationResultInfo.valueOf(code.name().replace("_CODE", "_INFO")).getResultMessage();
    }
}
