package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.strategymanager.dao.StrategyMaskRuleDao;
import com.huatusoft.dcac.strategymanager.entity.StrategyMaskRuleEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyRuleEntity;
import com.huatusoft.dcac.strategymanager.service.StrategyMaskRuleService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.domain.Specification;
import org.springframework.stereotype.Service;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Predicate;
import javax.persistence.criteria.Root;
import java.util.ArrayList;
import java.util.List;

/**
 * @author yhj
 * @date 2020-4-3
 */
@Service
public class StrategyMaskRuleServiceImpl extends BaseServiceImpl<StrategyMaskRuleEntity, StrategyMaskRuleDao> implements StrategyMaskRuleService {

    @Autowired
    private StrategyMaskRuleDao strategyMaskRuleDao;

    @Override
    public Page<StrategyMaskRuleEntity> findAllByPage(Pageable pageable, String ruleName, String ruleType, String maskType, String maskEffect, String createUserAccount, String ruleDesc) {
        Specification<StrategyMaskRuleEntity> specification = new Specification<StrategyMaskRuleEntity>() {
            @Override
            public Predicate toPredicate(Root<StrategyMaskRuleEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(ruleName)) {
                    predicates.add(criteriaBuilder.like(root.get("ruleName").as(String.class), "%" + ruleName + "%"));
                }
                if (StringUtils.isNotBlank(ruleType)) {
                    predicates.add(criteriaBuilder.like(root.get("ruleType").as(String.class), "%" + ruleType + "%"));
                }
                if (StringUtils.isNotBlank(maskType)) {
                    predicates.add(criteriaBuilder.like(root.get("maskType").as(String.class), "%" + maskType + "%"));
                }
                if (StringUtils.isNotBlank(maskEffect)) {
                    predicates.add(criteriaBuilder.like(root.get("maskEffect").as(String.class), "%" + maskEffect + "%"));
                }
                if (StringUtils.isNotBlank(createUserAccount)) {
                    predicates.add(criteriaBuilder.like(root.get("createUserAccount").as(String.class), "%" + createUserAccount + "%"));
                }
                if (StringUtils.isNotBlank(ruleDesc)) {
                    predicates.add(criteriaBuilder.like(root.get("ruleDesc").as(String.class), "%" + ruleDesc + "%"));
                }
                return criteriaBuilder.and(predicates.toArray(new Predicate[predicates.size()]));
            }
        };
        return findAllPageByCondition(specification, pageable);
    }

    @Override
    public Result addRule(String ruleName, String ruleDesc, String ruleType, String maskContent, String maskType, String maskEffect) {
        try {
            StrategyMaskRuleEntity strategyMaskRuleEntity = new StrategyMaskRuleEntity();
            strategyMaskRuleEntity.setRuleName(ruleName);
            strategyMaskRuleEntity.setRuleDesc(ruleDesc);
            strategyMaskRuleEntity.setRuleTypeCode(ruleType);
            strategyMaskRuleEntity.setMaskContent(maskContent);
            strategyMaskRuleEntity.setMaskTypeCode(maskType);
            strategyMaskRuleEntity.setMaskEffect(maskEffect);
            strategyMaskRuleDao.add(strategyMaskRuleEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("数据库异常,请稍后再试!");
        }
        return new Result("200","新增脱敏规则成功!",null);
    }

    @Override
    public Result updateMaskRule(String ruleId, String ruleName, String ruleDesc, String ruleType, String maskContent, String maskType, String maskEffect) {
        try {
            StrategyMaskRuleEntity strategyMaskRuleEntity = strategyMaskRuleDao.find(ruleId);
            strategyMaskRuleEntity.setRuleName(ruleName);
            strategyMaskRuleEntity.setRuleDesc(ruleDesc);
            strategyMaskRuleEntity.setRuleTypeCode(ruleType);
            strategyMaskRuleEntity.setMaskContent(maskContent);
            strategyMaskRuleEntity.setMaskTypeCode(maskType);
            strategyMaskRuleEntity.setMaskEffect(maskEffect);
            strategyMaskRuleDao.update(strategyMaskRuleEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("修改脱敏规则失败!");
        }
        return new Result("200","修改脱敏规则成功!",null);
    }
}
