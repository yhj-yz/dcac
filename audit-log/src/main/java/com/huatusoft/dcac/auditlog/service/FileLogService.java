/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.auditlog.service;

import com.huatusoft.dcac.auditlog.entity.FileLogEntity;
import com.huatusoft.dcac.auditlog.entity.FileOperInfo;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.auditlog.dao.FileLogDao;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;

public interface FileLogService extends BaseService<FileLogEntity, FileLogDao>{

    /**
     * 分页查询
     * @param pageable
     * @param fileName
     * @param fileSize
     * @param fileMD5
     * @param classifyName
     * @param gradeName
     * @param time
     * @param userAccount
     * @param department
     * @param ipAddress
     * @param equipName
     * @param filePath
     * @param responseType
     * @param strategyName
     * @return
     */
    Page<FileLogEntity> findAll(Pageable pageable, String fileName,String fileSize,String fileMD5,String classifyName,String gradeName,String time,String userAccount,String department,String ipAddress,String equipName,String filePath,String responseType,String strategyName);

    /**
     * 检验格式
     * @param file
     * @return
     */
    Message checkForm(MultipartFile file);

    /**
     * 导入日志
     * @param file
     * @return
     */
//    Message importLog(MultipartFile file);

    /**
     * 保存日志
     * @param paramEntities
     * @throws Exception
     */
    void save(List<FileOperInfo> paramEntities) throws Exception;
}
