package com.huatusoft.electronictag.organizationalstrucure.controller;

import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.common.constant.DefaultNodeConstants;
import com.huatusoft.electronictag.common.bo.Tree;
import com.huatusoft.electronictag.organizationalstrucure.service.DepartmentService;
import com.huatusoft.electronictag.organizationalstrucure.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.*;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 13:02
 */
@Controller
@RequestMapping("/organization_management/department")
public class DepartmentController extends BaseController {

    @Autowired
    private UserService userService;


    @Autowired
    private DepartmentService departmentService;
    /**
     * 查询可用部门封装树返回
     */
    @GetMapping(value = "/tree")
    @ResponseBody
    public List<Tree> tree(@RequestParam(value = "id", defaultValue = DefaultNodeConstants.EMPTY_DEPT_ID) String id) {
        return departmentService.findTree(id);
    }




}
