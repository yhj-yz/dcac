/**
 * @author yhj
 * @date 2019-11-12
 */
package com.huatusoft.electronictag.securitystrategycenter.response.message;

import com.huatusoft.electronictag.base.response.message.ResultMessage;

public enum PermissionResultMessage implements ResultMessage {
    PERMISSION_NAME_REPEAT_MESSAGE("权限集名称重复"),
    PERMISSION_NULL_MESSAGE("权限集不能为空"),
    PERMISSION_SET_FAILED_MESSAGE("设置权限集失败"),
    PERMISSION_PARAMETER_NULL_MESSAGE("参数不能为空");

    private String message;

    PermissionResultMessage(String message){
        this.message = message;
    }

    @Override
    public String getMessage() {
        return this.message;
    }
}
