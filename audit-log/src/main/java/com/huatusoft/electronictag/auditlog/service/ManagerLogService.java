package com.huatusoft.electronictag.auditlog.service;

import com.huatusoft.electronictag.auditlog.entity.ManagerLogEntity;
import com.huatusoft.electronictag.base.service.BaseService;
import com.huatusoft.electronictag.auditlog.dao.ManagerLogDao;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;


/**
 * @author WangShun
 */
public interface ManagerLogService extends BaseService<ManagerLogEntity, ManagerLogDao> {

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
