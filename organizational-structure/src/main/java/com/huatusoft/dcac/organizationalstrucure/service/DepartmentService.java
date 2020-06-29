package com.huatusoft.dcac.organizationalstrucure.service;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.common.bo.Tree;
import com.huatusoft.dcac.organizationalstrucure.base.OrganizationalStructureService;
import com.huatusoft.dcac.organizationalstrucure.dao.DepartmentDao;
import com.huatusoft.dcac.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.PermissionEntity;

import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 10:15
 */
public interface DepartmentService extends BaseService<DepartmentEntity, DepartmentDao>, OrganizationalStructureService {

    /**
     * 查询所有可用用户
     * @param id
     * @return
     */
    List<DepartmentEntity> findAllAvailable(String id);

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

    /**
     * 新增部门
     * @param departmentName
     * @param departmentDesc
     * @return
     */
    Result addDepartment(String departmentName,String departmentDesc,String departmentId);

    /**
     * 更新部门
     * @param departmentName
     * @param departmentDesc
     * @param departmentId
     * @return
     */
    Result updateDepartment(String departmentName,String departmentDesc,String departmentId);

    /**
     * 根据id删除节点
     * @param id
     * @return
     */
    Result deleteById(String id);
}
