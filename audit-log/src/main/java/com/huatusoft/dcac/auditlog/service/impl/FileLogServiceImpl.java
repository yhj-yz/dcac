/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.auditlog.service.impl;

import com.huatusoft.dcac.auditlog.dao.FileLogDao;
import com.huatusoft.dcac.auditlog.entity.FileLogEntity;
import com.huatusoft.dcac.auditlog.service.FileLogService;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.common.constant.KeytConstants;
import com.huatusoft.dcac.common.exception.DataStoreReadException;
import com.huatusoft.dcac.common.util.ExceptionUtils;
import com.huatusoft.dcac.common.util.XmlUtils;
import com.huatusoft.dcac.common.xml.XmlDataReaderHelper;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.io.InputStream;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class FileLogServiceImpl extends BaseServiceImpl<FileLogEntity, FileLogDao> implements FileLogService {
    private static final Logger LOGGER = LoggerFactory.getLogger(FileLogServiceImpl.class);
    @Autowired
    private UserService userService;

    @Autowired
    private FileLogXmlTransfer fileLogXmlTransfer;

    @Override
    public Page<FileLogEntity> findAll(Pageable pageable, String userAccount, String userName, String ip, String operationType, String deviceName, String docName, String operateTime) {
        Specification<FileLogEntity> specification = new Specification<FileLogEntity>() {
            @Override
            public Predicate toPredicate(Root<FileLogEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(userAccount)) {
                    predicates.add(criteriaBuilder.like(root.get("userAccount").as(String.class), "%" + userAccount + "%"));
                }
                if (StringUtils.isNotBlank(userName)) {
                    predicates.add(criteriaBuilder.like(root.get("userName").as(String.class), "%" + userName + "%"));
                }
                if (StringUtils.isNotBlank(ip)) {
                    predicates.add(criteriaBuilder.like(root.get("ip").as(String.class), "%" + ip + "%"));
                }
                if (StringUtils.isNotBlank(operationType)) {
                    predicates.add(criteriaBuilder.like(root.get("operationType").as(String.class), "%" + operationType + "%"));
                }
                if (StringUtils.isNotBlank(deviceName)) {
                    predicates.add(criteriaBuilder.like(root.get("deviceName").as(String.class), "%" + deviceName + "%"));
                }
                if (StringUtils.isNotBlank(docName)) {
                    predicates.add(criteriaBuilder.like(root.get("docName").as(String.class), "%" + docName + "%"));
                }
                if (StringUtils.isNotBlank(operateTime)) {
                    String[] operationTime = operateTime.split("_");
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date startTime = null;
                    Date endTime = null;
                    try {
                        startTime = format.parse(operationTime[0]);
                        endTime = format.parse(operationTime[1]);
                    }catch (Exception e){
                        LOGGER.info("日期转换错误");
                        e.printStackTrace();
                    }
                    predicates.add(criteriaBuilder.between(root.get("operateTime"), startTime, endTime));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public Message checkForm(MultipartFile file) {
        Message message = null;
        try {
            String fileNameSuffix = FilenameUtils.getExtension(file.getOriginalFilename());
            if ("xml".equals(fileNameSuffix)) {
                InputStream inputStream= XmlUtils.encryptLocalFile(file, KeytConstants.FILE_LOG_KEY);
                XmlDataReaderHelper helper = new XmlDataReaderHelper();
                helper.initDom(inputStream);
                if (helper.isLog()) {
                    System.out.println("开始检查");
                    if(fileLogXmlTransfer.readAndAccountExists(helper.document()) == true){
                        message = new Message(Message.Type.success,"格式正确");
                    }else {
                        message = new Message(Message.Type.error,"格式错误");
                    }
                } else {
                    message = new Message(Message.Type.error,"文件无法识别");
                }
            } else if("log".equals(fileNameSuffix)){
                message = new Message(Message.Type.success,"格式正确");
            }
            else {
                message = new Message(Message.Type.error,"文件无法识别");
            }
        } catch (DataStoreReadException e) {
            String msg = "文件无法识别";
            if (e.getMessage() != null) {
                msg = ExceptionUtils.getMessageContent(e);
            }
            LOGGER.error(String.format("日志导入检查失败，原因是：%s", msg));
            message = new Message(Message.Type.error,msg);
        } catch (Exception e) {
            e.printStackTrace();
            LOGGER.error(String.format("日志导入检查失败，原因是：%s", ExceptionUtils.getCauseByContent(e)));
            message = new Message(Message.Type.error,"文件无法识别");
        }
        return message;
    }

//    @Override
//    public Message importLog(MultipartFile file) {
//        Message message = null;
//        System.out.println("导入开始");
//        try {
//            String fileNameSuffix = FilenameUtils.getExtension(file.getOriginalFilename());
//            Integer importCount = 0;
//            if ("xml".equals(fileNameSuffix)) {
//                InputStream inputStream=XmlUtils.encryptLocalFile(file,KeytConstants.FILE_LOG_KEY);
//                XmlDataReaderHelper helper = new XmlDataReaderHelper();
//                helper.initDom(inputStream);
//                if (helper.isLog()) {
//                    importCount = fileLogXmlTransfer.readAndExec(helper.document()).get();
//                } else {
//                    message = Message.error("文件无法识别");
//                }
//            } else if("log".equals(fileNameSuffix)){
//                String result = alarmService.readLog(file,isAlarm);
//                if("上传成功!" != result){
//                    message = Message.error(result);
//                    writeMessageToResponse(response, message);
//                    return;
//                }
//            }
//            else {
//                message = Message.error("文件无法识别");
//                writeMessageToResponse(response, message);
//                return;
//            }
//            addLog(String.format("从文件 %s 中导入 %d 条文件日志", file.getOriginalFilename(),importCount));
//            message = SUCCESS_MESSAGE;
//        } catch (DataStoreReadException e) {
//            String msg = "文件无法识别";
//            if (e.getMessage() != null) {
//                msg = ExceptionUtils.getMessageContent(e);
//            }
//            LOGGER.error(String.format("日志导入失败，原因是：%s", msg));
//            message = Message.error(msg);
//        } catch (Exception e) {
//            e.printStackTrace();
//            LOGGER.error(String.format("日志导入失败，原因是：%s", ExceptionUtils.getCauseByContent(e)));
//            message = Message.error("文件无法识别，导入失败");
//        }
//        try {
//            writeMessageToResponse(response, message);
//        } catch (IOException e) {
//            LOGGER.error(String.format("日志导入返回消息失败，原因是：%s", ExceptionUtils.getCauseByContent(e)));
//        }
//        return null;
//    }

//    public String readLog(MultipartFile file) {
//        try {
//            BufferedReader br = new BufferedReader(new InputStreamReader(file.getInputStream(),"UTF-8"));
//            String len = null;
//            while((len = br.readLine()) != null){
//                JSONObject jsonObject = JSONObject.parseObject(len);
//                DetachedClientLogEntity clientLogEntity = JSON.parseObject(len, DetachedClientLogEntity.class);
//                String account = jsonObject.getString("opeuser");//获取上传文件日志的用户
//                String opetime = jsonObject.getString("opetime");
//                UserEntity byAccount = userService.getUserByAccount(account);
//                if(byAccount == null){
//                    return "上传文件的用户名不匹配!";
//                }
//                 if("2".equals(clientLogEntity.getLogflag())){
//                    String logproc = clientLogEntity.getLogproc();
//                    boolean flag = false;
//                    List<NetworkProcessEntity> procs = networkProcessService.findAll();
//                    for (NetworkProcessEntity proc : procs) {
//                        if(proc.getProcessName().equals(logproc)) {
//                            flag = true;
//                        }
//                    }
//                    //查询进程名RF
//                    //文件操作日志
//                    FileLogEntity fileLog = new FileLogEntity();
//                    fileLog.setFileId(clientLogEntity.getFile_id());
//                    fileLog.setIp(clientLogEntity.getFile_ip() == null || "".equals(clientLogEntity.getFile_ip().trim()) ? "离线导入" : clientLogEntity.getFile_ip());
//                    fileLog.setDeviceName(clientLogEntity.getFile_computer());
//                    fileLog.setClientID(clientLogEntity.getFile_id());
//                    fileLog.setFileTime(opetime);
//                    fileLog.setUserName(byAccount.getName());
//                    fileLog.setFileUser(clientLogEntity.getFile_useraccount());
//                    fileLog.setUserAccount(account);
//                    fileLog.setDocName(clientLogEntity.getPath());
//                    if (flag && "1".equals(clientLogEntity.getLogreadflag()) ) {//网络发送
//                        fileLog.setOperationType(FileLogEntity.OperationType.sendNetFile);
//                    } else if (flag && "2".equals(clientLogEntity.getLogreadflag())) { //网络接受
//                        fileLog.setOperationType(FileLogEntity.OperationType.receiveNetFile);
//                    } else {
//                        String opetype= jsonObject.getString("opetype");
//                        FileLogEntity.OperationType oper = FileLogEntity.OperationType.valueOf(opetype);
//                        fileLog.setOperationType(oper);
//                    }
//                    fileLog.setGuid(UUID.randomUUID().toString());
//                    fileLog.setOperateTime(DateUtil.parseDateyyMMddHHmmss(opetime));
//                    String userName = UserUtil.getUserName();
//                    if(org.apache.commons.lang.StringUtils.isNotEmpty(userName)){
//                        fileLog.setCreateUserAccount(userName);
//                        fileLog.setModifyUserAccount(userName);
//                    }
//                    fileLogService.save(fileLog);
//                }else {
//                }
//            }
//            br.close();
//        } catch (FileNotFoundException e) {
//            e.printStackTrace();
//        } catch (IOException e) {
//            e.printStackTrace();
//        }
//        return "上传成功!";
//    }

}
