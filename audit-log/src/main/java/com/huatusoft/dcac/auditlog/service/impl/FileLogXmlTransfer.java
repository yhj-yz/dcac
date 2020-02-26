/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.auditlog.service.impl;

import com.huatusoft.dcac.auditlog.entity.FileLogEntity;
import com.huatusoft.dcac.common.constant.LockConstants;
import com.huatusoft.dcac.common.exception.DataStoreReadException;
import com.huatusoft.dcac.common.vo.FileLogXmlVO;
import com.huatusoft.dcac.common.xml.LogXmlDataReader;
import com.huatusoft.dcac.auditlog.dao.FileLogDao;
import com.huatusoft.dcac.organizationalstrucure.dao.UserDao;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncResult;
import org.springframework.stereotype.Service;
import org.w3c.dom.Document;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;
import java.util.concurrent.locks.ReentrantLock;

@Service
public class FileLogXmlTransfer {
    private static final ReentrantLock LOCK = LockConstants.IMPORT_LOCK;

    @Autowired
    private UserDao userDao;

    @Autowired
    private FileLogDao fileLogDao;

    private LogXmlDataReader<FileLogXmlVO> filelogStore=new LogXmlDataReader<FileLogXmlVO>();


    public boolean readAndAccountExists(Document document) throws Exception {
        boolean valid = false;
        filelogStore.init(FileLogXmlVO.class);
        filelogStore.initDom(document);
        List<FileLogXmlVO> fileLogs = filelogStore.getNodesAndExecOnlyOne(filelogStore);
        if (! filelogStore.valid() || fileLogs.isEmpty()) {
            throw new DataStoreReadException("数据格式不正确:没有数据");
        }
        List<String> accounts = new ArrayList<String>();
        for(FileLogXmlVO fileLogXmlVo:fileLogs){
            String account = fileLogXmlVo.getUserAccount();
            if (StringUtils.isBlank(account)) {
                throw new DataStoreReadException(String.format("数据格式不正确:用户账号为空"));
            }
            accounts.add(account);
        }
        long count = userDao.countByAccountIn(accounts);
        valid = count > 0;

        System.out.println("检查完毕" + count);

        return valid;
    }

    @Async
    public Future<Integer> readAndExec(Document document) throws Exception {
        filelogStore.init(FileLogXmlVO.class);
        filelogStore.initDom(document);
        Integer importCount=0;

        Integer Num = filelogStore.getNodesAndExecLength(filelogStore);

        Integer lengthNum = Num/40000;
        Integer otherNum = Num%40000;
        System.out.println(lengthNum);
        System.out.println(otherNum);
        for (int i = 0; i <= lengthNum; i++) {
            int loadindex = i*40000 ;
            int length = (i+1)*40000;
            if(i==lengthNum){
                length = loadindex + otherNum;
            }
            List<FileLogXmlVO> fileLogVOs = new ArrayList<FileLogXmlVO>();
            fileLogVOs = filelogStore.getNodesAndExec(filelogStore,loadindex,length);

            validLogs(fileLogVOs);

            if (LOCK.tryLock(LockConstants.IMPORT_WAIT_SECOND, TimeUnit.SECONDS)) {
                try {
                    importCount+=exec(fileLogVOs);
                } finally {
                    LOCK.unlock();
                }
            }
        }

        return new AsyncResult<Integer>(importCount);
    }

    private void validLogs(List<FileLogXmlVO> fileLogVOs) throws DataStoreReadException {
        if (fileLogVOs == null) {
            return;
        }
        Set<String> filelogStr = new HashSet<String>();
        //检查待导入的xml文件中，日志是否自重复
        for (FileLogXmlVO vo : fileLogVOs) {
            String logStr=vo.getGuid();
            if (filelogStr.contains(logStr)) {
                throw new DataStoreReadException(String.format("日志（ %s ）自重复", logStr));
            }
            filelogStr.add(logStr);
        }
    }

    private Integer exec(List<FileLogXmlVO> fileLogVOs) throws ParseException {
        Integer importCount=0;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        for(FileLogXmlVO logVO:fileLogVOs){
            long count = fileLogDao.countByGuidLike(logVO.getGuid());
            if(count>0){
                continue;
            }
            FileLogEntity log=new FileLogEntity();
            log.setGuid(logVO.getGuid());
            log.setUserAccount(logVO.getUserAccount());
            log.setUserName(logVO.getUserName());
            log.setIp(logVO.getIpAddress());
            log.setIsImport(1);
            log.setOperateTime(sdf.parse(logVO.getCreateDate()));
            log.setDcoName(logVO.getDocName());
            log.setDeviceName(logVO.getDeviceName());
            log.setOperationType(FileLogEntity.OperationType.valueOf(logVO.getOperationType()));
            log.setFileServerPath(logVO.getFileServerPath());
            log.setFileTime(logVO.getFileTime());
            fileLogDao.add(log);
            importCount++;
        }
        System.out.println("导入完成 importCount = " + importCount);
        return importCount;
    }

}
