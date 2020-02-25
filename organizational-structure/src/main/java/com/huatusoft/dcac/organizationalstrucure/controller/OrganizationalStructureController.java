package com.huatusoft.dcac.organizationalstrucure.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.organizationalstrucure.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;


/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/27 16:18
 */
@Controller
@RequestMapping("/organization_management")
public class OrganizationalStructureController extends BaseController {

    @Autowired
    private DepartmentService departmentService;

    @Autowired
    private UserService userService;

    @Autowired
    private RoleService roleService;
}
