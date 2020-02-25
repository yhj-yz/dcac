package com.huatusoft.electronictag.organizationalstrucure.service;

import com.huatusoft.electronictag.base.service.BaseService;
import com.huatusoft.electronictag.common.bo.Message;
import com.huatusoft.electronictag.common.bo.Tree;
import com.huatusoft.electronictag.organizationalstrucure.base.OrganizationalStructureService;
import com.huatusoft.electronictag.organizationalstrucure.dao.DepartmentDao;
import com.huatusoft.electronictag.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.PermissionEntity;
import org.hibernate.event.spi.SaveOrUpdateEvent;

import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 10:15
 */
public interface DepartmentService extends BaseService<DepartmentEntity, DepartmentDao>, OrganizationalStructureService {

    /**
     * 根据父节点查询
     * @param parentId
     * @return
     */
    DepartmentEntity findByParentIdEquals(String parentId);


    /**
     * 查询所有可用用户
     * @return
     */
    List<DepartmentEntity> findAllAvailable();

    /**
     * 查询树
     * @param id
     * @return
     */
    List<Tree> findTree(String id);

    void saveOrUpdate(List<DepartmentEntity> departmentEntities);

    /**
     * 设置权限集
     * @param find
     * @param ids
     * @return
     */
    Message setUserPermission(PermissionEntity find, String[] ids);
}
