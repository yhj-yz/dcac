package com.huatusoft.dcac.organizationalstrucure.controller;

import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.PageVo;
import com.huatusoft.dcac.common.bo.PageableVo;
import com.huatusoft.dcac.common.constant.DefaultNodeConstants;
import com.huatusoft.dcac.organizationalstrucure.entity.DepartmentEntity;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.DepartmentService;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 15:11
 */
@Controller
@RequestMapping("/organization_management/user")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private DepartmentService departmentService;


    /**
     * 按部门分页列表
     */
    @ResponseBody
    @GetMapping(value = "/dept")
    public PageVo<UserEntity> listByDepartment(
            @RequestParam(value = "deptId", defaultValue = DefaultNodeConstants.ROOT_DEPT_ID) String deptId
            , @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber
            , @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize
            , @RequestParam(value = "name", required = false) String account) {
        DepartmentEntity department = departmentService.find( deptId);
        if (department == null) {
            return null;
        }
        Page<UserEntity> userPage = userService.findUsersByDept(department, pageNumber, pageSize, account);
        return new PageVo<UserEntity>(userPage.getContent(), userPage.getTotalElements(), new PageableVo(userPage.getNumber() + 1, userPage.getSize()));
    }

    /**
     * 新增用户
     * @param departmentId
     * @param account
     * @param name
     * @param password
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/addUser")
    public Result addUser(String departmentId,String account, String name, String password,String passwordSure){
        if(departmentId == null || "".equals(departmentId)){
            return new Result("请选择相应的部门!");
        }
        if(account == null || "".equals(account)){
            return new Result("请输入账号!");
        }
        if(name == null || "".equals(name)){
            return new Result("请输入姓名!");
        }
        if(password == null || "".equals(password)){
            return new Result("请输入密码!");
        }
        if(!passwordSure.equals(password)){
            return new Result("两次输入的密码不一致,请重新输入!");
        }
        return userService.addUser(departmentId,account,name,password);
    }

    /**
     * 删除用户
     * @param ids
     * @return
     */
    @ResponseBody
    @PostMapping(value = "/deleteUser")
    public Result deleteUser(String ids){
        if(ids == null || "".equals(ids)){
            return new Result("请选择需要删除的用户!");
        }
        try {
            String[] id = ids.split(",");
            userService.delete(UserEntity.class,id);
        }catch (Exception e){
            e.printStackTrace();
            return new Result("删除用户失败!");
        }
        return new Result("200","删除用户成功!",null);
    }

    /**
     * 根据ID获取用户信息
     * @param userId
     * @return
     */
    @ResponseBody
    @GetMapping(value = "/getUserById")
    public UserEntity userEntity(String userId){
        if(userId == null){
            return null;
        }
        return userService.find(userId);
    }

    /**
     * 更新用户信息
     * @param userId
     * @param account
     * @param name
     * @param password
     * @param passwordSure
     * @return
     */
    @ResponseBody
    @PostMapping(value = "updateUser")
    public Result updateUser(String userId,String account,String name,String password,String passwordSure){
        if(userId == null || "".equals(userId)){
            return new Result("缺少用户信息!");
        }
        if(account == null || "".equals(account)){
            return new Result("请输入账号!");
        }
        if(name == null || "".equals(name)){
            return new Result("请输入用户名");
        }
        if(password == null || "".equals(password)){
            return new Result("请输入密码!");
        }
        if(!password.equals(passwordSure)){
            return new Result("两次输入密码不一致,请重新输入!");
        }
        return userService.updateUser(userId,account,name,password,passwordSure);
    }
}
