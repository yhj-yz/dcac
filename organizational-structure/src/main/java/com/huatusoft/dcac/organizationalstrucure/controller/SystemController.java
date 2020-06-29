package com.huatusoft.dcac.organizationalstrucure.controller;

import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.organizationalstrucure.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author yhj
 * @date 2020-5-15
 */
@Controller
@RequestMapping("/system/param")
public class SystemController extends BaseController {
    @Autowired
    private SystemService systemService;

    @GetMapping("/register")
    public String register(){
        return "/register/add.ftl";
    }

    @PostMapping("/save")
    @ResponseBody
    public Result save(String appId, String productKey){
        if(appId == null || productKey == null){
            return new Result("请输入必要参数!");
        }
        return systemService.register(appId,productKey);
    }
}
