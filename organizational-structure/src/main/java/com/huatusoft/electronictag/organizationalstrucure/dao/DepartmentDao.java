package com.huatusoft.electronictag.organizationalstrucure.dao;

import com.huatusoft.electronictag.base.dao.BaseDao;
import com.huatusoft.electronictag.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import org.springframework.data.domain.Page;

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
    DepartmentEntity findByParentIdEquals(String parentId);

    /**
     * 查询可用父节点
     * @param pid 父节点
     * @param disabledCode 不可用代码
     * @return
     */
    Long countByParentIdEqualsAndStatusIsNotIn(String pid, Integer... disabledCode);

    /**
     * 查询所有状态可用的部门
     * @param disabledCode 禁用代码
     * @return
     */
    List<DepartmentEntity> findByStatusNotIn(Integer... disabledCode);


}
