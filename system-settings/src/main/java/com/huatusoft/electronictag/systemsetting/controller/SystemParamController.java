package com.huatusoft.electronictag.systemsetting.controller;

import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.base.exception.CustomException;
import com.huatusoft.electronictag.base.response.Result;
import com.huatusoft.electronictag.common.constant.PlatformConstants;
import com.huatusoft.electronictag.common.util.NetworkUtils;
import com.huatusoft.electronictag.systemsetting.entity.SystemParamEntity;
import com.huatusoft.electronictag.systemsetting.exception.cast.SystemSettingExceptionCast;
import com.huatusoft.electronictag.systemsetting.response.message.SystemSettingResultMessage;
import com.huatusoft.electronictag.systemsetting.service.SystemParamService;
import com.huatusoft.electronictag.systemsetting.vo.SystemParamVo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.Objects;
import java.util.regex.Pattern;


/**
 * Controller - 系统参数
 *
 * @author: WangShun
 */
@Controller
@RequestMapping("/system_settings")
public class SystemParamController extends BaseController {

    private static final String IP_REGULAR = "^(([1-9]|([1-9]\\d)|(1\\d\\d)|(2([0-4]\\d|5[0-5]))).)(([1-9]|([1-9]\\d)|(1\\d\\d)|(2([0-4]\\d|5[0-5]))).){2}([1-9]|([1-9]\\d)|(1\\d\\d)|(2([0-4]\\d|5[0-5])))$";
    private static final String PORT_REGULAR = "^([0-9]|[1-9]\\d|[1-9]\\d{2}|[1-9]\\d{3}|[1-5]\\d{4}|6[0-4]\\d{3}|65[0-4]\\d{2}|655[0-2]\\d|6553[0-5])$";

    @Autowired
    private SystemParamService systemParamService;

    @Autowired
    private SystemSettingExceptionCast systemSettingExceptionCast;

    @GetMapping(value = "/list")
    public ModelAndView list(ModelAndView mv) {
        SystemParamEntity systemParam = systemParamService.findOne();
        if (Objects.nonNull(systemParam)) {
            mv.addObject(PlatformConstants.PLATFORM_IP, systemParam.getBasisPlatformIP());
            mv.addObject(PlatformConstants.PLATFORM_PORT, systemParam.getBasisPlatformPort());
            mv.addObject(PlatformConstants.PLATFORM_APP_ID, systemParam.getId());
            mv.addObject(PlatformConstants.PLATFORM_APP_SECRET, systemParam.getBasisPlatformSecret());
        }
        mv.setViewName("/systemSetting/systemProgram/list.ftl");
        return mv;
    }

    @PostMapping(value = "/save")
    @ResponseBody
    public Result save(SystemParamVo systemParamVo) throws CustomException {
        systemParamService.update(checkValue(systemParamVo));
        return Result.build("保存成功");
    }


    @PostMapping(value = "/test")
    @ResponseBody
    public Result testConnect(SystemParamVo systemParamVo) throws CustomException {
        SystemParamEntity systemParamEntity = checkValue(systemParamVo);
        try {
            if (NetworkUtils.printReachableIP(InetAddress.getByName(systemParamEntity.getBasisPlatformIP())
                    , Integer.parseInt(systemParamEntity.getBasisPlatformPort()))) {
                return Result.build("连接成功");
            }
        } catch (UnknownHostException e) {
            return Result.build("连接失败");
        }
        return Result.build("连接失败");

    }


    private SystemParamEntity checkValue(SystemParamVo systemParamVo) throws CustomException {
        SystemParamEntity systemParam = systemParamService.findOne();
        if (Objects.isNull(systemParam)) {
            systemParam = new SystemParamEntity();
        }
        if (StringUtils.isBlank(systemParamVo.getBasisPlatformIP())) {
            systemSettingExceptionCast.castCustomerException(SystemSettingResultMessage.BASE_PLATFORM_IP_CANNOT_BE_EMPTY_MESSAGE);
        } else if (!Pattern.compile(IP_REGULAR).matcher(systemParamVo.getBasisPlatformIP()).matches()) {
            systemSettingExceptionCast.castSystemSettingException(SystemSettingResultMessage.BASE_PLATFORM_IP_FORMAT_IS_INCORRECT_MESSAGE);
        } else {
            systemParam.setBasisPlatformIP(systemParamVo.getBasisPlatformIP());
        }

        if (StringUtils.isBlank(systemParamVo.getBasisPlatformPort())) {
            systemSettingExceptionCast.castSystemSettingException(SystemSettingResultMessage.BASE_PLATFORM_PORT_CANNOT_BE_EMPTY_MESSAGE);
        } else if (!Pattern.compile(PORT_REGULAR).matcher(systemParamVo.getBasisPlatformPort()).matches()) {
            systemSettingExceptionCast.castSystemSettingException(SystemSettingResultMessage.BASE_PLATFORM_PORT_FORMAT_IS_INCORRECT_MESSAGE);
        } else {
            systemParam.setBasisPlatformPort(systemParamVo.getBasisPlatformPort());
        }

        if (StringUtils.isBlank(systemParamVo.getBasisPlatformAppId())) {
            systemSettingExceptionCast.castSystemSettingException(SystemSettingResultMessage.BASE_PLATFORM_APP_ID_CANNOT_BE_EMPTY_MESSAGE);
        } else {
            systemParam.setBasisPlatformAppId(systemParamVo.getBasisPlatformAppId());
        }

        if (StringUtils.isBlank(systemParamVo.getBasisPlatformSecret())) {
            systemSettingExceptionCast.castSystemSettingException(SystemSettingResultMessage.BASE_PLATFORM_SECRET_CANNOT_BE_EMPTY_MESSAGE);
        } else {
            systemParam.setBasisPlatformSecret(systemParamVo.getBasisPlatformSecret());
        }
        return systemParam;
    }

}
