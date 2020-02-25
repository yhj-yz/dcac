package com.huatusoft.electronictag.authentication.controller;

import com.huatusoft.electronictag.authentication.checkcode.CreateImageCode;
import com.huatusoft.electronictag.authentication.response.info.AuthenticationResultInfo;
import com.huatusoft.electronictag.base.response.Result;
import com.huatusoft.electronictag.common.annotation.ManagerLog;
import com.huatusoft.electronictag.common.bo.Principal;
import com.huatusoft.electronictag.common.bo.Setting;
import com.huatusoft.electronictag.common.constant.SystemModelConstant;
import com.huatusoft.electronictag.common.util.FastJsonUtils;
import com.huatusoft.electronictag.base.controller.BaseController;
import com.huatusoft.electronictag.common.util.SettingUtils;
import com.huatusoft.electronictag.organizationalstrucure.entity.UserEntity;
import com.huatusoft.electronictag.organizationalstrucure.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Objects;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/27 15:59
 */

@Controller
@RequestMapping("/authentication")
public class LoginController extends BaseController {

    private Subject subject = SecurityUtils.getSubject();

    @Autowired
    private UserService userService;

    /**
     * 主页
     */
    @GetMapping("/main")
    public String main(ModelMap model){
        Setting setting = SettingUtils.get();
        model.addAttribute("systemName", setting.getSiteName());
        model.addAttribute("adminName", ((Principal) SecurityUtils.getSubject().getPrincipal()).getUser_name());
        model.addAttribute("isSolo", setting.getIsSolo());
        return "/common/main.ftl";
    }

    @GetMapping("/code")
    @ResponseBody
    public String checkCode() throws IOException {
        CreateImageCode createImageCode = new CreateImageCode();
        createImageCode.getCode3(getRequest(),getResponse(),getSession());
        return createImageCode.getCode();
    }

    @RequestMapping("/login")
    public String login() {
        return "redirect:/login.html";
    }

    @ResponseBody
    @GetMapping("/user")
    public String isExist(@RequestParam(name = "account") String account) {
        AuthenticationResultInfo code;
        UserEntity user = userService.getUserByAccount(account);
        if(Objects.isNull(user)) {
            code = AuthenticationResultInfo.USER_IS_NOT_REGISTERED_INFO;
        } else {
            code = AuthenticationResultInfo.USER_ALREADY_EXISTS_INFO;
        }
        return FastJsonUtils.convertObjectToJSON(Result.build(code.getCode(), code.getMessage(), null));
    }
}
