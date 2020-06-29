/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.auditlog.controller;

import com.huatusoft.dcac.auditlog.entity.FileLog;
import com.huatusoft.dcac.auditlog.entity.FileLogEntity;
import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.auditlog.service.FileLogService;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
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

import java.util.*;

@Controller("fileLogController")
@RequestMapping("admin/fileLog")
public class FileLogController extends BaseController{
    @Autowired
    private FileLogService fileLogService;

    @Autowired
    private UserService userService;

    /**
     * 跳转到文件操作日志界面
     * @return
     */
    @GetMapping(value="/list")
    public String list(){
        return "/log/fileLog/list.ftl";
    }

    /**
     * 外部跳转到文件操作日志界面
     * @param userNo
     * @return
     */
    @GetMapping(value = "/list1")
    public String list(String userNo) {
        if(userNo == null){
            return "";
        }
        return userService.visitByOut("/log/fileLog/list.ftl",userNo);
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
         List<String> computerList = new ArrayList<String>();
         for(int i = 0 ; i < 100; i++){
             computerList.add("电脑"+i);
         }
         List<String> userList = new ArrayList<String>();
         for(int i = 0 ; i < 80; i++){
             userList.add("用户"+i);
         }
         List<String> departmentList = new ArrayList<String>();
         for(int i = 0 ; i < 10; i++){
             departmentList.add("部门"+i);
         }
         List<String> md5List = new ArrayList<String>();
         for(int i = 0 ; i < 300; i++){
             md5List.add(UUID.randomUUID().toString().replace("-",""));
         }
         List<FileLog> fileLogList = new ArrayList<FileLog>();
         for(int i = 0; i< 1000; i++){
             FileLog fileLog = new FileLog();
             fileLog.setFileName("文件"+i);
             fileLog.setFileMd5(md5List.get((int)(Math.random()*300)));
             fileLogList.add(fileLog);
         }
        for(int i = 0;i < 1000; i++){
            FileLogEntity fileLogEntity = new FileLogEntity();
            fileLogEntity.setComputerName(computerList.get((int)(Math.random()*100)));
            int userRandom = (int)(Math.random()*80);
            fileLogEntity.setUserAccount(userList.get(userRandom));
            fileLogEntity.setUserName(userList.get(userRandom));
            fileLogEntity.setDepartment(departmentList.get((int)(Math.random()*10)));
            fileLogEntity.setFileMD5(fileLogList.get(i).getFileMd5());
            fileLogEntity.setFileName(fileLogList.get(i).getFileName());
            fileLogEntity.setFileOper(0);
            fileLogEntity.setFileSize(i);
            fileLogEntity.setHits(i);
            fileLogEntity.setLoginName(userList.get(userRandom));
            fileLogEntity.setTime(new Date().toString());
            fileLogEntity.setIp("123."+i);
            fileLogEntity.setIsImport(0);
            fileLogEntity.setOperateTime(new Date());
            fileLogEntity.setCreateDateTime(new Date());
            fileLogEntity.setCreateUserAccount(userList.get(userRandom));
            fileLogEntity.setUpdateDateTime(new Date());
            fileLogEntity.setUpdateUserAccount(userList.get(userRandom));
            fileLogService.add(fileLogEntity);
        }
        return new Result("200","插入成功",null);
    }

}
