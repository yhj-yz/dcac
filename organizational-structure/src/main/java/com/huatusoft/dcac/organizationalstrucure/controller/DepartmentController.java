package com.huatusoft.dcac.organizationalstrucure.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.common.constant.DefaultNodeConstants;
import com.huatusoft.dcac.common.bo.Tree;
import com.huatusoft.dcac.organizationalstrucure.service.DepartmentService;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
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
