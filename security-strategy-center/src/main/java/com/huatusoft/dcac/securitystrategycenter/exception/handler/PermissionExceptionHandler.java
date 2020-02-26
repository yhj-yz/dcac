/**
 * @author yhj
 * @date 2019-11-12
 */
package com.huatusoft.dcac.securitystrategycenter.exception.handler;

import com.huatusoft.dcac.base.exception.CustomException;
import com.huatusoft.dcac.base.handler.BaseExceptionHandler;
import com.huatusoft.dcac.base.handler.ExceptionHandler;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.CommonAttributes;
import com.huatusoft.dcac.common.util.FastJsonUtils;
import com.huatusoft.dcac.securitystrategycenter.response.info.PermissionResultInfo;
import com.huatusoft.dcac.securitystrategycenter.response.message.PermissionResultMessage;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.util.Objects;

import static com.huatusoft.dcac.securitystrategycenter.response.message.PermissionResultMessage.PERMISSION_NAME_REPEAT_MESSAGE;
import static com.huatusoft.dcac.securitystrategycenter.response.message.PermissionResultMessage.PERMISSION_NULL_MESSAGE;
import static com.huatusoft.dcac.securitystrategycenter.response.message.PermissionResultMessage.PERMISSION_PARAMETER_NULL_MESSAGE;
import static com.huatusoft.dcac.securitystrategycenter.response.message.PermissionResultMessage.PERMISSION_SET_FAILED_MESSAGE;

@Component
public class PermissionExceptionHandler extends BaseExceptionHandler implements ExceptionHandler{

    @Override
    public String handlingException(CustomException e) throws IOException {
        String responseJson = null;
        PermissionResultMessage permissionResultMessage = (PermissionResultMessage) super.getResultMessage(e,PermissionResultMessage.class);
        String PermissionResultUserAcccount = String.valueOf(super.getData(e));
        switch (permissionResultMessage){
            case PERMISSION_NAME_REPEAT_MESSAGE:
                LOGGER.error(PERMISSION_NAME_REPEAT_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + PermissionResultUserAcccount);
            case PERMISSION_NULL_MESSAGE:
                LOGGER.error(PERMISSION_NULL_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + PermissionResultUserAcccount);
            case PERMISSION_SET_FAILED_MESSAGE:
                LOGGER.error(PERMISSION_SET_FAILED_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + PermissionResultUserAcccount);
            case PERMISSION_PARAMETER_NULL_MESSAGE:
                LOGGER.error(PERMISSION_PARAMETER_NULL_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + PermissionResultUserAcccount);
        }
        if(Objects.isNull(responseJson)){
            responseJson = FastJsonUtils.convertObjectToJSON(permissionMessageHandler(permissionResultMessage));
        } else {
            responseJson = FastJsonUtils.convertObjectToJSON(permissionMessageHandler(responseJson));
        }
        return responseJson;
    }

    private Result permissionMessageHandler(PermissionResultMessage message) {
        return Result.build(PermissionResultInfo.getResultCodeByMessage(message).getCode(), message.getMessage());
    }

    private Result permissionMessageHandler(String message) {
        return Result.build( message);
    }

}
