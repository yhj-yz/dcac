package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
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
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

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

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param identifierName
     * @param identifierType
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<DataIdentifierEntity> search(Integer pageSize, Integer pageNumber, String identifierName, String identifierType){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<DataIdentifierEntity> page = dataIdentifierService.findAllByPage(pageable,identifierName,identifierType);
        return new PageVo<DataIdentifierEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    @PostMapping(value = "/importIdentifier")
    @ResponseBody
    public Result importIdentifier(@RequestParam("file")MultipartFile uploadFile) {
        if(uploadFile == null){
            return new Result("请上传csv文件!");
        }
        return dataIdentifierService.importIdentifier(uploadFile);
    }
}
