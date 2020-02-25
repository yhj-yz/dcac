package com.huatusoft.dcac.separateapproval.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.separateapproval.entity.WorkFlowEntity;

import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/29 10:07
 */
public interface WorkFlowDao extends BaseDao<WorkFlowEntity, String> {

    /**
     * 根据工作流名称查询
     * @param flowName 工作流名称
     * @return
     */
    WorkFlowEntity findByFlowName(String flowName);

    /**
     * 根据创建者查询流程
     * @param account 创建者账号
     * @return
     */
    List<WorkFlowEntity> findByCreateUserAccountEquals (String account);


}
