package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.strategymanager.entity.DataIdentifierEntity;
import com.huatusoft.dcac.strategymanager.entity.StrategyEntity;
import com.huatusoft.dcac.strategymanager.service.DataIdentifierService;
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
 * @date 2020-3-27
 */
@Controller
@RequestMapping("/admin/data/identifier")
public class DataIdentifierController extends BaseController {
    @Autowired
    private DataIdentifierService dataIdentifierService;

    /**
     * 跳转到隐私检测模板界面
     * @return
     */
    @GetMapping(value = "/list")
    public String list() {
        return "/data/identifier/list.ftl";
    }

    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<DataIdentifierEntity> search(Integer pageSize, Integer pageNumber, String identifierName, String identifierType){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<DataIdentifierEntity> page = dataIdentifierService.findAllByPage(pageable,identifierName,identifierType);
        return new PageVo<DataIdentifierEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }
}
