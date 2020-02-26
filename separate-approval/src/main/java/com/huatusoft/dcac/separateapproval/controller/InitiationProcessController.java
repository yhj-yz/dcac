package com.huatusoft.dcac.separateapproval.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.common.constant.SystemConstants;
import com.huatusoft.dcac.common.util.FileDownloadUtils;
import com.huatusoft.dcac.common.util.JnaUtils;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.separateapproval.entity.WorkFlowEntity;
import com.huatusoft.dcac.separateapproval.entity.WorkTaskEntity;
import com.huatusoft.dcac.separateapproval.service.WorkFlowService;
import com.huatusoft.dcac.separateapproval.service.WorkTaskService;
import com.huatusoft.dcac.separateapproval.vo.WorkFlowVo;
import com.huatusoft.dcac.separateapproval.vo.WorkTaskVo;
import org.apache.commons.io.FileUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import java.io.*;
import java.util.*;


/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/29 15:55
 */
@Controller
@RequestMapping("/initiation_process")
public class InitiationProcessController extends BaseController {

    @Autowired
    private WorkFlowService workFlowService;

    @Autowired
    private WorkTaskService workTaskService;

    @GetMapping("/search")
    @ResponseBody
    public PageVo<WorkTaskEntity> search(PageableVo pageable
            , @RequestParam(value = "processName", required = false) String processName
            , @RequestParam(value = "approveUser", required = false) String approveUser) {
        Page<WorkTaskEntity> WorkTaskEntityPage = workTaskService.findPageByCondition(pageable, processName, approveUser, String.valueOf(getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT)), null, null);
        return new PageVo<WorkTaskEntity>(WorkTaskEntityPage.getContent(), WorkTaskEntityPage.getTotalElements(), new PageableVo(pageable.getPageNumber(), pageable.getPageSize()));
    }

    @GetMapping("/show")
    public String toManagerFlow() {
        return "/approve/my_process/my_process_list.ftl";
    }

    @GetMapping("/add")
    public ModelAndView toAddProcessPage(ModelAndView mv) {
        mv.setViewName("/approve/my_process/my_process_Add.ftl");
        List<WorkFlowVo> flowVoList = new ArrayList<>();
        for (WorkFlowEntity workFlowEntity : workFlowService.findWorkFlowByCreateAccount(String.valueOf(getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT)))) {
            flowVoList.add(new WorkFlowVo(workFlowEntity.getId(), workFlowEntity.getFlowName()));
        }
        mv.addObject("roles", flowVoList);
        return mv;
    }

    @PostMapping("/save")
    public String save(@RequestParam("file") MultipartFile file, WorkTaskVo workTaskVo) throws IOException {
        String filePath = null;
        final String OS_NAME = String.valueOf(super.applicationContext.getEnvironment().getProperty("os.name"));
        if (OS_NAME.contains(SystemConstants.OS_NAME_LINUX)) {
            filePath = this.fileCopy(file, SystemConstants.LINUX_TAG_UPLOAD_PATH);
            //判断不是标签文件
            if (!Objects.equals(SystemConstants.JNA_TAG_FILE, JnaUtils.ElectronicTagLibrary.electronicTagLibrary.IsLabelFile(filePath))) {
                FileUtils.forceDelete(new File(filePath));
                return "/approve/my_process/my_process_list.ftl";
            }
            WorkTaskEntity workTask = new WorkTaskEntity(workTaskVo.getProcessName(), workTaskVo.getApplyReason(), filePath, workFlowService.find( workTaskVo.getFlowId()), SystemConstants.UNPROCESSED);
            workTaskService.add(workTask);
        }
        if (OS_NAME.contains(SystemConstants.OS_NAME_WINDOWS)) {
            filePath = this.fileCopy(file, SystemConstants.WINDOWS_TAG_UPLOAD_PATH);
            WorkTaskEntity workTask = new WorkTaskEntity(workTaskVo.getProcessName(), workTaskVo.getApplyReason(), filePath, workFlowService.find(workTaskVo.getFlowId()), SystemConstants.UNPROCESSED);
            workTaskService.add(workTask);
        }

        return "/approve/my_process/my_process_list.ftl";
    }

    @GetMapping("/downloadFiles")
    @ResponseBody
    public void download(@RequestParam("id") String id) throws IOException {
        WorkTaskEntity workTaskEntity = workTaskService.find(id);
        if (Objects.isNull(workTaskEntity)) {
        }
        File file = new File(workTaskEntity.getDownloadPath());
        if (file.exists()) {
            FileDownloadUtils.download(getResponse(), file);
        }
    }

    @PostMapping("/delete")
    @ResponseBody
    public Result deleteTask(@RequestParam("id") String[] ids) {
        for (String id : ids) {
            WorkTaskEntity workTaskEntity = workTaskService.find( id);
            if (Objects.nonNull(workTaskEntity)) {
                File uploadFile = new File(workTaskEntity.getUploadFilePath());
                File downloadFile = new File(String.valueOf(workTaskEntity.getDownloadPath()));
                if (uploadFile.exists()) {
                    uploadFile.delete();
                }
                if (downloadFile.exists()) {
                    downloadFile.delete();
                }
            }
            workTaskService.delete(WorkTaskEntity.class, ids);
        }
        return Result.build("删除成功");
    }

    private String fileCopy(MultipartFile file, String path) throws IOException {
        String fileName = null;
        File destFile = FileUtils.getFile(path);
        if (!destFile.exists()) {
            destFile.mkdirs();
        }
        UserEntity user = (UserEntity) getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_KEY);
        fileName = user.getAccount() + DateFormatUtils.format(new Date(), SystemConstants.DATE_TIME_PATTERN_FILE_NAME) + file.getOriginalFilename();
        file.transferTo(new File(path, fileName));
        return path + fileName;
    }

}
