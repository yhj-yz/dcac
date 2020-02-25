package com.huatusoft.electronictag.base.entity.listener;

import com.huatusoft.electronictag.base.entity.BaseEntity;
import com.huatusoft.electronictag.common.constant.SystemConstants;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.session.Session;

import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import java.util.Date;
import java.util.Objects;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/7 23:24
 */
public class BaseEntityListener {

    @PrePersist
    private void prePersistAddCreateTimeAndCreateUserAccount(BaseEntity entity) {

        if (Objects.isNull(entity.getCreateUserAccount())) {
            entity.setCreateUserAccount(String.valueOf(SecurityUtils.getSubject().getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT)));
        }
        if (Objects.isNull(entity.getCreateDateTime())) {
            entity.setCreateDateTime(new Date());
        }
    }

    @PreUpdate
    private void preUpdateAddModifyDateTimeAndModifyUserAccount(BaseEntity entity) {
        if (Objects.isNull(entity.getUpdateUserAccount())) {
            entity.setUpdateUserAccount(String.valueOf(SecurityUtils.getSubject().getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_ACCOUNT)));
        }
        if (Objects.isNull(entity.getUpdateDateTime())) {
            entity.setUpdateDateTime(new Date());
        }
    }
}
