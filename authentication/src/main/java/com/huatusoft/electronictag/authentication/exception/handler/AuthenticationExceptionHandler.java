package com.huatusoft.electronictag.authentication.exception.handler;

import com.huatusoft.electronictag.base.handler.BaseExceptionHandler;
import com.huatusoft.electronictag.base.handler.ExceptionHandler;
import com.huatusoft.electronictag.common.bo.CommonAttributes;
import com.huatusoft.electronictag.common.bo.Setting;
import com.huatusoft.electronictag.base.exception.CustomException;
import com.huatusoft.electronictag.common.util.FastJsonUtils;
import com.huatusoft.electronictag.common.util.SettingUtils;
import com.huatusoft.electronictag.auditlog.entity.ManagerLogEntity;
import com.huatusoft.electronictag.auditlog.model.ManagerLogDescriptionParse;
import com.huatusoft.electronictag.auditlog.model.ManagerLogOperationModel;
import com.huatusoft.electronictag.auditlog.model.ManagerLogOperationType;
import com.huatusoft.electronictag.auditlog.service.ManagerLogService;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import com.huatusoft.electronictag.organizationalstrucure.service.UserService;
import com.huatusoft.electronictag.base.response.Result;
import com.huatusoft.electronictag.authentication.response.info.AuthenticationResultInfo;
import com.huatusoft.electronictag.authentication.response.message.AuthenticationResultMessage;
import org.apache.commons.lang.time.DateFormatUtils;
import org.apache.commons.lang.time.DateUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;
import java.util.Objects;

import static com.huatusoft.electronictag.authentication.response.message.AuthenticationResultMessage.*;
import static com.huatusoft.electronictag.authentication.response.message.AuthenticationResultMessage.USER_IS_NOT_REGISTERED_MESSAGE;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/8 13:35
 */
@Component
public class AuthenticationExceptionHandler extends BaseExceptionHandler implements ExceptionHandler {

    @Autowired
    protected ManagerLogService managerLogService;

    @Autowired
    protected UserService userService;

    protected Setting setting = SettingUtils.get();

    @Override
    public String handlingException(CustomException e) {
        String responseJson = null;
        AuthenticationResultMessage authenticationResultMessage = ((AuthenticationResultMessage) super.getResultMessage(e,AuthenticationResultMessage.class));
        String authenticationResultUserAccount = String.valueOf(super.getData(e));
        switch (authenticationResultMessage) {
            case USER_HAS_DISABLED_MESSAGE:
            case USER_IS_LOCKED_MESSAGE:
                responseJson = handlingUserIsLockedMessage(authenticationResultUserAccount);
                LOGGER.info(USER_IS_LOCKED_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + authenticationResultUserAccount);
                break;
            case USER_NOT_EXIST_MESSAGE:
                LOGGER.info(USER_NOT_EXIST_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + authenticationResultUserAccount);
                break;
            case USER_ALREADY_EXISTS_MESSAGE:
                LOGGER.info(USER_ALREADY_EXISTS_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + authenticationResultUserAccount);
                break;
            case USER_IS_LOGIN_MESSAGE:
                LOGGER.info(USER_IS_LOGIN_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + authenticationResultUserAccount);
                break;
            case USER_IS_NOT_REGISTERED_MESSAGE:
                LOGGER.info(USER_IS_NOT_REGISTERED_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + authenticationResultUserAccount);
                break;
            case PASSWORD_WRONG_MESSAGE:
                responseJson = handlingPasswordWrongMessage(authenticationResultUserAccount);
                LOGGER.info(PASSWORD_WRONG_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + authenticationResultUserAccount);
                break;
            case VERIFICATION_CODE_INPUT_IS_INCORRECT_MESSAGE:
                LOGGER.info(VERIFICATION_CODE_INPUT_IS_INCORRECT_MESSAGE.getMessage() + CommonAttributes.DATA_SEPARATOR + authenticationResultUserAccount);
                break;
            default:
                LOGGER.info(e.getMessage());
                break;
        }
        if(Objects.isNull(responseJson)){
            responseJson = FastJsonUtils.convertObjectToJSON(authenticationMessageHandler(authenticationResultMessage));
        } else {
            responseJson = FastJsonUtils.convertObjectToJSON(authenticationMessageHandler(responseJson));
        }
        return responseJson;
    }

    private String handlingPasswordWrongMessage(String account) {
        ManagerLogEntity managerLogEntity = new ManagerLogEntity();
        String responseJson = null;
        UserEntity user = userService.getUserByAccount(account);
        Integer loginFailureCount = user.getLoginFailureCount();
        if (loginFailureCount < setting.getAccountLockCount()) {
            user.setLoginFailureCount(++loginFailureCount);
            managerLogEntity.setDescription(ManagerLogDescriptionParse.parse(user,ManagerLogOperationModel.LOGIN,ManagerLogOperationType.FAILURE,"密码输入错误" + loginFailureCount + "次"));
            responseJson = "密码输入错误" + loginFailureCount + "次" + setting.getAccountLockCount() + "次后该账号将被锁定";
        } else {
            //添加锁定时间
            Date date = DateUtils.addMinutes(new Date(), setting.getAccountLockTime());
            user.setIsLocked(1);
            user.setLockedDate(date);
            user.setLoginFailureCount(0);
            responseJson = "账号已锁定, 锁定时间:" + DateFormatUtils.format(date,"yyyy-MM-dd HH:mm:ss");
        }
        userService.update(user);
        managerLogEntity.setOperationModel(ManagerLogOperationModel.LOGIN.getName());
        managerLogEntity.setOperationType(ManagerLogOperationType.FAILURE.getName());
        managerLogService.addManagerLog(managerLogEntity);
        return responseJson;
    }

    private String handlingUserIsLockedMessage(String account) {
        ManagerLogEntity managerLogEntity = new ManagerLogEntity();
        UserEntity user = userService.getUserByAccount(account);
        Date date = DateUtils.addMinutes(user.getLockedDate(), setting.getAccountLockTime());
        user.setLockedDate(date);
        userService.update(user);
        managerLogEntity.setOperationModel(ManagerLogOperationModel.LOGIN.getName());
        managerLogEntity.setOperationType(ManagerLogOperationType.FAILURE.getName());
        managerLogEntity.setDescription(ManagerLogDescriptionParse.parse(user,ManagerLogOperationModel.LOGIN,ManagerLogOperationType.FAILURE,"密码输入错误次数过多,锁定登陆"));
        managerLogService.addManagerLog(managerLogEntity);
        return "输入密码错误次数过多, 在" + DateFormatUtils.format(date,"yyyy-MM-dd HH:mm:ss") + "期间无法登陆系统";
    }

    private Result authenticationMessageHandler(AuthenticationResultMessage message) {
        return Result.build(AuthenticationResultInfo.getResultCodeByMessage(message).getCode(), message.getMessage());
    }

    private Result authenticationMessageHandler(String message) {
        return Result.build( message);
    }


}
