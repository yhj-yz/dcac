/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.auditlog.service.impl;

import com.huatusoft.dcac.auditlog.dao.FileLogDao;
import com.huatusoft.dcac.auditlog.entity.FileLogEntity;
import com.huatusoft.dcac.auditlog.entity.FileOperInfo;
import com.huatusoft.dcac.auditlog.service.FileLogService;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.common.constant.KeytConstants;
import com.huatusoft.dcac.common.exception.DataStoreReadException;
import com.huatusoft.dcac.common.util.ExceptionUtils;
import com.huatusoft.dcac.common.util.XmlUtils;
import com.huatusoft.dcac.common.xml.XmlDataReaderHelper;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import com.huatusoft.dcac.strategymanager.dao.DataClassifySmallDao;
import com.huatusoft.dcac.strategymanager.dao.DataGradeDao;
import com.huatusoft.dcac.strategymanager.dao.StrategyDao;
import com.huatusoft.dcac.strategymanager.entity.DataClassifySmallEntity;
import com.huatusoft.dcac.strategymanager.entity.DataGradeEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.time.DateUtils;
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
import java.util.UUID;

@Service
public class FileLogServiceImpl extends BaseServiceImpl<FileLogEntity, FileLogDao> implements FileLogService {
    private static final Logger LOGGER = LoggerFactory.getLogger(FileLogServiceImpl.class);
    @Autowired
    private UserService userService;

    @Autowired
    private FileLogXmlTransfer fileLogXmlTransfer;

    @Autowired
    private FileLogDao fileLogDao;

    @Autowired
    private DataClassifySmallDao dataClassifySmallDao;

    @Autowired
    private DataGradeDao dataGradeDao;

    @Autowired
    private StrategyDao strategyDao;

    @Override
    public Page<FileLogEntity> findAll(Pageable pageable, String fileName,String fileSize,String fileMD5,String classifyName,String gradeName,String time,String userAccount,String department,String ipAddress,String equipName,String filePath,String responseType,String strategyName) {
        Specification<FileLogEntity> specification = new Specification<FileLogEntity>() {
            @Override
            public Predicate toPredicate(Root<FileLogEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(fileName)) {
                    predicates.add(criteriaBuilder.like(root.get("fileName").as(String.class), "%" + fileName + "%"));
                }
                if (StringUtils.isNotBlank(fileSize)) {
                    predicates.add(criteriaBuilder.equal(root.get("fileSize").as(String.class),fileSize.substring(0,fileSize.length())));
                }
                if (StringUtils.isNotBlank(fileMD5)) {
                    predicates.add(criteriaBuilder.like(root.get("fileMD5").as(String.class), "%" + fileMD5 + "%"));
                }
                if (StringUtils.isNotBlank(classifyName)) {
                    DataClassifySmallEntity dataClassifySmallEntity = dataClassifySmallDao.findByClassifyName(classifyName);
                    if(dataClassifySmallEntity != null){
                        predicates.add(criteriaBuilder.like(root.get("dataType").as(String.class), "%" + dataClassifySmallEntity.getId() + "%"));
                    }else {
                        predicates.add(criteriaBuilder.like(root.get("dataType").as(String.class), "%中文%"));
                    }
                }
                if (StringUtils.isNotBlank(gradeName)) {
                    DataGradeEntity dataGradeEntity = dataGradeDao.findByGradeName(gradeName);
                    if(dataGradeEntity!= null){
                        predicates.add(criteriaBuilder.like(root.get("dataClassification").as(String.class), "%" + dataGradeEntity.getId() + "%"));
                    }else {
                        predicates.add(criteriaBuilder.like(root.get("dataClassification").as(String.class), "%中文%"));
                    }
                }
                if (StringUtils.isNotBlank(time)) {
                    String[] times = time.split("_");
                    DateFormat format = new SimpleDateFormat("yyyy-MM-dd");
                    Date startTime = null;
                    Date endTime = null;
                    try {
                        startTime = format.parse(times[0]);
                        endTime = format.parse(times[1]);
                    }catch (Exception e){
                        e.printStackTrace();
                        LOGGER.error("日期转换错误!");
                    }
                    predicates.add(criteriaBuilder.between(root.get("time").as(java.sql.Date.class),startTime,endTime));
                }
                if (StringUtils.isNotBlank(userAccount)) {
                    predicates.add(criteriaBuilder.like(root.get("userName").as(String.class), "%" + userAccount + "%"));
                }
                if (StringUtils.isNotBlank(department)) {
                    predicates.add(criteriaBuilder.like(root.get("department").as(String.class), "%" + department + "%"));
                }
                if (StringUtils.isNotBlank(equipName)) {
                    predicates.add(criteriaBuilder.like(root.get("computerName").as(String.class), "%" + equipName + "%"));
                }
                if (StringUtils.isNotBlank(ipAddress)) {
                    predicates.add(criteriaBuilder.like(root.get("ip").as(String.class), "%" + ipAddress + "%"));
                }
                if (StringUtils.isNotBlank(filePath)) {
                    predicates.add(criteriaBuilder.like(root.get("fileName").as(String.class), "%" + filePath + "%"));
                }
                if (StringUtils.isNotBlank(responseType)) {
                    String responseTypeCode = "中文";
                    if("发现审计".equals(responseType)){
                        responseTypeCode = "0";
                    }else if("内容脱敏".equals(responseType)){
                        responseTypeCode = "1";
                    }else if("文件加密".equals(responseType)){
                        responseTypeCode = "2";
                    }
                    predicates.add(criteriaBuilder.like(root.get("fileOper").as(String.class), "%" + responseTypeCode + "%"));
                }
                if (StringUtils.isNotBlank(strategyName)) {
                    StrategyEntity strategyEntity = strategyDao.findByStrategyName(strategyName);
                    if(strategyEntity != null){
                        predicates.add(criteriaBuilder.like(root.get("strategyId").as(String.class), "%" + strategyEntity.getId() + "%"));
                    }else {
                        predicates.add(criteriaBuilder.like(root.get("strategyId").as(String.class), "%中文%"));
                    }
                }
                criteriaQuery.where(predicates.toArray(new Predicate[predicates.size()]));
                criteriaQuery.orderBy(criteriaBuilder.desc(root.get("time").as(String.class)));
                return criteriaQuery.getRestriction();
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

    @Override
    public void save(List<FileOperInfo> paramEntities) throws Exception {
        try {
            for (FileOperInfo paramEntity : paramEntities) {

                FileLogEntity fileLog = new FileLogEntity();
                FileOperInfo paramEntityObj=paramEntity;
                fileLog.setIp(paramEntityObj.getFileIp());
                fileLog.setUserName(paramEntityObj.getFileUserName());
                fileLog.setUserAccount(paramEntityObj.getFileUserAccount());
                fileLog.setGuid(UUID.randomUUID().toString());
                fileLog.setOperateTime(DateUtils.parseDate(paramEntity.getFileTime()));
                fileLogDao.add(fileLog);
            }
        } catch (Exception e) {
            throw new Exception("日志上传错误!");
        }
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
