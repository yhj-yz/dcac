/**
 * @author yhj
 * @date 2019-10-15
 */
package com.huatusoft.electronictag.securitystrategycenter.dao;

import com.huatusoft.electronictag.base.dao.BaseDao;

import com.huatusoft.electronictag.organizationalstrucure.entity.PermissionEntity;

import java.util.List;

public interface PermissionDao extends BaseDao<PermissionEntity,String>{
    /**
     * 根据权限名查询
     * @param permissionSetName
     * @return
     */
    PermissionEntity findAllByPermissionName(String permissionSetName);

    /**
     * 根据id查询
     * @param ids
     * @return
     */
    List<PermissionEntity> findAllByIdIn(String... ids);
}
