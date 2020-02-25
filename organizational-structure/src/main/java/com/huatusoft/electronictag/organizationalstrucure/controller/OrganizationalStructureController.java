package com.huatusoft.electronictag.organizationalstrucure.controller;

import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.common.bo.Message;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import com.huatusoft.electronictag.organizationalstrucure.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.text.MessageFormat;
import java.util.ArrayList;
import java.util.List;


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
