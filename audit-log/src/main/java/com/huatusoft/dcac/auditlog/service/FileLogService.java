/**
 * @author yhj
 * @date 2019-10-23
 */
package com.huatusoft.dcac.auditlog.service;

import com.huatusoft.dcac.auditlog.entity.FileLogEntity;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.auditlog.dao.FileLogDao;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

public interface FileLogService extends BaseService<FileLogEntity, FileLogDao>{
    /**
     * 分页查询
     * @param pageable
     * @param userAccount
     * @param userName
     * @param ip
     * @param operationType
     * @param deviceName
     * @param docName
     * @param operateTime
     * @return
     */
    Page<FileLogEntity> findAll(Pageable pageable, String userAccount, String userName, String ip, String operationType, String deviceName, String docName, String operateTime);

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
}
