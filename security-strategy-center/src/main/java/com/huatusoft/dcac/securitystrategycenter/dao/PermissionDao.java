/**
 * @author yhj
 * @date 2019-10-15
 */
package com.huatusoft.dcac.securitystrategycenter.dao;

import com.huatusoft.dcac.base.dao.BaseDao;

import com.huatusoft.dcac.organizationalstrucure.entity.PermissionEntity;

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
