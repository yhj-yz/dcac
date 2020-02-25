package com.huatusoft.dcac.auditlog.service.impl;

import com.huatusoft.dcac.auditlog.entity.ManagerLogEntity;
import com.huatusoft.dcac.auditlog.service.ManagerLogService;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.auditlog.dao.ManagerLogDao;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Objects;
import java.util.UUID;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/29 11:52
 */
@Service
public class ManagerLogServiceImpl extends BaseServiceImpl<ManagerLogEntity, ManagerLogDao> implements ManagerLogService {

    @Autowired
    private UserService userService;

    @Override
    public void addManagerLog(ManagerLogEntity managerLogEntity) {
        super.dao.save(managerLogEntity);
    }

    @Override
    public void addLoginFailLog(String userAccount) {
        ManagerLogEntity managerLogEntity = new ManagerLogEntity();
        UserEntity loginUser = userService.getUserByAccount(userAccount);
        if (Objects.isNull(loginUser)) {
            managerLogEntity.setDescription("账号[" + userAccount + "]不存在");
            managerLogEntity.setOperationModel("登陆认证");
            managerLogEntity.setOperationType("登陆失败");
            managerLogEntity.setGuid(UUID.randomUUID().toString().replace("-", ""));
        }
        super.dao.save(managerLogEntity);
    }

    @Override
    public void addLoginSuccessLog(UserEntity user) {
        ManagerLogEntity managerLogEntity = new ManagerLogEntity();
        managerLogEntity.setGuid(UUID.randomUUID().toString().replace("-",""));
        managerLogEntity.setDescription("<账号:["+user.getAccount()+"], 身份:["+user.getRole().getDescription()+"]>成功登陆");
        managerLogEntity.setOperationType("登陆成功");
        managerLogEntity.setOperationModel("登陆认证");
        super.dao.save(managerLogEntity);
    }
}
