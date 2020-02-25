/**
 * @author yhj
 * @date 2019-11-12
 */
package com.huatusoft.electronictag.securitystrategycenter.response.code;

import com.huatusoft.electronictag.base.response.code.ResultCode;

public enum  PermissionResultCode implements ResultCode {
    PERMISSION_NAME_REPEAT_CODE("401"),
    PERMISSION_NULL_CODE("402"),
    PERMISSION_SET_FAILED_CODE("403"),
    PERMISSION_PARAMETER_NULL_CODE("404");

    private String code;

    PermissionResultCode(String code){
        this.code = code;
    }

    @Override
    public String getCode() {
        return this.code;
    }
}
