package com.huatusoft.dcac.organizationalstrucure.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.organizationalstrucure.entity.DepartmentEntity;

import java.util.List;


/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/27 16:11
 */
public interface DepartmentDao extends BaseDao<DepartmentEntity, String> {

    /**
     * 根据父节点查询
     * @param parentId
     * @return
     */
    List<DepartmentEntity> findByParentId(String parentId);

    /**
     * 查询可用父节点
     * @param pid 父节点
     * @param disabledCode 不可用代码
     * @return
     */
    Long countByParentIdEqualsAndStatusIsNotIn(String pid, Integer... disabledCode);

    /**
     * 查询可用部门
     * @param parentId
     * @param disabledCode
     * @return
     */
    List<DepartmentEntity> findByParentIdAndStatusNotIn(String parentId,Integer... disabledCode);

    /**
     * 根据id删除根节点以及子节点
     * @param id1
     * @param id2
     */
    void deleteByIdOrParentId(String id1,String id2);
}
