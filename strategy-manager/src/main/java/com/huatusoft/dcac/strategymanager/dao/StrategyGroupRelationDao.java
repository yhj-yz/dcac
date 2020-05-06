package com.huatusoft.dcac.strategymanager.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyGroup;
import com.huatusoft.dcac.strategymanager.entity.StrategyGroupEntity;

import java.util.List;

/**
 * @author yhj
 * @date 2020-4-20
 */
public interface StrategyGroupRelationDao extends BaseDao<StrategyGroup,String> {
    /**
     * 获取组策略和策略关联信息
     * @param strategyGroupEntity
     * @param strategyEntity
     * @return
     */
    StrategyGroup findByStrategyGroupEntityAndStrategyEntity(StrategyGroupEntity strategyGroupEntity, StrategyEntity strategyEntity);

    /**
     * 根据策略组以及优先级正序查找策略关联信息
     * @param strategyGroupEntity
     * @return
     */
    List<StrategyGroup> findByStrategyGroupEntityOrderByPriorityAsc(StrategyGroupEntity strategyGroupEntity);
}
