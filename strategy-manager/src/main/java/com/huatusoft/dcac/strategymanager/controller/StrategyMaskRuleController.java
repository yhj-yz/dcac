package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.strategymanager.entity.StrategyMaskRuleEntity;
import com.huatusoft.dcac.strategymanager.service.StrategyMaskRuleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author yhj
 * @date 2020-4-3
 */
@Controller
@RequestMapping(value = "/admin/strategy/mask")
public class StrategyMaskRuleController extends BaseController {

    @Autowired
    private StrategyMaskRuleService strategyMaskRuleService;

    /**
     * 跳转到脱敏规则定义界面
     * @return
     */
    @GetMapping(value = "/list")
    public String list() {
        return "/strategy/mask/list.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param ruleName
     * @param ruleType
     * @param maskType
     * @param maskEffect
     * @param createUserAccount
     * @param ruleDesc
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<StrategyMaskRuleEntity> search(Integer pageSize, Integer pageNumber, String ruleName, String ruleType, String maskType, String maskEffect, String createUserAccount, String ruleDesc){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<StrategyMaskRuleEntity> page = strategyMaskRuleService.findAllByPage(pageable,ruleName,ruleType,maskType,maskEffect,createUserAccount,ruleDesc);
        return new PageVo<StrategyMaskRuleEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 新增脱敏规则
     * @param ruleName
     * @param ruleDesc
     * @param ruleType
     * @param maskContent
     * @param maskType
     * @param maskEffect
     * @return
     */
    @PostMapping(value = "addRule")
    @ResponseBody
    public Result addRule(String ruleName,String ruleDesc,String ruleType,String maskContent,String maskType,String maskEffect){
        if(ruleName == null || "".equals(ruleName)){
            return new Result("请填写规则名称!");
        }
        return strategyMaskRuleService.addRule(ruleName,ruleDesc,ruleType,maskContent,maskType,maskEffect);
    }

    /**
     * 删除脱敏规则
     * @param ids
     * @return
     */
    @PostMapping(value = "deleteRule")
    @ResponseBody
    public Result deleteRule(String ids){
        if(ids == null){
            return  new Result("请勾选规则");
        }
        try {
            String[] ruleIds = ids.split(",");
            strategyMaskRuleService.delete(StrategyMaskRuleEntity.class,ruleIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除脱敏规则失败!");
        }
        return new Result("200","删除脱敏规则成功!",null);
    }

    /**
     * 根据id获取脱敏规则信息
     * @param id
     * @return
     */
    @GetMapping("/getMaskRule")
    @ResponseBody
    public StrategyMaskRuleEntity getMaskRule(String id){
        if(id == null){
            return null;
        }
        return strategyMaskRuleService.find(id);
    }

    /**
     * 修改脱敏规则
     * @param id
     * @param ruleName
     * @param ruleDesc
     * @param ruleType
     * @param maskContent
     * @param maskType
     * @param maskEffect
     * @return
     */
    @PostMapping("/updateMaskRule")
    @ResponseBody
    public Result updateMaskRule(String ruleId,String ruleName,String ruleDesc,String ruleType,String maskContent,String maskType,String maskEffect){
        return strategyMaskRuleService.updateMaskRule(ruleId,ruleName,ruleDesc,ruleType,maskContent,maskType,maskEffect);
    }
}
