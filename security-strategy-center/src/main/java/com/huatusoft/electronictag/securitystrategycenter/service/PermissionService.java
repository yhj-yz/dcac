/**
 * @author yhj
 * @date 2019-10-15
 */
package com.huatusoft.electronictag.securitystrategycenter.service;

import com.huatusoft.electronictag.base.service.BaseService;
import com.huatusoft.electronictag.common.bo.Message;
import com.huatusoft.electronictag.organizationalstrucure.entity.PermissionEntity;
import com.huatusoft.electronictag.securitystrategycenter.dao.PermissionDao;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

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
