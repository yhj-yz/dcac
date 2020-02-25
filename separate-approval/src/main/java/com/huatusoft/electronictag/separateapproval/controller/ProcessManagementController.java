package com.huatusoft.electronictag.separateapproval.controller;

import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.base.response.Result;
import com.huatusoft.electronictag.common.bo.PageVo;
import com.huatusoft.electronictag.common.bo.PageableVo;
import com.huatusoft.electronictag.common.constant.SystemConstants;
import com.huatusoft.electronictag.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import com.huatusoft.electronictag.organizationalstrucure.service.DepartmentService;
import com.huatusoft.electronictag.organizationalstrucure.service.UserService;
import com.huatusoft.electronictag.separateapproval.domain.ApproverType;
import com.huatusoft.electronictag.separateapproval.entity.WorkFlowEntity;
import com.huatusoft.electronictag.separateapproval.service.WorkFlowService;
import com.huatusoft.electronictag.separateapproval.vo.WorkFlowVo;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;


/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/29 9:38
 */
@Controller
@RequestMapping("/process_management")
public class ProcessManagementController extends BaseController {

    @Autowired
    private WorkFlowService workFlowService;

    @Autowired
    private UserService userService;

    @Autowired
    private DepartmentService departmentService;


    @GetMapping("/show")
    public String show() {
        return "/approve/my_process/flow_list.ftl";
    }


    @GetMapping("/search")
    @ResponseBody
    public PageVo<WorkFlowEntity> search(
            @RequestParam("pageNumber") Integer pageNumber
            ,@RequestParam("pageSize") Integer pageSize
            ,@RequestParam(value = "flowName", required = false) String flowName) {
        Page<WorkFlowEntity> page = workFlowService.findPage(flowName, pageNumber, pageSize, ((UserEntity) getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_KEY)).getAccount());
        return new PageVo<WorkFlowEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber(), page.getSize()));
    }

    @GetMapping("/add")
    public ModelAndView toUpdateFlowPage(@RequestParam(value = "ids", required = false) String ids, ModelAndView mv) {
        mv.setViewName("/approve/my_process/flow_addAndUpdate.ftl");
        if (StringUtils.isBlank(ids)) {
            mv.addObject("action", "add");
        } else {
            WorkFlowEntity workFlow = workFlowService.find(ids);
            mv.addObject("flow", workFlow);
            mv.addObject("action", "edit");
        }
        return mv;
    }

    @GetMapping("/approverlist")
    public String toApproverList() {
        return "/approve/my_process/approverlist.ftl";
    }

    @PostMapping("/save")
    public ModelAndView save(WorkFlowVo workFlowVo, ModelAndView mv) {
        mv.setViewName("/approve/my_process/flow_list.ftl");
        if (workFlowService.isWorkFlowNameRepeat(workFlowVo.getWorkFlowName())) {
            //抛出工作流名称重复异常
            //TODO
        }
        WorkFlowEntity workFlowEntity = new WorkFlowEntity(workFlowVo.getWorkFlowName(), workFlowVo.getDescription(), Objects.equals(1, workFlowVo.getApproveUserType()) ? ApproverType.ADMIN : ApproverType.USER, workFlowVo.getApproveUser());
        workFlowService.add(workFlowEntity);
        return mv;
    }

    @PostMapping("/remove")
    @ResponseBody
    public Result delete(@RequestParam("ids") String[] ids) {
        if (Objects.isNull(ids) && ids.length == 0) {
            //请选择后删除
        }
        workFlowService.delete(WorkFlowEntity.class, ids);
        return Result.build("删除成功");
    }

    @PostMapping("/update")
    public String update(WorkFlowVo workFlowVo, ModelMap model) {
        WorkFlowEntity workFlowEntity = workFlowService.find(workFlowVo.getId());

        if (Objects.isNull(workFlowEntity)) {
            //尚未查询到流程信息,修改失败
        }
        workFlowEntity.setDescription(workFlowVo.getDescription());
        workFlowEntity.setFlowName(workFlowVo.getWorkFlowName());
        workFlowEntity.setApproverType(Objects.equals(workFlowVo.getApproveUserType(), 1) ? ApproverType.ADMIN : ApproverType.USER);
        workFlowEntity.setApproveAccount(workFlowVo.getApproveUser());
        workFlowService.update(workFlowEntity);
        return "/approve/my_process/flow_list.ftl";
    }

    @ResponseBody
    @GetMapping("/findapproverlist")
    public List<UserEntity> toFindApproverList(@RequestParam("approveUserType") Integer type) {
        List<UserEntity> users = null;
        UserEntity curLoginUser = (UserEntity) getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_KEY);
        if (Objects.equals(1, type) || StringUtils.isBlank(curLoginUser.getDid())) {
            users = add(userService.findByIsSystem(1), curLoginUser);
        } else {
            users = add(departmentService.find( curLoginUser.getDid()).getUsers(), curLoginUser);
        }
        return users;
    }

    private List<UserEntity> add(List<UserEntity> userEntities, UserEntity curLoginUser) {
        List<UserEntity> users = new ArrayList<UserEntity>();
        for (UserEntity userEntity : userEntities) {
            if (StringUtils.equals(userEntity.getAccount(), curLoginUser.getAccount())) {
                continue;
            }
            users.add(userEntity);
        }
        return users;
    }
}
