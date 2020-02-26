package com.huatusoft.dcac.auditlog.service;

import com.huatusoft.dcac.auditlog.dao.ManagerLogDao;
import com.huatusoft.dcac.auditlog.entity.ManagerLogEntity;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;


/**
 * @author WangShun
 */
public interface ManagerLogService extends BaseService<ManagerLogEntity, ManagerLogDao> {

    /**
     * 分页查询
     * @param userAccount
     * @param userName
     * @param ip
     * @param operateTime
     * @param operationModel
     * @param operationType
     * @param operationContent
     * @param orderby
     * @return
     */
    Page<ManagerLogEntity> findAll(Pageable pageable, String userAccount, String userName, String ip, String operateTime, String operationModel, String operationType, String operationContent, String orderby);

    /**
     * 添加管理日志
     * @param managerLogEntity
     */
    void addManagerLog(ManagerLogEntity managerLogEntity);

    /**
     * 登陆失败的用户账号
     * @param userAccount
     */
    void addLoginFailLog(String userAccount);

    /**
     * 登陆成功的用户
     * @param user
     */
    void addLoginSuccessLog(UserEntity user);

}
