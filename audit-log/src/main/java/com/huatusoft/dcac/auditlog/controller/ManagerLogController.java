package com.huatusoft.dcac.auditlog.controller;

import com.huatusoft.dcac.auditlog.entity.ManagerLogEntity;
import com.huatusoft.dcac.auditlog.service.ManagerLogService;
import com.huatusoft.dcac.base.controller.BaseController;

import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
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
 * @date 2020-2-25
 */
@Controller("managerLogController")
@RequestMapping("admin/managerLog")
public class ManagerLogController extends BaseController {

    @Autowired
    private ManagerLogService managerLogService;
    /**
     * 管理日志页面跳转
     * @return
     */
    @GetMapping(value="list")
    public String list(){
        return "/log/managerLog/list.ftl";
    }

    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<ManagerLogEntity> search(Integer pageSize, Integer pageNumber, String userAccount, String userName, String ip, String operateTime, String operationModel, String operationType, String operationContent, String orderby) {
        Pageable pageable = PageRequest.of(pageNumber - 1, pageSize);
        Page<ManagerLogEntity> page= managerLogService.findAll(pageable,userAccount, userName, ip, operateTime, operationModel,operationType,operationContent,orderby);
        return new PageVo<ManagerLogEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }
}
