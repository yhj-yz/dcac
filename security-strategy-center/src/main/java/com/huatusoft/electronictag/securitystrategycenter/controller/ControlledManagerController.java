/**
 * 应用程序控制-控制层
 * @author yhj
 * @date 2019-11-4
 */
package com.huatusoft.electronictag.securitystrategycenter.controller;

import com.huatusoft.electronictag.common.bo.Message;
import com.huatusoft.electronictag.common.bo.PageVo;
import com.huatusoft.electronictag.common.bo.PageableVo;
import com.huatusoft.electronictag.organizationalstrucure.entity.ManagerTypeEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.ProcessEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.SoftWareEntity;
import com.huatusoft.electronictag.securitystrategycenter.service.SoftWareService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
@RequestMapping("/admin/contrManagerController")
public class ControlledManagerController {
    @Autowired
    private SoftWareService softWareService;

    /**
     * 配置程序管理页面跳转
     * @param model
     * @return
     */
    @GetMapping(value = "/list")
    public String list(Model model) {
        return "/security/contrmanager/list.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param softName
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<SoftWareEntity> search(Integer pageSize, Integer pageNumber, String softName){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<SoftWareEntity> page = softWareService.findAllByPage(pageable,softName);
        return new PageVo<SoftWareEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 添加软件
     * @param softName
     * @return
     */
    @PostMapping(value = "/saveSoftWare")
    @ResponseBody
    public Message saveSoftWare(String softName){
        if(softWareService.isNameRepeat(softName)){
            return new Message(Message.Type.error,"软件名称重复");
        }
        SoftWareEntity softWareEntity = new SoftWareEntity();
        softWareEntity.setIsConfig(false);
        softWareEntity.setIsSystem(false);
        softWareEntity.setSoftName(softName);
        softWareService.add(softWareEntity);
        return new Message(Message.Type.success,"添加成功");
    }

    /**
     * 删除软件
     * @param ids
     * @return
     */
    @PostMapping(value = "/deleteSoftWare")
    @ResponseBody
    public Message deleteSoftWare(String ids){
        if(ids == null){
            return new Message(Message.Type.error,"请勾选软件");
        }
        try {
            String[] softIds = ids.split(",");
            softWareService.delete(SoftWareEntity.class, softIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Message(Message.Type.error,"删除失败");
        }
        return new Message(Message.Type.success,"删除成功");
    }

    /**
     * 根据id获取软件对象
     * @param id
     * @return
     */
    @GetMapping(value = "/showSoftWare")
    @ResponseBody
    public SoftWareEntity showSoftWare(String id){
        if(id == null){
            return null;
        }
        return softWareService.find(id);
    }

    /**
     * 更新软件名称
     * @param id
     * @param softName
     * @return
     */
    @PostMapping(value = "/updateSoftWare")
    @ResponseBody
    public Message updateSoftWare(String id,String softName){
        if(id == null || softName == null){
            return new Message(Message.Type.error,"id或名称不能为空");
        }
        try {
            SoftWareEntity softWareEntity = softWareService.find( id);
            if(softName.equals(softWareEntity.getSoftName())){
                return new Message(Message.Type.error,"软件名称一致");
            }
            softWareEntity.setSoftName(softName);
            softWareService.update(softWareEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Message(Message.Type.error,"修改失败");
        }
        return new Message(Message.Type.success,"修改成功");
    }

    @PostMapping(value = "/addConfig")
    @ResponseBody
    public Message addConfig(String softId,String processName,String manageType){
        if(softId == null || processName == null || manageType == null){
            return new Message(Message.Type.error,"软件id或进程名或受控类型不能为空");
        }
        try {
            if (softWareService.isProcessRepeat(softId,processName)) {
                return new Message(Message.Type.error,"进程名称重复");
            }
            SoftWareEntity softWareEntity = softWareService.find(softId);
            ManagerTypeEntity managerTypeEntity = new ManagerTypeEntity();
            managerTypeEntity.setManageName(manageType);
            ProcessEntity processEntity = new ProcessEntity();
            processEntity.setProcessName(processName);
            processEntity.addManagerType(managerTypeEntity);
            softWareEntity.addProcess(processEntity);
            softWareService.add(softWareEntity);
            softWareService.addRest(processEntity,managerTypeEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Message(Message.Type.error,"添加失败");
        }
        return new Message(Message.Type.success,"添加成功");
    }

    /**
     * 删除配置
     * @param ids
     * @return
     */
    @PostMapping(value = "/deleteConfig")
    @ResponseBody
    public Message deleteConfig(String ids){
        if(ids == null){
            return new Message(Message.Type.error,"请勾选删除的配置");
        }
        try{
            String[] softIds = ids.split(",");
            softWareService.deleteConfig(softIds);
        }catch (Exception e){
            e.printStackTrace();
            return new Message(Message.Type.error,"删除失败");
        }
        return new Message(Message.Type.success,"删除成功");
    }

    @GetMapping(value = "/showProcess")
    @ResponseBody
    public ProcessEntity showProcess(String id){
        if(id == null){
            return null;
        }
        return softWareService.findProcessById(id);
    }

    @PostMapping(value = "/updateConfig")
    @ResponseBody
    public Message updateConfig(String id, String processName, String manageName){
        if(id == null || processName == null || manageName == null){
            return new Message(Message.Type.error,"id或进程名或受控类型不能为空");
        }
        try{
            ProcessEntity processEntity = softWareService.findProcessById(id);
            if (processEntity.getProcessName().equals(processName) &&
                    processEntity.getManagerTypeEntities().get(0).getManageName().equals(manageName)) {
                return new Message(Message.Type.error,"未发生修改,请修改后在提交");
            }
            processEntity.setProcessName(processName);
            processEntity.getManagerTypeEntities().get(0).setManageName(manageName);
            softWareService.updateConfig(processEntity);
        }catch (Exception e){
            e.printStackTrace();
            return new Message(Message.Type.error,"更新失败");
        }
        return new Message(Message.Type.success,"更新成功");
    }

}