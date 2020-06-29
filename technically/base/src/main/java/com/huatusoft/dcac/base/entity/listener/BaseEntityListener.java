package com.huatusoft.dcac.base.entity.listener;

import com.huatusoft.dcac.base.entity.BaseEntity;
import com.huatusoft.dcac.common.bo.Principal;
import com.huatusoft.dcac.common.constant.SystemConstants;
import org.apache.shiro.SecurityUtils;

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
            if(SecurityUtils.getSubject().getPrincipal() != null){
                entity.setCreateUserAccount(((Principal)SecurityUtils.getSubject().getPrincipal()).getAccount());
            }
        }
        if (Objects.isNull(entity.getCreateDateTime())) {
            entity.setCreateDateTime(new Date());
        }
    }

    @PreUpdate
    private void preUpdateAddModifyDateTimeAndModifyUserAccount(BaseEntity entity) {
        if (Objects.isNull(entity.getUpdateUserAccount())) {
            if(SecurityUtils.getSubject().getPrincipal() != null) {
                entity.setUpdateUserAccount(((Principal) SecurityUtils.getSubject().getPrincipal()).getAccount());
            }
        }
        if (Objects.isNull(entity.getUpdateDateTime())) {
            entity.setUpdateDateTime(new Date());
        }
    }
}
