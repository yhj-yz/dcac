package com.huatusoft.dcac.organizationalstrucure.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.organizationalstrucure.entity.RoleEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 10:33
 */
public interface RoleDao extends BaseDao<RoleEntity, String> {

    /**
     * 根据角色名获取角色
     * @param roleName
     * @return
     */
    RoleEntity findByName(String roleName);
}
