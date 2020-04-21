package com.huatusoft.dcac.strategymanager.service;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseService;
import com.huatusoft.dcac.strategymanager.dao.StrategyRuleDao;
import com.huatusoft.dcac.strategymanager.entity.DataLevelRuleEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyRuleContentEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyRuleEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

/**
 * @author yhj
 * @date 2020-3-30
 */
public interface StrategyRuleService extends BaseService<StrategyRuleEntity, StrategyRuleDao> {

    /**
     * 分页查询
     * @param pageable
     * @param ruleName
     * @param createUserAccount
     * @param ruleDesc
     * @return
     */
    Page<StrategyRuleEntity> findAllByPage(Pageable pageable, String ruleName, String createUserAccount, String ruleDesc);

    /**
     * 添加策略规则
     * @param ruleName
     * @param ruleDesc
     * @param levelDefault
     * @param ruleScope01
     * @param ruleScope02
     * @param ruleScope03
     * @param scopeValue01
     * @param scopeValue02
     * @param scopeValue03
     * @param scopeValue04
     * @param scopeValue05
     * @param scopeValue06
     * @param scopeValue07
     * @param scopeValue08
     * @param scopeValue09
     * @param levelValue01
     * @param levelValue02
     * @param levelValue03
     * @param containRule
     * @param exceptRule
     * @return
     */
    Result addStrategyRule(String ruleName, String ruleDesc, String levelDefault, String ruleScope01, String ruleScope02, String ruleScope03, String scopeValue01, String scopeValue02, String scopeValue03, String scopeValue04, String scopeValue05, String scopeValue06, String scopeValue07, String scopeValue08, String scopeValue09, String levelValue01, String levelValue02, String levelValue03, String containRule, String exceptRule);

    /**
     * 添加数据严重程度规则
     * @param ruleScope
     * @param scopeValue01
     * @param scopeValue02
     * @param scopeValue03
     * @param levelValue
     * @param strategyRuleEntity
     */
    void addDataLevelRule(String ruleScope, String scopeValue01, String scopeValue02, String scopeValue03, String levelValue, List<DataLevelRuleEntity> dataLevelRuleEntities,StrategyRuleEntity strategyRuleEntity);

    /**
     * 添加规则内容
     * @param rule
     * @param isContain
     */
    void addRuleContent(String rule, boolean isContain,StrategyRuleEntity strategyRuleEntity);

    /**
     * 判断规则名称是否重复
     * @param ruleName
     * @return
     */
    boolean isRuleNameRepeat(String ruleName);

    /**
     * 更新检测规则
     * @param ruleId
     * @param ruleName
     * @param ruleDesc
     * @param levelDefault
     * @param ruleScope01
     * @param ruleScope02
     * @param ruleScope03
     * @param scopeValue01
     * @param scopeValue02
     * @param scopeValue03
     * @param scopeValue04
     * @param scopeValue05
     * @param scopeValue06
     * @param scopeValue07
     * @param scopeValue08
     * @param scopeValue09
     * @param levelValue01
     * @param levelValue02
     * @param levelValue03
     * @param containRule
     * @param exceptRule
     * @return
     */
    Result updateRule(String ruleId,String ruleName,String ruleDesc,String levelDefault,String ruleScope01,String ruleScope02,String ruleScope03,String scopeValue01,String scopeValue02,String scopeValue03,String scopeValue04,String scopeValue05,String scopeValue06,String scopeValue07,String scopeValue08,String scopeValue09,String levelValue01,String levelValue02,String levelValue03,String containRule,String exceptRule);

    /**
     * 删除检测规则
     * @param ids
     * @return
     */
    Result deleteRule(String[] ids);
}
