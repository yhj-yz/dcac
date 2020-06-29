package com.huatusoft.dcac.organizationalstrucure.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.constant.DefaultNodeConstants;
import com.huatusoft.dcac.common.bo.Tree;
import com.huatusoft.dcac.organizationalstrucure.entity.DepartmentEntity;
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

    @PostMapping(value = "/addDepartment")
    @ResponseBody
    public Result addDepartment(String departmentName,String departmentDesc,String departmentId){
        if(departmentName == null || "".equals(departmentName)){
            return new Result("请输入部门名称!");
        }
        if(departmentId == null || "".equals(departmentId)){
            return new Result("请选择父部门!");
        }
        return departmentService.addDepartment(departmentName,departmentDesc,departmentId);
    }

    @PostMapping(value = "/updateDepartment")
    @ResponseBody
    public Result updateDepartment(String departmentName,String departmentDesc,String departmentId){
        if(departmentId == null || "".equals(departmentId)){
            return new Result("请选择对应的部门!");
        }
        if(departmentName == null || "".equals(departmentName)){
            return new Result("请输入部门名称!");
        }
        return departmentService.updateDepartment(departmentName,departmentDesc,departmentId);
    }

    /**
     * 根据Id获取部门信息
     * @param id
     * @return
     */
    @GetMapping(value = "/getDepartmentById")
    @ResponseBody
    public DepartmentEntity getDepartmentById(String id){
        if(id == null || "".equals(id)){
            return null;
        }
        return departmentService.find(id);
    }

    /**
     * 删除部门
     * @param id
     * @return
     */
    @PostMapping(value = "/deleteDepartment")
    @ResponseBody
    public Result deleteDepartment(String id){
        if(id == null || "".equals(id)){
            return new Result("请选择需要删除的部门");
        }
        return departmentService.deleteById(id);
    }
}
