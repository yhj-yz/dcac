/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.electronictag.auditlog.controller;

import com.huatusoft.electronictag.auditlog.entity.FileLogEntity;
import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.common.bo.Message;
import com.huatusoft.electronictag.common.bo.PageVo;
import com.huatusoft.electronictag.common.bo.PageableVo;
import com.huatusoft.electronictag.auditlog.service.FileLogService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

@Controller("fileLogController")
@RequestMapping("admin/fileLog")
public class FileLogController extends BaseController{
    @Autowired
    private FileLogService fileLogService;

    /**
     * 跳转到文件操作日志界面
     * @return
     */
    @GetMapping(value="list")
    public String list(){
        return "/log/fileLog/list.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param userAccount
     * @param userName
     * @param ip
     * @param createDate
     * @param operationType
     * @param deviceName
     * @param docName
     * @param operateTime
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<FileLogEntity> search(Integer pageSize, Integer pageNumber, String userAccount, String userName, String ip, String createDate, String operationType, String deviceName, String docName, String operateTime) {
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<FileLogEntity> page = fileLogService.findAll(pageable,userAccount,userName,ip,createDate,operationType,deviceName,docName,operateTime);
        return new PageVo<FileLogEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 检验文件格式
     * @param file
     * @return
     */
    @PostMapping(value = "/import_file_log_check")
    @ResponseBody
    public Message importManagerLogCheck(MultipartFile file) {
        if(file == null){
            return new Message(Message.Type.error,"请上传文件");
        }else {
            return fileLogService.checkForm(file);
        }
    }

    /**
     * 导入日志
     * @param file
     * @return
     */
//    @PostMapping(value = "/import_file_log")
//    @ResponseBody
//    public Message importManagerLog(MultipartFile file) {
//       if(file == null){
//           return  new Message(Message.Type.error,"请上传文件");
//       }else {
//           return fileLogService.importLog(file);
//       }
//    }

}
