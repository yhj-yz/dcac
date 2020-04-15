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
     * @param dataClassifyName
     * @param dataGradeName
     * @param scanType
     * @param ruleName
     * @param responseType
     * @param maskRuleName
     * @return
     */
    @PostMapping(value = "/addStrategy")
    @ResponseBody
    public Result addStrategy(String strategyName,String strategyDesc,String dataClassifyName,String dataGradeName,String scanType,String ruleName,String responseType,String maskRuleName){
        if(strategyName == null || "".equals(strategyName)){
            return new Result("请填写策略名称!");
        }
        return strategyService.addStrategy(strategyName,strategyDesc,dataClassifyName,dataGradeName,scanType,ruleName,responseType,maskRuleName);
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
        try {
            String[] strategyIds = ids.split(",");
            strategyService.delete(StrategyEntity.class,strategyIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除策略失败!");
        }
        return new Result("200","删除策略成功!",null);
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
    public Result updateStrategy(String strategyId,String strategyName,String strategyDesc,String dataClassifyName,String dataGradeName,String scanType,String ruleName,String responseType,String maskRuleName){
        return strategyService.updateStrategy(strategyId,strategyName,strategyDesc,dataClassifyName,dataGradeName,scanType,ruleName,responseType,maskRuleName);
    }

}
