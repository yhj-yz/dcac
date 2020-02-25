package com.huatusoft.electronictag.systemsetting.exception.handler;

import com.huatusoft.electronictag.base.exception.CustomException;
import com.huatusoft.electronictag.base.handler.BaseExceptionHandler;
import com.huatusoft.electronictag.base.handler.ExceptionHandler;
import com.huatusoft.electronictag.base.response.Result;
import com.huatusoft.electronictag.common.bo.CommonAttributes;
import com.huatusoft.electronictag.common.util.FastJsonUtils;
import com.huatusoft.electronictag.auditlog.service.ManagerLogService;
import com.huatusoft.electronictag.systemsetting.response.info.SystemSettingResultInfo;
import com.huatusoft.electronictag.systemsetting.response.message.SystemSettingResultMessage;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import java.util.Objects;
import static com.huatusoft.electronictag.systemsetting.response.message.SystemSettingResultMessage.*;


/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 13:35
 */
@Component
public class SystemSettingExceptionHandler extends BaseExceptionHandler implements ExceptionHandler {

    @Autowired
    private ManagerLogService managerLogService;

    @Override
    public String handlingException(CustomException e)  {
        String responseJson = null;
        SystemSettingResultMessage SystemSettingResultMessage = ((SystemSettingResultMessage) super.getResultMessage(e,SystemSettingResultMessage.class));
        String SystemParamResultUserAccount = String.valueOf(super.getData(e));
        switch (SystemSettingResultMessage) {
            case BASE_PLATFORM_IP_CANNOT_BE_EMPTY_MESSAGE:
                LOGGER.info(BASE_PLATFORM_IP_CANNOT_BE_EMPTY_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + SystemParamResultUserAccount);
                break;
            case BASE_PLATFORM_IP_FORMAT_IS_INCORRECT_MESSAGE:
                LOGGER.info(BASE_PLATFORM_IP_FORMAT_IS_INCORRECT_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + SystemParamResultUserAccount);
                break;
            case BASE_PLATFORM_PORT_CANNOT_BE_EMPTY_MESSAGE:
                LOGGER.info(BASE_PLATFORM_PORT_CANNOT_BE_EMPTY_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + SystemParamResultUserAccount);
                break;
            case BASE_PLATFORM_PORT_FORMAT_IS_INCORRECT_MESSAGE:
                LOGGER.info(BASE_PLATFORM_PORT_FORMAT_IS_INCORRECT_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + SystemParamResultUserAccount);
                break;
            case BASE_PLATFORM_APP_ID_CANNOT_BE_EMPTY_MESSAGE:
                LOGGER.info(BASE_PLATFORM_APP_ID_CANNOT_BE_EMPTY_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + SystemParamResultUserAccount);
                break;
            default:
                LOGGER.info(e.getMessage());
                break;
        }
        if(Objects.isNull(responseJson)){
            responseJson = FastJsonUtils.convertObjectToJSON(SystemParamMessageHandler(SystemSettingResultMessage));
        } else {
            responseJson = FastJsonUtils.convertObjectToJSON(SystemParamMessageHandler(responseJson));
        }
        return responseJson;
    }


    private Result SystemParamMessageHandler(SystemSettingResultMessage message) {
        return Result.build(SystemSettingResultInfo.getResultCodeByMessage(message).getCode(), message.getMessage());
    }

    private Result SystemParamMessageHandler(String message) {
        return Result.build( message);
    }


}
