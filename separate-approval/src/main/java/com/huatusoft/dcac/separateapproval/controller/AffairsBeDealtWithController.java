package com.huatusoft.dcac.separateapproval.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.common.constant.SystemConstants;
import com.huatusoft.dcac.common.util.JnaUtils;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.separateapproval.entity.WorkTaskEntity;
import com.huatusoft.dcac.separateapproval.service.WorkTaskService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.Objects;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/31 15:23
 */
@Controller
@RequestMapping("/affairs_be_dealt_with")
public class AffairsBeDealtWithController extends BaseController {

    @Autowired
    private WorkTaskService workTaskService;

    @GetMapping("/show")
    public String toWaitList() {
        return "/approve/wait_process/list.ftl";
    }

    @GetMapping("/search")
    @ResponseBody
    public PageVo<WorkTaskEntity> search(PageableVo pageable
            , @RequestParam(value = "processName", required = false) String processName
            , @RequestParam(value = "applyTime", required = false) Date applyTime) {
        Page<WorkTaskEntity> WorkTaskEntityPage = workTaskService.findPageByCondition(pageable, processName, String.valueOf(getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT)), null,applyTime , SystemConstants.APPROVED, SystemConstants.NOT_YET_APPROVED);
        return new PageVo<WorkTaskEntity>(WorkTaskEntityPage.getContent(), WorkTaskEntityPage.getTotalElements(), new PageableVo(pageable.getPageNumber(), pageable.getPageSize()));
    }

    @GetMapping("/find/{id}")
    @ResponseBody
    public WorkTaskEntity findTask(@PathVariable("id") String id) {
        WorkTaskEntity workTaskEntity = workTaskService.find(id);
        return workTaskEntity;
    }

    @PostMapping("/approve")
    @ResponseBody
    public Result approveTask(@RequestParam("id") String id
            , @RequestParam("applyUser") String applyUserAccount
            , @RequestParam("approveState") Integer approveState
            , @RequestParam("advice") String advice) throws IOException {
        WorkTaskEntity workTaskEntity = workTaskService.find( id);
        if (Objects.isNull(workTaskEntity)) {
            //找不到审批请求信息
            return Result.build("失败");
        }
        if (!Objects.equals(String.valueOf(getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT)), workTaskEntity.getWorkFlow().getApproveAccount())) {
            //审批失败非法请求
            return Result.build("失败");
        }
        String uploadFilePath = workTaskEntity.getUploadFilePath();
        String downLoadPath = null;
        if (applicationContext.getEnvironment().getProperty("os.name").contains(SystemConstants.OS_NAME_LINUX)) {
            downLoadPath = SystemConstants.LINUX_APPROVAL_STORAGE_PATH + uploadFilePath.substring(uploadFilePath.lastIndexOf("/") + 1);
            if (JnaUtils.ElectronicTagLibrary.electronicTagLibrary.RemoveFileLabelAttrS(uploadFilePath, downLoadPath, ((UserEntity) getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_KEY)).getUnitCode()) != 0) {
                //审批失败
                return Result.build("失败");
            }
        }
        if (applicationContext.getEnvironment().getProperty("os.name").contains(SystemConstants.OS_NAME_WINDOWS)) {
            downLoadPath = SystemConstants.WINDOWS_APPROVAL_STORAGE_PATH + uploadFilePath.substring(uploadFilePath.lastIndexOf("\\") + 1);
            FileUtils.copyFile( new File(workTaskEntity.getUploadFilePath()),new File(downLoadPath));
        }
        if (approveState == 0) {
            workTaskEntity.setStatus(SystemConstants.APPROVED);
        } else {
            workTaskEntity.setStatus(SystemConstants.NOT_YET_APPROVED);
        }
        workTaskEntity.setCause(advice);
        workTaskEntity.setDownloadPath(downLoadPath);
        workTaskService.update(workTaskEntity);
        return Result.build("成功");
    }
}
