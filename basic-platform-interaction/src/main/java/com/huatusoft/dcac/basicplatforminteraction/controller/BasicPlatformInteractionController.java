package com.huatusoft.dcac.basicplatforminteraction.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformAccessControlService;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformInteractionService;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformSyncService;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformSystemStatusService;
import com.huatusoft.dcac.basicplatforminteraction.vo.*;
import com.huatusoft.dcac.common.constant.PlatformConstants;
import com.huatusoft.dcac.organizationalstrucure.service.DepartmentService;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import com.huatusoft.dcac.systemsetting.entity.SystemParamEntity;
import com.huatusoft.dcac.systemsetting.service.SystemParamService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.Date;
import java.util.Objects;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 12:35
 */
@RequestMapping("/platform_interaction/")
@Controller
public class BasicPlatformInteractionController extends BaseController {

    @Autowired
    private BasicPlatformInteractionService basicPlatformInteractionService;

    @Autowired
    private BasicPlatformSyncService basicPlatformSyncService;

    @Autowired
    private BasicPlatformSystemStatusService basicPlatformSystemStatusService;

    @Autowired
    private SystemParamService systemParamService;

    @Autowired
    private BasicPlatformAccessControlService basicPlatformAccessControlService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private UserService userService;

    /**
     * 子系统在平台注册后，平台通知子系统app_id和app_secret
     */
    @ResponseBody
    @PostMapping(value = "/register")
    public PlatformInteractionResult<Object> registerNotify(PlatformInfo platformInfo) {
        SystemParamEntity systemParam = systemParamService.findOne();
        if(StringUtils.isNotBlank(platformInfo.getApp_id())) {
            super.servletContext.setAttribute(PlatformConstants.PLATFORM_APP_ID, platformInfo.getApp_id());
            systemParam.setBasisPlatformAppId(platformInfo.getApp_id());
        }
        if(StringUtils.isNotBlank(platformInfo.getApp_secret())) {
            super.servletContext.setAttribute(PlatformConstants.PLATFORM_APP_SECRET, platformInfo.getApp_secret());
            systemParam.setBasisPlatformSecret(platformInfo.getApp_secret());
        }
        systemParamService.update(systemParam);
        return PlatformInteractionResult.success();
    }

    /**
     * 接收平台同步通知，type标识同步类型：1同步部门，2同步用户
     */
    @ResponseBody
    @PostMapping(value = "/sync")
    public PlatformInteractionResult<Object> syncNotify(PlatformInfo platformInfo) throws Exception {
        String basicPlatformAccessToken = basicPlatformAccessControlService.getBasicPlatformAccessToken(
                String.valueOf(servletContext.getAttribute(PlatformConstants.PLATFORM_APP_ID))
        ,String.valueOf(servletContext.getAttribute(PlatformConstants.PLATFORM_APP_SECRET))
        , PlatformConstants.ACCESS_GRANT_TYPE_VAlUE);
        SystemParamEntity systemParam = systemParamService.findOne();

        if (StringUtils.isNotBlank(platformInfo.getType()) && Objects.equals(PlatformConstants.SYNC_DEPT, platformInfo.getType())) {
            this.syncDept(basicPlatformAccessToken, systemParam.getLastSyncDeptSuccessDate());
        }
        if (StringUtils.isNotBlank(platformInfo.getType()) && Objects.equals(PlatformConstants.SYNC_USER, platformInfo.getType())) {
            //开始同步用户
            this.syncUser(basicPlatformAccessToken, systemParam.getLastSyncUserSuccessDate());
        }
        return PlatformInteractionResult.success();
    }


    /**
     * 接受平台查询状态，
     */
    @ResponseBody
    @PostMapping(value = "/status")
    public StatusReportVo statusCheck(PlatformInfo platformInfo) throws IOException {
        String platformAppId = null;
        String platformAppSecret = null;
        StatusReportVo statusReportVo = null;

        if(StringUtils.isNotBlank(platformInfo.getApp_id())) {
             platformAppId = String.valueOf(servletContext.getAttribute(PlatformConstants.PLATFORM_APP_ID));
        }

        if(StringUtils.isNotBlank(platformInfo.getApp_secret())) {
            platformAppSecret = String.valueOf(servletContext.getAttribute(PlatformConstants.PLATFORM_APP_SECRET));
        }

        if(Objects.equals(platformInfo.getApp_id(), platformAppId) && Objects.equals(platformInfo.getApp_secret(), platformAppSecret)) {
            //开始查询系统状态上报给平台
            statusReportVo = basicPlatformSystemStatusService.checkSysStatus(platformAppId, platformAppSecret, servletContext);
        }
        return statusReportVo;
    }

    @Async
    void syncDept(String basicPlatformAccessToken, Date syncDate) throws Exception {
        Integer pageNumber = PlatformConstants.SYNC_PAGE_DEFAULT;
        Integer pageSize = PlatformConstants.SYNC_ROWS_DEFAULT;
        Integer total = basicPlatformInteractionService.syncSaveDepartments(basicPlatformSyncService
                , departmentService
                , basicPlatformAccessToken
                , syncDate
                , pageNumber
                , pageSize);
        while ( total <= pageNumber * pageSize) {
            total = basicPlatformInteractionService.syncSaveDepartments(basicPlatformSyncService
                    , departmentService
                    , basicPlatformAccessToken
                    , syncDate
                    , pageNumber ++
                    , pageSize ++);

        }
    }

    @Async
    void syncUser(String basicPlatformAccessToken, Date syncDate) throws Exception {
        Integer pageNumber = PlatformConstants.SYNC_PAGE_DEFAULT;
        Integer pageSize = PlatformConstants.SYNC_ROWS_DEFAULT;
        Integer total = basicPlatformInteractionService.syncSaveUsers(basicPlatformSyncService
                , userService
                , basicPlatformAccessToken
                , syncDate
                , pageNumber
                , pageSize);
        while ( total <= pageNumber * pageSize) {
            total = basicPlatformInteractionService.syncSaveUsers(basicPlatformSyncService
                    , userService
                    , basicPlatformAccessToken
                    , syncDate
                    , pageNumber
                    , pageSize);

        }
    }
}
