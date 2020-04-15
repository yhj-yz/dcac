package com.huatusoft.dcac.strategymanager.dao;

import com.huatusoft.dcac.base.dao.BaseDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyMaskRuleEntity;

/**
 * @author yhj
 * @date 2020-4-3
 */
public interface StrategyMaskRuleDao extends BaseDao<StrategyMaskRuleEntity,String> {

    /**
     * 根据规则名称查找脱敏规则
     * @param ruleName
     * @return
     */
    StrategyMaskRuleEntity findByRuleName(String ruleName);
}
