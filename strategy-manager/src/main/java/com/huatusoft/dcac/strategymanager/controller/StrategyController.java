package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import com.huatusoft.dcac.strategymanager.service.StrategyService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
}
