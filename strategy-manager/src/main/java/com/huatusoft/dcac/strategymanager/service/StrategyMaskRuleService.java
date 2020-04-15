package com.huatusoft.dcac.strategymanager.service;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.strategymanager.dao.StrategyMaskRuleDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyMaskRuleEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyRuleEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

/**
 * @author yhj
 * @date 2020-4-3
 */
public interface StrategyMaskRuleService extends BaseService<StrategyMaskRuleEntity, StrategyMaskRuleDao> {
    /**
     * 分页查询
     * @param pageable
     * @param ruleName
     * @param ruleType
     * @param maskType
     * @param maskEffect
     * @param createUserAccount
     * @param ruleDesc
     * @return
     */
    Page<StrategyMaskRuleEntity> findAllByPage(Pageable pageable, String ruleName,String ruleType,String maskType,String maskEffect,String createUserAccount, String ruleDesc);

    /**
     * 添加脱敏规则
     * @param ruleName
     * @param ruleDesc
     * @param ruleType
     * @param maskContent
     * @param maskType
     * @param maskEffect
     * @return
     */
    Result addRule(String ruleName,String ruleDesc,String ruleType,String maskContent,String maskType,String maskEffect);

    /**
     * 更新脱敏规则
     * @param id
     * @param ruleName
     * @param ruleDesc
     * @param ruleType
     * @param maskContent
     * @param maskType
     * @param maskEffect
     * @return
     */
    Result updateMaskRule(String ruleId,String ruleName,String ruleDesc,String ruleType,String maskContent,String maskType,String maskEffect);
}
