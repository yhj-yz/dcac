package com.huatusoft.electronictag.separateapproval.controller;

import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.common.bo.PageVo;
import com.huatusoft.electronictag.common.bo.PageableVo;
import com.huatusoft.electronictag.common.constant.SystemConstants;
import com.huatusoft.electronictag.common.util.FileDownloadUtils;
import com.huatusoft.electronictag.separateapproval.entity.WorkTaskEntity;
import com.huatusoft.electronictag.separateapproval.service.WorkTaskService;
import org.apache.commons.lang.StringUtils;
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
 * @date 2019/11/4 11:11
 */
@Controller
@RequestMapping("/already_done")
public class AlreadyDoneController extends BaseController {

    @Autowired
    private WorkTaskService workTaskService;

    @GetMapping("/show")
    public String toFinishList() {
        return "/approve/finish_process/list.ftl";
    }

    @GetMapping("/search")
    @ResponseBody
    public PageVo<WorkTaskEntity> search(PageableVo pageable
            , @RequestParam(value = "processName", required = false) String processName
            , @RequestParam(value = "applyTime", required = false) Date applyTime
            , @RequestParam(value = "applyUser", required = false) String applyUser) {
        Page<WorkTaskEntity> WorkTaskEntityPage = workTaskService.findPageByCondition(pageable, processName,String.valueOf(getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT)) , applyUser,applyTime,  SystemConstants.UNPROCESSED);
        return new PageVo<WorkTaskEntity>(WorkTaskEntityPage.getContent(), WorkTaskEntityPage.getTotalElements(), new PageableVo(pageable.getPageNumber(), pageable.getPageSize()));
    }

    @ResponseBody
    @GetMapping("/findTask/{id}")
    public WorkTaskEntity findTask(@PathVariable String id) {
        return workTaskService.find(id);
    }

    @ResponseBody
    @GetMapping("/downloadSrcFile")
    public void downloadSrcFile(@RequestParam("id") String id) throws IOException {
        WorkTaskEntity workTaskEntity = workTaskService.find( id);
        if (Objects.isNull(workTaskEntity)) {
            //查询不到任务流,下载失败
        }
        if (!StringUtils.equals(String.valueOf(getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT)),workTaskEntity.getWorkFlow().getApproveAccount()) ) {
            //审批人不上当前登陆用户, 非法下载
        }
        File file = new File(workTaskEntity.getUploadFilePath());
        if (file.exists()) {
            FileDownloadUtils.download(getResponse(), file);
        }
    }
}

