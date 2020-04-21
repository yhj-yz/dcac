package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import com.huatusoft.dcac.strategymanager.service.StrategyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

/**
 * @author yhj
 * @date 2020-3-20
 */
@Controller
@RequestMapping("/admin/strategy")
public class StrategyController extends BaseController{

    @Autowired
    private StrategyService strategyService;
    /**
     * 跳转到策略界面
     * @return
     */
    @GetMapping(value = "/list")
    public String list() {
        return "/strategy/list.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param strategyName
     * @param strategyDesc
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<StrategyEntity> search(Integer pageSize, Integer pageNumber, String strategyName,String strategyDesc,String updateTime){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<StrategyEntity> page = strategyService.findAllByPage(pageable,strategyName,strategyDesc,updateTime);
        return new PageVo<StrategyEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 添加策略
     * @param strategyName
     * @param strategyDesc
     * @param scanType
     * @param responseType
     * @return
     */
    @PostMapping(value = "/addStrategy")
    @ResponseBody
    public Result addStrategy(String strategyName,String strategyDesc,String dataClassifyId,String dataGradeId,String scanType,String scanPath,String ruleId,String responseType,String maskRuleId,String matchValue){
        if(strategyName == null || "".equals(strategyName)){
            return new Result("请填写策略名称!");
        }
        if(dataClassifyId == null || "".equals(dataClassifyId)){
            return new Result("请选择数据分类!");
        }
        if(dataGradeId == null || "".equals(dataGradeId)){
            return new Result("请选择数据分级!");
        }
        if(ruleId == null || "".equals(ruleId)){
            return new Result("请选择检测规则!");
        }
        if("2".equals(scanType) && (null == scanPath || "".equals(scanPath))){
            return new Result("请输入扫描路径!");
        }
        if("1".equals(responseType) && (null == maskRuleId || "".equals(maskRuleId))){
            return new Result("请选择脱敏规则!");
        }
        return strategyService.addStrategy(strategyName,strategyDesc,dataClassifyId,dataGradeId,scanType,scanPath,ruleId,responseType,maskRuleId,matchValue);
    }

    /**
     * 删除策略
     * @param ids
     * @return
     */
    @PostMapping(value = "/deleteStrategy")
    @ResponseBody
    public Result deleteRule(String ids){
        if(ids == null){
            return  new Result("请勾选规则");
        }
        String[] strategyIds = ids.split(",");
        return strategyService.deleteRule(strategyIds);
    }

    @GetMapping(value = "/showStrategy")
    @ResponseBody
    public StrategyEntity showStrategy(String id){
        if(id == null){
            return null;
        }
        return strategyService.find(id);
    }

    @PostMapping(value = "/updateStrategy")
    @ResponseBody
    public Result updateStrategy(String strategyId,String strategyName,String strategyDesc,String dataClassifyId,String dataGradeId,String scanType,String scanPath,String ruleId,String responseType,String maskRuleId,String matchValue){
        if(null == strategyName || "".equals(strategyName)){
            return new Result("请输入策略名称!");
        }
        if(null == ruleId || "".equals(ruleId)){
            return new Result("请选择检测规则!");
        }
        if(null == dataClassifyId || "".equals(dataClassifyId)){
            return new Result("请选择数据分级!");
        }
        if(null == dataGradeId || "".equals(dataGradeId)){
            return new Result("请选择数据分类!");
        }
        if("2".equals(scanType) && (null == scanPath || "".equals(scanPath))){
            return new Result("请输入扫描路径!");
        }
        if("1".equals(responseType) && (null == maskRuleId || "".equals(maskRuleId))){
            return new Result("请选择脱敏规则!");
        }
        return strategyService.updateStrategy(strategyId,strategyName,strategyDesc,dataClassifyId,dataGradeId,scanType,scanPath,ruleId,responseType,maskRuleId,matchValue);
    }

}
