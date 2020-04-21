package com.huatusoft.dcac.strategymanager.service.impl;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.base.service.BaseServiceImpl;
import com.huatusoft.dcac.strategymanager.dao.DataLevelRuleDao;
import com.huatusoft.dcac.strategymanager.dao.StrategyRuleContentDao;
import com.huatusoft.dcac.strategymanager.dao.StrategyRuleDao;
import com.huatusoft.dcac.strategymanager.entity.*;
import com.huatusoft.dcac.strategymanager.service.StrategyRuleService;
import jdk.nashorn.internal.runtime.ECMAException;
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
 * @date 2020-3-30
 */
@Service
public class StrategyRuleServiceImpl extends BaseServiceImpl<StrategyRuleEntity, StrategyRuleDao> implements StrategyRuleService {

    @Autowired
    private StrategyRuleDao strategyRuleDao;

    @Autowired
    private DataLevelRuleDao dataLevelRuleDao;

    @Autowired
    private StrategyRuleContentDao strategyRuleContentDao;

    @Override
    public Page<StrategyRuleEntity> findAllByPage(Pageable pageable, String ruleName, String createUserAccount, String ruleDesc) {
        Specification<StrategyRuleEntity> specification = new Specification<StrategyRuleEntity>() {
            @Override
            public Predicate toPredicate(Root<StrategyRuleEntity> root, CriteriaQuery<?> criteriaQuery, CriteriaBuilder criteriaBuilder) {
                List<Predicate> predicates = new ArrayList<Predicate>();
                if (StringUtils.isNotBlank(ruleName)) {
                    predicates.add(criteriaBuilder.like(root.get("ruleName").as(String.class), "%" + ruleName + "%"));
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
    public Result addStrategyRule(String ruleName, String ruleDesc, String levelDefault, String ruleScope01, String ruleScope02, String ruleScope03, String scopeValue01, String scopeValue02, String scopeValue03, String scopeValue04, String scopeValue05, String scopeValue06, String scopeValue07, String scopeValue08, String scopeValue09, String levelValue01, String levelValue02, String levelValue03, String containRule, String exceptRule) {
        if("".equals(containRule)  && "".equals(exceptRule)){
            return new Result("请添加检测规则!");
        }
        if(isRuleNameRepeat(ruleName)){
            return new Result("检测规则名称已存在,请重新输入!");
        }
        try {
            StrategyRuleEntity strategyRuleEntity = new StrategyRuleEntity();
            strategyRuleEntity.setRuleName(ruleName);
            strategyRuleEntity.setRuleDesc(ruleDesc);
            strategyRuleEntity.setLevelDefaultCode(levelDefault);
            List<DataLevelRuleEntity> dataLevelEntities = new ArrayList<>();
            addDataLevelRule(ruleScope01,scopeValue01,scopeValue02,scopeValue03,levelValue01,dataLevelEntities,strategyRuleEntity);
            addDataLevelRule(ruleScope02,scopeValue04,scopeValue05,scopeValue06,levelValue02,dataLevelEntities,strategyRuleEntity);
            addDataLevelRule(ruleScope03,scopeValue07,scopeValue08,scopeValue09,levelValue03,dataLevelEntities,strategyRuleEntity);
            strategyRuleEntity.setDataLevelRuleEntities(dataLevelEntities);
            if(!"".equals(containRule)){
                addRuleContent(containRule,true,strategyRuleEntity);
            }
            if(!"".equals(exceptRule)){
                addRuleContent(exceptRule,false,strategyRuleEntity);
            }
            strategyRuleDao.add(strategyRuleEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("添加检测规则失败,请稍后再试!");
        }
        return new Result("200","添加检测规则成功!",null);
    }

    @Override
    public void addDataLevelRule(String ruleScope, String scopeValue01, String scopeValue02, String scopeValue03,String levelValue,List<DataLevelRuleEntity> dataLevelRuleEntities,StrategyRuleEntity strategyRuleEntity) {
        DataLevelRuleEntity dataLevelRuleEntity = new DataLevelRuleEntity();
        dataLevelRuleEntity.setRuleScopeCode(ruleScope);
        dataLevelRuleEntity.setLevelCode(levelValue);
        dataLevelRuleEntity.setStrategyRuleEntity(strategyRuleEntity);
        if("0".equals(ruleScope)){
            dataLevelRuleEntity.setRuleScopeValue(scopeValue01+","+scopeValue02);
        }else {
            dataLevelRuleEntity.setRuleScopeValue(scopeValue03);
        }
        dataLevelRuleEntities.add(dataLevelRuleEntity);
    }

    @Override
    public void addRuleContent(String rule, boolean isContain,StrategyRuleEntity strategyRuleEntity) {
        List<StrategyRuleContentEntity> strategyRuleContentEntities = new ArrayList<StrategyRuleContentEntity>();
        String[] rules = rule.split(";");
        for(String newRule : rules){
            String[] newRules = newRule.split(":");
            int index = newRules[1].trim().indexOf("\"");
            String ruleContent = newRules[1].trim().substring(index+1,newRules[1].trim().length()-1);
            StrategyRuleContentEntity strategyRuleContentEntity = new StrategyRuleContentEntity();
            strategyRuleContentEntity.setContain(isContain);
            strategyRuleContentEntity.setMatchContent(ruleContent);
            strategyRuleContentEntity.setRuleContent(ruleContent);
            strategyRuleContentEntity.setStrategyRuleEntity(strategyRuleEntity);
            if("隐私检测模板".equals(newRules[0].trim())){
                strategyRuleContentEntity.setRuleTypeCode("0");
            }else if("正则表达式".equals(newRules[0].trim())){
                strategyRuleContentEntity.setRuleTypeCode("1");
            }else if("关键字".equals(newRules[0].trim())){
                strategyRuleContentEntity.setRuleTypeCode("2");
            }
            strategyRuleContentEntities.add(strategyRuleContentEntity);
        }
        strategyRuleEntity.setStrategyRuleContentEntities(strategyRuleContentEntities);
    }

    @Override
    public boolean isRuleNameRepeat(String ruleName) {
        List<StrategyRuleEntity> strategyRuleEntity = strategyRuleDao.findAll();
        for(StrategyRuleEntity entity : strategyRuleEntity){
            if(entity.getRuleName().equals(ruleName)){
                return true;
            }
        }
        return false;
    }

    @Override
    public Result updateRule(String ruleId, String ruleName, String ruleDesc, String levelDefault, String ruleScope01, String ruleScope02, String ruleScope03, String scopeValue01, String scopeValue02, String scopeValue03, String scopeValue04, String scopeValue05, String scopeValue06, String scopeValue07, String scopeValue08, String scopeValue09, String levelValue01, String levelValue02, String levelValue03, String containRule, String exceptRule) {
        if("".equals(containRule)  && "".equals(exceptRule)){
            return new Result("请添加检测规则!");
        }
        try {
            StrategyRuleEntity strategyRuleEntity = strategyRuleDao.find(ruleId);
            if(isRuleNameRepeat(ruleName) && !strategyRuleEntity.getRuleName().equals(ruleName)){
                return new Result("检测规则名称已存在,请重新输入!");
            }
            strategyRuleEntity.setRuleDesc(ruleDesc);
            strategyRuleEntity.setLevelDefaultCode(levelDefault);
            List<DataLevelRuleEntity> dataLevelRuleEntities = new ArrayList<DataLevelRuleEntity>();
            addDataLevelRule(ruleScope01,scopeValue01,scopeValue02,scopeValue03,levelValue01,dataLevelRuleEntities,strategyRuleEntity);
            addDataLevelRule(ruleScope02,scopeValue04,scopeValue05,scopeValue06,levelValue02,dataLevelRuleEntities,strategyRuleEntity);
            addDataLevelRule(ruleScope03,scopeValue07,scopeValue08,scopeValue09,levelValue03,dataLevelRuleEntities,strategyRuleEntity);
            String[] ids = new String[strategyRuleEntity.getStrategyRuleContentEntities().size()];
            for(int i = 0 ; i < strategyRuleEntity.getStrategyRuleContentEntities().size(); i++){
                ids[i] = strategyRuleEntity.getStrategyRuleContentEntities().get(i).getId();
            }
            strategyRuleContentDao.delete(StrategyRuleContentEntity.class,ids);
            if(!"".equals(containRule)){
                addRuleContent(containRule,true,strategyRuleEntity);
            }
            if(!"".equals(exceptRule)){
                addRuleContent(exceptRule,false,strategyRuleEntity);
            }
            strategyRuleDao.update(strategyRuleEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("更新检测规则失败!");
        }
        return new Result("200","更新检测规则成功!",null);
    }

    @Override
    public Result deleteRule(String[] ids) {
        List<StrategyRuleEntity> strategyRuleEntities = strategyRuleDao.findByIdIn(ids);
        for(StrategyRuleEntity strategyRuleEntity : strategyRuleEntities){
            if(strategyRuleEntity.getStrategyEntities().size() > 0){
                return new Result(strategyRuleEntity.getRuleName()+"该检测规则正在被使用,请重新选择!");
            }
        }
        try {
            delete(StrategyRuleEntity.class,ids);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除检测规则失败,请稍后再试!");
        }
        return new Result("200","删除检测规则成功!",null);
    }

}
