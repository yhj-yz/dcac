/**
 * @author yhj
 * @date 2019-11-12
 */
package com.huatusoft.electronictag.securitystrategycenter.response.info;

import com.huatusoft.electronictag.base.response.code.ResultCode;
import com.huatusoft.electronictag.base.response.message.ResultMessage;
import com.huatusoft.electronictag.securitystrategycenter.response.code.PermissionResultCode;
import com.huatusoft.electronictag.securitystrategycenter.response.message.PermissionResultMessage;
import lombok.Getter;

@Getter
public enum PermissionResultInfo implements ResultCode, ResultMessage {
    PERMISSION_NAME_REPEAT_INFO(PermissionResultCode.PERMISSION_NAME_REPEAT_CODE,PermissionResultMessage.PERMISSION_NAME_REPEAT_MESSAGE),
    PERMISSION_NULL_INFO(PermissionResultCode.PERMISSION_NULL_CODE,PermissionResultMessage.PERMISSION_NULL_MESSAGE),
    PERMISSION_SET_FAILED_INFO(PermissionResultCode.PERMISSION_SET_FAILED_CODE,PermissionResultMessage.PERMISSION_SET_FAILED_MESSAGE),
    PERMISSION_PARAMETER_NULL_INFO(PermissionResultCode.PERMISSION_PARAMETER_NULL_CODE,PermissionResultMessage.PERMISSION_PARAMETER_NULL_MESSAGE);

    private PermissionResultCode resultCode;

    private PermissionResultMessage resultMessage;

    PermissionResultInfo(PermissionResultCode resultCode,PermissionResultMessage resultMessage){
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

    public static PermissionResultCode getResultCodeByMessage(PermissionResultMessage message) {
        return PermissionResultInfo.valueOf(message.name().replace("_MESSAGE", "_INFO")).getResultCode();
    }

    public static PermissionResultMessage getResultMessageByCode(PermissionResultCode code) {
        return PermissionResultInfo.valueOf(code.name().replace("_CODE", "_INFO")).getResultMessage();
    }
}
