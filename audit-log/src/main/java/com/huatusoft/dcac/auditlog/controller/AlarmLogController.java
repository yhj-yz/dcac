package com.huatusoft.dcac.auditlog.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.auditlog.entity.AlarmLogEntity;
import com.huatusoft.dcac.auditlog.service.AlarmLogService;
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
@Controller("alarmLogController")
@RequestMapping("/admin/alarm")
public class AlarmLogController extends BaseController {
    @Autowired
    private AlarmLogService alarmLogService;

    /**
     * 告警日志页面跳转
     * @return
     */
    @GetMapping(value="/list")
    public String list(){
        return "/alarm/list.ftl";
    }

    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<AlarmLogEntity> search(Integer pageSize, Integer pageNumber, String warnDetail, String level, String userAccount, String operateTime, String readFlag) {
        Pageable pageable = PageRequest.of(pageNumber - 1, pageSize);
        Page<AlarmLogEntity> page= alarmLogService.findAll(pageable,warnDetail, level, userAccount, operateTime, readFlag);
        return new PageVo<AlarmLogEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

}
