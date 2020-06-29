package com.huatusoft.dcac.authentication.controller;

import com.huatusoft.dcac.authentication.checkcode.CreateImageCode;
import com.huatusoft.dcac.authentication.response.info.AuthenticationResultInfo;
import com.huatusoft.dcac.organizationalstrucure.service.SystemService;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.common.bo.Principal;
import com.huatusoft.dcac.common.bo.Setting;
import com.huatusoft.dcac.common.util.*;
import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;
import java.util.*;

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

    @Autowired
    private SystemService systemParamService;

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

    /**
     * 外部登陆接口
     * @param userNo
     * @return
     */
//    @PostMapping("/loginByOut")
//    @ResponseBody
//    public Result loginByOut(String userNo){
//        if (userNo == null || "".equals(userNo)) {
//            return new Result("缺少用户信息!");
//        }
//        Map<String,String> paramMap = new HashMap<String, String>(1);
//        paramMap.put("userNo",userNo);
//        String result = HttpUtil.signPost("http://172.16.23.148:7073/api/token/getTokenByUserNo", SystemConstants.APP_ID, SystemConstants.PRODUCT_KEY, String.valueOf(System.currentTimeMillis()), paramMap);
//        String code = JsonUtils.getJsonString(result, "code");
//        String message = JsonUtils.getJsonString(result, "message");
//        if("1".equals(code)) {
//            String result1 = HttpUtil.signPost("http://172.16.23.148:7073/api/user/getUserByNo", SystemConstants.APP_ID, SystemConstants.PRODUCT_KEY, String.valueOf(System.currentTimeMillis()),paramMap);
//            String data1 = JsonUtils.getJsonString(result1, "data");
//            if(data1 != null) {
//                String userName = JsonUtils.getJsonString(data1, "userAccount");
//                UsernamePasswordToken usernamePasswordToken = new UsernamePasswordToken(userName,userNo);
//                SecurityUtils.getSubject().getSession().setAttribute("basicPlatformReturnCurLoginAccount",userNo);
//                SecurityUtils.getSubject().login(usernamePasswordToken);
//                String data = JsonUtils.getJsonString(result, "data");
//                RedisTemplate redisTemplate = SpringContextUtils.getBean(RedisTemplate.class);
//                redisTemplate.opsForValue().set("data_" + userNo, data);
//                redisTemplate.expire("data_" + userNo, 28, TimeUnit.MINUTES);
//            }else {
//                return new Result("缺少用户信息!");
//            }
//        }else {
//            return new Result(message);
//        }
//        return new Result("200", "登陆成功!", null);
//    }
}