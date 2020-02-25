/**
 * @author yhj
 * @date 2019-10-16
 */
package com.huatusoft.electronictag.securitystrategycenter.controller;

import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.common.bo.PageVo;
import com.huatusoft.electronictag.common.bo.PageableVo;
import com.huatusoft.electronictag.organizationalstrucure.entity.ControlledStrategyEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.ProgramEntity;
import com.huatusoft.electronictag.securitystrategycenter.service.ControlledStrategyService;
import com.huatusoft.electronictag.securitystrategycenter.service.ProgramService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Set;

@Controller("controlledStrategy")
@RequestMapping("admin/controlledStrategy")
public class ControlledStrategyController extends BaseController {
    @Autowired
    private ControlledStrategyService controlledStrategyService;

    @Autowired
    private ProgramService programService;

    /**
     * 跳转到受控程序管理界面
     * @return
     */
    @GetMapping(value="list")
    public String list() {
        return "/security/contrStrategy/list.ftl";
    }


    @GetMapping(value="search")
    @ResponseBody
    public PageVo<ControlledStrategyEntity> search(Integer pageSize, Integer pageNumber,String name){
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<ControlledStrategyEntity> page = controlledStrategyService.findAll(pageable,name);
         return new PageVo<ControlledStrategyEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    @RequestMapping(value="add",method= RequestMethod.GET)
    public String  add(String id, Model model) {
//        if(id!=null) {
//            ControlledStrategyEntity controlledStrategyEntity = controlledStrategyService.find(ControlledStrategyEntity.class,id);
//            model.addAttribute("controlledStrategy", controlledStrategyEntity);
//            List<ProgramEntity> programEntity = controlledStrategyEntity.getPrograms();
//            if(programEntity!=null) {
//                model.addAttribute("exists", programEntity);
//            }
//
//            List<ProgramEntity> programList1 = programService.findByIsConfigAndParentId(1,"2");
//
//            Collection exists=new ArrayList<ProgramEntity>(programList1);
//            Collection notexists=new ArrayList<ProgramEntity>(programList1);
//            exists.removeAll(contrManagers2);
//            model.addAttribute("contrManagers", exists);
//            //找出两个配置集合的不同元素
//
//        }else {
//            List<Filter> filters=new ArrayList<Filter>();
//            Filter filter=new Filter("isConfig", Operator.eq, true);
//            Filter filterpid=new Filter("parentId", Operator.ne, 2);
//            filters.add(filter);
//            filters.add(filterpid);
//            List<ContrManager> contrManagers = contrManagerService.findList(null, filters, null);
//            model.addAttribute("contrManagers", contrManagers);
//        }
        return "/dsm/security/contrStrategy/add";
    }


}
