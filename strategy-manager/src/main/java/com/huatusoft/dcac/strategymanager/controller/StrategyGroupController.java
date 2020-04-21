package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.strategymanager.entity.StrategyGroupEntity;
import com.huatusoft.dcac.strategymanager.service.StrategyGroupService;
import org.apache.regexp.RE;
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
 * @date 2020-4-18
 */
@Controller
@RequestMapping("/admin/strategy/group")
public class StrategyGroupController extends BaseController {

    @Autowired
    private StrategyGroupService strategyGroupService;

    /**
     * 跳转到策略组界面
     * @return
     */
    @GetMapping(value = "/list")
    public String list() {
        return "/strategy/group/list.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param groupName
     * @param createUserAccount
     * @param groupDesc
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<StrategyGroupEntity> search(Integer pageSize, Integer pageNumber, String groupName, String createUserAccount, String groupDesc){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<StrategyGroupEntity> page = strategyGroupService.findAllByPage(pageable,groupName,groupDesc,createUserAccount);
        return new PageVo<StrategyGroupEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 添加组策略
     * @param groupName
     * @param groupDesc
     * @param strategyId
     * @return
     */
    @PostMapping(value = "/addStrategyGroup")
    @ResponseBody
    public Result addStrategyGroup(String groupName,String groupDesc,String strategyId){
        if(null == groupName || "".equals(groupName)){
            return new Result("请输入组策略名称!");
        }
        if(null == strategyId || "".equals(strategyId)){
            return new Result("请选择策略!");
        }
        return strategyGroupService.addStrategyGroup(groupName,groupDesc,strategyId);
    }

    /**
     * 删除组策略
     * @param ids
     * @return
     */
    @PostMapping("/deleteStrategyGroup")
    @ResponseBody
    public Result deleteStrategyGroup(String ids){
        if(ids == null){
            return new Result("请勾选组策略!");
        }
        try {
            String[] strategyGroupIds = ids.split(",");
            strategyGroupService.delete(StrategyGroupEntity.class,strategyGroupIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除组策略失败,请稍后再试!");
        }
        return new Result("200","删除组策略成功!",null);
    }

    /**
     * 根据编号获取策略组信息
     * @param id
     * @return
     */
    @GetMapping("/getStrategyGroup")
    @ResponseBody
    public StrategyGroupEntity getStrategyGroup(String id){
        if(id == null){
            return null;
        }
        return strategyGroupService.findById(id);
    }

    @PostMapping("/updateStrategyGroup")
    @ResponseBody
    public Result updateStrategyGroup(String groupId,String groupName,String groupDesc,String strategyId){
        if(groupName == null || "".equals(groupName)){
            return new Result("请输入组策略名称!");
        }
        if(strategyId == null || "".equals(strategyId)){
            return new Result("请选择策略!");
        }
        return strategyGroupService.updateStrategyGroup(groupId,groupName,groupDesc,strategyId);
    }
}
