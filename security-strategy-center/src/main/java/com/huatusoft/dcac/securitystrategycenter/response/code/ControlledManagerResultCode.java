/**
 * @author yhj
 * @date 2019-11-13
 */
package com.huatusoft.dcac.securitystrategycenter.response.code;

import com.huatusoft.dcac.base.response.code.ResultCode;

public enum ControlledManagerResultCode implements ResultCode {
    PERMISSION_NAME_REPEAT_CODE("401");

    private String code;

    ControlledManagerResultCode(String code){
        this.code = code;
    }

    @Override
    public String getCode() {
        return this.code;
    }
}
