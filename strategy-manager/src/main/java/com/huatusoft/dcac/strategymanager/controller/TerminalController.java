package com.huatusoft.dcac.strategymanager.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.strategymanager.entity.TerminalEntity;
import com.huatusoft.dcac.strategymanager.service.TerminalService;
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
 * @date 2020-6-24
 */
@Controller
@RequestMapping(value = "/strategy/terminal")
public class TerminalController extends BaseController {

    @Autowired
    private TerminalService terminalService;

    /**
     * 跳转到终端策略界面
     * @return
     */
    @GetMapping(value = "/list")
    public String list() {
        return "/strategy/terminal/list.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param deviceName
     * @param ipAddress
     * @param systemVersion
     * @param versionInform
     * @param connectStatus
     * @param scanStatus
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<TerminalEntity> search(Integer pageSize, Integer pageNumber,String deviceName, String ipAddress, String systemVersion,String versionInform,String connectStatus,String scanStatus){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<TerminalEntity> page = terminalService.findAllByPage(pageable,deviceName,ipAddress,systemVersion,versionInform,connectStatus,scanStatus);
        return new PageVo<TerminalEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 删除终端
     * @param ids
     * @return
     */
    @PostMapping(value = "/deleteTerminal")
    @ResponseBody
    public Result deleteTerminal(String ids){
        if(ids == null || "".equals(ids)){
            return new Result("请选择需要删除的终端!");
        }
        try {
            String[] terminalIds = ids.split(",");
            terminalService.delete(TerminalEntity.class,terminalIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除终端失败!");
        }
        return new Result("200","删除终端成功!",null);
    }

    /**
     * 终端关联用户
     * @param userId
     * @return
     */
    @PostMapping(value = "/setUser")
    @ResponseBody
    public Result setUser(String terminalId,String userId){
        if(terminalId == null || "".equals(terminalId)){
            return new Result("缺少终端信息!");
        }
        if(userId == null || "".equals(userId)){
            return new Result("缺少用户信息!");
        }
        return terminalService.setUser(terminalId,userId);
    }

    @PostMapping(value = "/setStrategyGroup")
    @ResponseBody
    public Result setStrategyGroup(String terminalId,String groupId){
        if(terminalId == null || "".equals(terminalId)){
            return new Result("缺少终端信息!");
        }
        if(groupId == null || "".equals(groupId)){
            return new Result("缺少组策略信息!");
        }
        return terminalService.setStrategyGroup(terminalId,groupId);
    }
}
