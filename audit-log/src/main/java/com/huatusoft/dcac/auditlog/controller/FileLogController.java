/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.auditlog.controller;

import com.huatusoft.dcac.auditlog.entity.FileLogEntity;
import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.auditlog.service.FileLogService;
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

import java.util.Date;
import java.util.UUID;

@Controller("fileLogController")
@RequestMapping("admin/fileLog")
public class FileLogController extends BaseController{
    @Autowired
    private FileLogService fileLogService;

    /**
     * 跳转到文件操作日志界面
     * @return
     */
    @GetMapping(value="/list")
    public String list(){
        return "/log/fileLog/list.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param userAccount
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<FileLogEntity> search(Integer pageSize, Integer pageNumber, String fileName,String fileSize,String fileMD5,String classifyName,String gradeName,String time,String userAccount,String department,String ipAddress,String equipName,String filePath,String responseType,String strategyName) {
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<FileLogEntity> page = fileLogService.findAll(pageable,fileName,fileSize,fileMD5,classifyName,gradeName,time,userAccount,department,ipAddress,equipName,filePath,responseType,strategyName);
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
     * 根据id获取文件日志信息
     * @param id
     * @return
     */
    @GetMapping(value = "/getFileLog")
    @ResponseBody
    public FileLogEntity getFileLog(String id){
        if(id == null || "".equals(id)){
            return null;
        }
        return fileLogService.find(id);
    }

    /**
     * 导入日志
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

    @PostMapping(value = "/insert1000")
    @ResponseBody
    public Result addInsert1000(){
        for(int i = 0;i < 1000; i++){
            FileLogEntity fileLogEntity = new FileLogEntity();
            fileLogEntity.setComputerName("电脑"+i);
            fileLogEntity.setUserAccount("sysadmin");
            fileLogEntity.setUserName("sysadmin");
            fileLogEntity.setDepartment("部门"+i);
            fileLogEntity.setFileMD5(UUID.randomUUID().toString().replace("-",""));
            fileLogEntity.setFileName("c:\\test\\文件"+i+".doc");
            fileLogEntity.setFileOper(0);
            fileLogEntity.setFileSize(i);
            fileLogEntity.setHits(i);
            fileLogEntity.setLoginName("sysadmin");
            fileLogEntity.setTime(new Date().toString());
            fileLogEntity.setIp("123."+i);
            fileLogEntity.setIsImport(0);
            fileLogEntity.setOperateTime(new Date());
            fileLogEntity.setCreateDateTime(new Date());
            fileLogEntity.setCreateUserAccount("sysadmin");
            fileLogEntity.setUpdateDateTime(new Date());
            fileLogEntity.setUpdateUserAccount("sysadmin");
            fileLogService.add(fileLogEntity);
        }
        return new Result("200","插入成功",null);
    }

}
