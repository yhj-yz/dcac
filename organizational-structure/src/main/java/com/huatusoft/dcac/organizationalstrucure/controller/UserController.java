package com.huatusoft.dcac.organizationalstrucure.controller;

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
            @RequestParam(value = "deptId", defaultValue = DefaultNodeConstants.EMPTY_DEPT_ID) String deptId
            , @RequestParam(value = "pageNumber", defaultValue = "1") Integer pageNumber
            , @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize
            , @RequestParam(value = "name", required = false) String account) {
        DepartmentEntity department = departmentService.find( deptId);
        if (department == null) {
            return null;
        }
        List<String> departmentIds = new ArrayList<String>();
        Page<UserEntity> userPage = userService.findUsersByDept(department, pageNumber, pageSize, account);
        if (!departmentIds.contains(department.getId())) {
            departmentIds.add(deptId);
        }
        return new PageVo<UserEntity>(userPage.getContent(), userPage.getTotalElements(), new PageableVo(userPage.getNumber() + 1, userPage.getSize()));
    }
}
