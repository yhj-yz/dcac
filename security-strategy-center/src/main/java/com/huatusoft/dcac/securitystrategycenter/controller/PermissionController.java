/**
 * @author yhj
 * @date 2019-10-15
 */

package com.huatusoft.dcac.securitystrategycenter.controller;

import com.huatusoft.dcac.auditlog.service.ManagerLogService;
import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.common.annotation.ManagerLog;
import com.huatusoft.dcac.common.bo.Message;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.common.constant.SystemConstants;
import com.huatusoft.dcac.common.constant.SystemModelConstant;
import com.huatusoft.dcac.organizationalstrucure.entity.PermissionEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.DepartmentService;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import com.huatusoft.dcac.securitystrategycenter.constant.PermissionConstants;
import com.huatusoft.dcac.securitystrategycenter.exception.PermissionException;
import com.huatusoft.dcac.securitystrategycenter.response.message.PermissionResultMessage;
import com.huatusoft.dcac.securitystrategycenter.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;


@Controller("htPermissionSetController")
@RequestMapping("/admin/permissionset")
public class PermissionController extends BaseController {
    @Autowired
    private PermissionService permissionService;

    @Autowired
    private UserService userService;

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private ManagerLogService managerLogService;

    /**
     * 跳转到权限集管理界面
     * @return
     */
    @GetMapping(value = "/list")
    public String list() {
        return "/permission/set/list.ftl";
    }

    /**
     * 跳转到权限集信息界面
     * @param id
     * @param model
     * @return
     */
    @GetMapping(value = "/edit")
    public String list(String id, ModelMap model) {
        if(!id.equals("-1")){
            PermissionEntity permissionEntity = permissionService.find(id);
            model.addAttribute("permissionEntity", permissionEntity);
            model.addAttribute("oldPermissValue", permissionEntity.getUserAuthority());
        }
        model.addAttribute("policyMap", PermissionConstants.policyMap);
        return "/permission/set/edit.ftl";
    }

    /**
     * 分页查询
     * @param pageSize
     * @param pageNumber
     * @param permissionName
     * @return
     */
    @GetMapping(value = "/search")
    @ResponseBody
    public PageVo<PermissionEntity> search(Integer pageSize, Integer pageNumber, String permissionName) {
        Pageable pageable = PageRequest.of(pageNumber-1,pageSize);
        Page<PermissionEntity> page = permissionService.findAll(pageable,permissionName);
        return new PageVo<PermissionEntity>(page.getContent(),page.getTotalElements(),new PageableVo(page.getNumber()+1,page.getSize()));
    }

    /**
     * 添加权限集
     * @param permissionEntity
     * @return
     */
    @PostMapping(value = "/save")
    @ResponseBody
    @ManagerLog(operateModel = SystemModelConstant.PERMISSION_SET,description = "新增权限集")
    public Message save(PermissionEntity permissionEntity) throws PermissionException{
        UserEntity userEntity = userService.getCurrentUser();
        if(permissionEntity == null){
            throw new PermissionException(PermissionResultMessage.PERMISSION_NULL_MESSAGE,userEntity.getAccount());
        }
        Message message = permissionService.addPermission(permissionEntity);
        if(message.getType() == Message.Type.error) {
            throw new PermissionException(PermissionResultMessage.PERMISSION_NAME_REPEAT_MESSAGE,userEntity.getAccount());
        }
        return message;
    }

    /**
     * 删除权限集
     * @param ids
     * @return
     */
    @PostMapping(value = "/delete")
    public @ResponseBody Message delete(String[] ids) throws PermissionException{
        UserEntity user = userService.getCurrentUser();
        if (ids != null) {
            return permissionService.delete(ids);
        }else {
            throw new PermissionException(PermissionResultMessage.PERMISSION_PARAMETER_NULL_MESSAGE,user.getAccount());
        }
    }

    /**
     * 显示组织结构页面
     * @return 组织结构页面视图，并查询所有文件等级，所有岗位, 所有权限, 所有受控程序策略,
     */
    @GetMapping("/show")
    public ModelAndView show(ModelAndView mv) {
        //查询所有角色,受控策略,安全等级,当前登录用户,及其角色,权限集,备份测虐
        List<PermissionEntity> list = permissionService.findAll();
        mv.setViewName("/permission/department/organization-management.ftl");
        UserEntity curLoginUser = (UserEntity) super.getSession().getAttribute(SystemConstants.CURRENT_SYSTEM_LOGIN_USER_KEY);
        mv.addObject("roles", curLoginUser.getRole());
        mv.addObject("controls", curLoginUser.getControlledStrategy());
        mv.addObject("permissions", list);
        return mv;
    }

    @PostMapping(value = "/set_user_permission")
    @ResponseBody
    public Message setUserPermission(String id, String[] ids) throws PermissionException{
        PermissionEntity find = permissionService.find(id);
        Message message = departmentService.setUserPermission(find,ids);
        UserEntity userEntity = userService.getCurrentUser();
        if(message.getType() == Message.Type.error){
            throw new PermissionException(PermissionResultMessage.PERMISSION_SET_FAILED_MESSAGE,userEntity.getAccount());
        }
        return message;
    }
}
