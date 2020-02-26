/**
 * @author yhj
 * @date 2019-10-15
 */
package com.huatusoft.dcac.securitystrategycenter.service;

import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.organizationalstrucure.entity.PermissionEntity;
import com.huatusoft.dcac.securitystrategycenter.dao.PermissionDao;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

public interface PermissionService extends BaseService<PermissionEntity, PermissionDao>{
    /**
     * 根据permissionName分页查询
     * @param pageable
     * @param permissionName
     * @return
     */
    Page<PermissionEntity> findAll(Pageable pageable,String permissionName);

    /**
     * 添加权限集
     * @param PermissionEntity
     * @return
     */
    Message addPermission(PermissionEntity PermissionEntity);

    /**
     * 删除权限集
     * @param ids
     * @return
     */
    Message delete(String... ids);
}
