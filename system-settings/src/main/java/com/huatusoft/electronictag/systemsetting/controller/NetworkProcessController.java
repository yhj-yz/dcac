/**
 * @author yhj
 * @date 2019-10-18
 */
package com.huatusoft.electronictag.systemsetting.controller;

import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.common.bo.Message;
import com.huatusoft.electronictag.common.bo.PageVo;
import com.huatusoft.electronictag.common.bo.PageableVo;
import com.huatusoft.electronictag.systemsetting.entity.NetworkProcessEntity;
import com.huatusoft.electronictag.systemsetting.service.NetworkProcessService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/networkProcess")
public class NetworkProcessController extends BaseController{
    @Autowired
    private NetworkProcessService networkProcessService;

    /**
     * 跳转到网络进程配置界面
     * @return
     */
    @GetMapping(value="/list")
    public String list(){
        return "/network_process/list.ftl";
    }


    @GetMapping(value="/search")
    @ResponseBody
    public PageVo<NetworkProcessEntity> search(Integer pageSize, Integer pageNumber, String processName) {
        try {
            if(null != processName) {
                processName = new String(processName.getBytes("ISO8859-1"),"UTF-8");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<NetworkProcessEntity> page =networkProcessService.findAll(pageable,processName);
        return new PageVo<NetworkProcessEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 添加网络进程
     * @param inputDto
     * @return
     */
    @PostMapping(value="/add")
    public @ResponseBody Message addIPWhiteList(NetworkProcessEntity inputDto){
        if(inputDto == null) {
            return new Message(Message.Type.error, "参数不能为空");
        }
        try {
            networkProcessService.add(inputDto);
        }catch (Exception e) {
            e.printStackTrace();
            return new Message(Message.Type.error, "添加失败");
        }
        return new Message(Message.Type.success, "处理成功");
    }


    @PostMapping(value="/delete")
    public @ResponseBody
    Message deleteAlarms(String[] ids){
        if (null != ids) {
            networkProcessService.delete(NetworkProcessEntity.class,ids);
            return new Message(Message.Type.success,"删除成功");
        }else {
            return new Message(Message.Type.error,"参数不能为空");
        }
    }
}
