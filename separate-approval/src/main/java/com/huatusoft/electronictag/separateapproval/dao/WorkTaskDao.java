package com.huatusoft.electronictag.separateapproval.dao;

import com.huatusoft.electronictag.base.dao.BaseDao;
import com.huatusoft.electronictag.separateapproval.entity.WorkTaskEntity;

import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/30 15:59
 */
public interface WorkTaskDao extends BaseDao<WorkTaskEntity, String> {

    /**
     * 根据流程名称查询
     * @param processName 流程名称
     * @return 流程任务集合
     */
    List<WorkTaskEntity> findByProcessNameLike(String processName);

    /**
     * 根据流程名称精确查询
     * @param processName 流程名称
     * @return 流程任务集合
     */
    WorkTaskEntity findWorkTaskEntityByProcessNameEquals(String processName);
}
