package com.huatusoft.dcac.strategymanager.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyRuleEntity;

/**
 * @author yhj
 * @date 2020-3-30
 */
public interface StrategyRuleDao extends BaseDao<StrategyRuleEntity,String> {

    /**
     * 根据规则名称查询策略
     * @param ruleName
     * @return
     */
    StrategyRuleEntity findByRuleName(String ruleName);
}
