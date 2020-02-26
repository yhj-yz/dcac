package com.huatusoft.dcac.authentication.response.message;

import com.huatusoft.dcac.base.response.message.ResultMessage;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 0:26
 */
public enum  AuthenticationResultMessage implements ResultMessage {

    USER_IS_NOT_REGISTERED_MESSAGE("该用户尚未注册"),
    USER_ALREADY_EXISTS_MESSAGE("该用户已经存在"),
    USER_HAS_DISABLED_MESSAGE("用户已经被管理员禁用"),
    PASSWORD_WRONG_MESSAGE("密码错误"),
    USER_NOT_EXIST_MESSAGE("用户信息不存在"),
    USER_IS_LOCKED_MESSAGE("用户被锁定"),
    USER_IS_LOGIN_MESSAGE("用户已经登录"),
    VERIFICATION_CODE_INPUT_IS_INCORRECT_MESSAGE("验证码输入有误,请点击切换验证码");

    private String message;

    AuthenticationResultMessage(String message) {
        this.message = message;
    }

    @Override
    public String getMessage() {
        return this.message;
    }
}
