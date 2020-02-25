package com.huatusoft.electronictag.systemsetting.controller;

import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.base.response.Result;
import com.huatusoft.electronictag.common.bo.PageVo;
import com.huatusoft.electronictag.common.bo.PageableVo;
import com.huatusoft.electronictag.systemsetting.entity.IpAddressEntity;
import com.huatusoft.electronictag.systemsetting.exception.SystemSettingException;
import com.huatusoft.electronictag.systemsetting.exception.cast.SystemSettingExceptionCast;
import com.huatusoft.electronictag.systemsetting.response.message.SystemSettingResultMessage;
import com.huatusoft.electronictag.systemsetting.service.IpAddressAuthenticationService;
import com.huatusoft.electronictag.systemsetting.vo.IpAddressVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.Objects;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 18:00
 */
@Controller
@RequestMapping("/ip_authentication")
public class IpAddressAuthenticationController extends BaseController {

    @Autowired
    private IpAddressAuthenticationService ipAddressAuthenticationService;

    @Autowired
    private SystemSettingExceptionCast systemSettingExceptionCast;

    @GetMapping("/list")
    public String list() {
        return "/whitelist/list.ftl";
    }

    @GetMapping("/search")
    @ResponseBody
    public PageVo<IpAddressEntity> search(
            @RequestParam(value = "warnDetail", required = false) String warnDetail
            , @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber
            , @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize) throws SystemSettingException {
        Page<IpAddressEntity> ipAddressPage = ipAddressAuthenticationService.search(pageNumber, pageSize, warnDetail);
        return new PageVo<IpAddressEntity>(ipAddressPage.getContent(), ipAddressPage.getTotalElements(), new PageableVo(ipAddressPage.getNumber(), ipAddressPage.getSize()));
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result delete(@RequestParam("ids") String[] ids) {
        ipAddressAuthenticationService.delete(IpAddressEntity.class, ids);
        return Result.ok();
    }

    @PostMapping("/edit")
    @ResponseBody
    public Result edit(IpAddressEntity ipAddressEntity) throws SystemSettingException {
        if (Objects.isNull(ipAddressEntity)) {
            systemSettingExceptionCast.castSystemSettingException(SystemSettingResultMessage.IP_DOES_NOT_EXIST_MESSAGE);
        }
        IpAddressEntity ipAddress = ipAddressAuthenticationService.find( ipAddressEntity.getId());
        if (Objects.isNull(ipAddress)) {
            systemSettingExceptionCast.castSystemSettingException(SystemSettingResultMessage.IP_DOES_NOT_EXIST_MESSAGE);
        }
        ipAddress.setIpAddress(ipAddressEntity.getIpAddress());
        return Result.ok();
    }

    @PostMapping(value = "/add")
    @ResponseBody
    public Result addIPWhiteList(IpAddressVo ipAddressVo) throws SystemSettingException {
        if (Objects.isNull(ipAddressVo)) {
            systemSettingExceptionCast.castSystemSettingException(SystemSettingResultMessage.IP_DOES_NOT_EXIST_MESSAGE);
        }
        IpAddressEntity ipAddress = new IpAddressEntity();
        ipAddress.setIpAddress(ipAddressVo.getIpAddress());
        ipAddressAuthenticationService.add(ipAddress);
        return Result.ok();
    }
}
