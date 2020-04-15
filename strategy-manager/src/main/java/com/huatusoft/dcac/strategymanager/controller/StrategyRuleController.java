package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.strategymanager.entity.DataGradeEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyRuleEntity;
import com.huatusoft.dcac.strategymanager.service.StrategyRuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * @author yhj
 * @date 2020-3-30
 */
@Controller
@RequestMapping(value = "/admin/strategy/rule")
public class StrategyRuleController extends BaseController {

    @Autowired
    private StrategyRuleService strategyRuleService;

    /**
     * 跳转到检测规则定义界面
     * @return
     */
    @GetMapping(value = "/list")
    public String list() {
        return "/strategy/rule/list.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param ruleName
     * @param createUserAccount
     * @param ruleDesc
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<StrategyRuleEntity> search(Integer pageSize, Integer pageNumber, String ruleName, String createUserAccount, String ruleDesc){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<StrategyRuleEntity> page = strategyRuleService.findAllByPage(pageable,ruleName,createUserAccount,ruleDesc);
        return new PageVo<StrategyRuleEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 添加检测规则
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
    @PostMapping(value = "/addStrategyRule")
    @ResponseBody
    public Result addStrategyRule(String ruleName,String ruleDesc,String levelDefault,String ruleScope01,String ruleScope02,String ruleScope03,String scopeValue01,String scopeValue02,String scopeValue03,String scopeValue04,String scopeValue05,String scopeValue06,String scopeValue07,String scopeValue08,String scopeValue09,String levelValue01,String levelValue02,String levelValue03,String containRule,String exceptRule){
        if(ruleName == null || "".equals(ruleName)){
            return new Result("检测规则名称不能为空!");
        }
        return strategyRuleService.addStrategyRule(ruleName,ruleDesc,levelDefault,ruleScope01,ruleScope02,ruleScope03,scopeValue01,scopeValue02,scopeValue03,scopeValue04,scopeValue05,scopeValue06,scopeValue07,scopeValue08,scopeValue09,levelValue01,levelValue02,levelValue03,containRule,exceptRule);
    }


    @PostMapping(value = "deleteRule")
    @ResponseBody
    public Result deleteRule(String ids){
        if(ids == null){
            return  new Result("请勾选规则");
        }
        try {
            String[] ruleIds = ids.split(",");
            strategyRuleService.delete(StrategyRuleEntity.class,ruleIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除规则失败!");
        }
        return new Result("200","删除规则成功!",null);
    }

    /**
     * 根据id获取检测规则信息
     * @param id
     * @return
     */
    @GetMapping("/getStrategyRule")
    @ResponseBody
    public StrategyRuleEntity getStrategyRule(String id){
        if(id == null){
            return null;
        }
        return strategyRuleService.find(id);
    }

    @PostMapping("/updateRule")
    @ResponseBody
    public Result updateRule(String ruleId,String ruleName,String ruleDesc,String levelDefault,String ruleScope01,String ruleScope02,String ruleScope03,String scopeValue01,String scopeValue02,String scopeValue03,String scopeValue04,String scopeValue05,String scopeValue06,String scopeValue07,String scopeValue08,String scopeValue09,String levelValue01,String levelValue02,String levelValue03,String containRule,String exceptRule){
        return strategyRuleService.updateRule(ruleId,ruleName,ruleDesc,levelDefault,ruleScope01,ruleScope02,ruleScope03,scopeValue01,scopeValue02,scopeValue03,scopeValue04,scopeValue05,scopeValue06,scopeValue07,scopeValue08,scopeValue09,levelValue01,levelValue02,levelValue03,containRule,exceptRule);
    }
}
