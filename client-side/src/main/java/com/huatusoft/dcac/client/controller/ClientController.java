package com.huatusoft.dcac.client.controller;

import com.alibaba.fastjson.JSON;
import com.google.inject.internal.util.$Lists;
import com.google.inject.internal.util.$Maps;
import com.huatusoft.dcac.base.controller.BaseController;
import com.huatusoft.dcac.base.response.Result;
import com.huatusoft.dcac.client.entity.ElectronicTagEntity;
import com.huatusoft.dcac.client.entity.TranEntity;
import com.huatusoft.dcac.client.service.ElectronicTagService;
import com.huatusoft.dcac.client.vo.ClientLoginParamVo;
import com.huatusoft.dcac.client.vo.ElectronicTagInfoVo;
import com.huatusoft.dcac.client.vo.ElectronicTagVo;
import com.huatusoft.dcac.client.vo.TranInfoVo;
import com.huatusoft.dcac.common.bo.Principal;
import com.huatusoft.dcac.common.constant.ClientConstants;
import com.huatusoft.dcac.common.constant.PlatformConstants;
import com.huatusoft.dcac.common.constant.SystemConstants;
import com.huatusoft.dcac.common.util.FastJsonUtils;
import com.huatusoft.dcac.common.util.HttpUtils;
import com.huatusoft.dcac.organizationalstrucure.entity.UserEntity;
import com.huatusoft.dcac.organizationalstrucure.service.UserService;
import org.apache.shiro.crypto.hash.SimpleHash;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.*;


/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/23 17:26
 */
@RequestMapping("/client")
public class ClientController extends BaseController {

    @Autowired
    private ElectronicTagService electronicTagService;

    @Autowired
    private UserService userService;

    private Map<String, Principal> clientLoginUserMap = ((Map<String, Principal>) servletContext.getAttribute(ClientConstants.CLIENT_LOGIN_USER_MAP));

    /**
     * 客户端登陆接口
     * @param clientLoginParamVo 登陆参数
     * @return 结果信息
     * @throws Exception
     */
    @PostMapping("/login")
    @ResponseBody
    public Result login(ClientLoginParamVo clientLoginParamVo) throws Exception {
        //校验身份
        long clientTimestamp = clientLoginParamVo.getTimestamp().getTime();
        long serverTimestamp = System.currentTimeMillis();
        String realIp = HttpUtils.getRealIp(getRequest());
        String clientLoginAccount = clientLoginParamVo.getAccount();
        /***
         * TODO : AOP
         */
        if ((serverTimestamp - clientTimestamp) > ClientConstants.TIME_DIFFERENCE_MILLISECONDS) {
            //非法请求
        }
        if (Objects.nonNull(clientLoginUserMap)) {
            Principal principal = clientLoginUserMap.get(realIp);
            if (Objects.nonNull(principal)) {
                //当前用户已经登陆
            }

        } else {
            clientLoginUserMap = $Maps.newHashMap();
        }
        UserEntity user = userService.getUserByAccount(clientLoginAccount);
        if (Objects.isNull(user)) {
            //登陆的用户不存在
        }

        if (
                !Objects.equals(user.getAccount(), clientLoginParamVo.getAccount())
                || !Objects.equals(String.valueOf(new SimpleHash("MD5", clientLoginParamVo.getPassword(), ByteSource.Util.bytes(clientLoginAccount), 10)), clientLoginParamVo.getPassword())
        ) {
            //用户名或密码错误
        }
        clientLoginUserMap.put(realIp, new Principal(user.getId(), user.getAccount(), user.getName()));
        servletContext.setAttribute(ClientConstants.CLIENT_LOGIN_USER_MAP, clientLoginUserMap);
        user.setIsOnline(1);
        user.setHeartBeatTime(new Date());
        userService.update(user);
        return Result.ok("登陆成功");
    }

    /**
     * 客户端：终端登出
     */
    @PostMapping("/logout")
    @ResponseBody
    public Result logout(@RequestParam("account") String account) throws Exception {
        String realIp = HttpUtils.getRealIp(getRequest());
        if (Objects.isNull(clientLoginUserMap)) {
            //该用户尚未登陆
        }
        boolean flag = false;
        Principal logOutUser = clientLoginUserMap.get(realIp);
        if (Objects.isNull(logOutUser)) {
            //该用户尚未登陆
        }
        clientLoginUserMap.remove(realIp);
        servletContext.setAttribute(ClientConstants.CLIENT_LOGIN_USER_MAP, clientLoginUserMap);
        return Result.ok("退出成功");
    }

    @ResponseBody
    @PostMapping("/obtainAppId")
    public Result obtainAppId() {
        return Result.build("200", "成功",String.valueOf(servletContext.getAttribute(PlatformConstants.PLATFORM_APP_ID)));
    }

    /**
     * 4.1 上传标签信息
     *
     *
     * @return
     * @throws Exception
     */
    @ResponseBody
    @PostMapping("/uploadTagInfo")
    public Result uploadTagInfo(@RequestBody String param) throws Exception {
        ElectronicTagVo electronicTagVo = JSON.parseObject(param, ElectronicTagVo.class);
        String realIp = HttpUtils.getRealIp(getRequest());
        Principal principal = clientLoginUserMap.get(realIp);
        if (Objects.isNull(principal)) {
            //当前用户尚未登陆
        }
        for (ElectronicTagEntity electronicTagEntity : parseElectronicTagVoToEntity(electronicTagVo.getBaseinfo())) {
            electronicTagService.add(electronicTagEntity);
        }
        return Result.build("上传标签信息成功");
    }

    private List<ElectronicTagEntity> parseElectronicTagVoToEntity(List<ElectronicTagInfoVo> electronicTagInfoVos) throws Exception {
        SimpleDateFormat sdf = new SimpleDateFormat(SystemConstants.DATE_TIME_PATTERN);
        ArrayList<ElectronicTagEntity> electronicTags = $Lists.newArrayList();
        for (ElectronicTagInfoVo electronicInfoVo : electronicTagInfoVos) {
            ElectronicTagEntity electronicTagEntity = new ElectronicTagEntity();
            electronicTagEntity.setFileId(electronicInfoVo.getFileid());
            electronicTagEntity.setClassLevel(Integer.parseInt(electronicInfoVo.getClasslevel()));
            electronicTagEntity.setCreateAccount(electronicInfoVo.getCreator_username());
            electronicTagEntity.setFilePath(electronicInfoVo.getFile_path());
            electronicTagEntity.setOperatePolicy(Integer.parseInt(electronicInfoVo.getOperate_policy()));
            electronicTagEntity.setTermCode(electronicInfoVo.getTermcode());
            electronicTagEntity.setUserId(electronicInfoVo.getCreator_userid());
            ArrayList<TranEntity> trans = $Lists.newArrayList();
            for (TranInfoVo tranInfoVo : electronicInfoVo.getTraninfo()) {
                TranEntity tranEntity = new TranEntity();
                tranEntity.setOpeType(Integer.parseInt(tranInfoVo.getOpetype()));
                tranEntity.setTermCode(tranInfoVo.getTermcode());
                tranEntity.setTranUser(tranInfoVo.getOpenuser());
                tranEntity.setOpeTime(sdf.parse(tranInfoVo.getOpetime()));
                trans.add(tranEntity);
            }
            electronicTagEntity.setTrans(trans);
            electronicTags.add(electronicTagEntity);
        }
        return electronicTags;
    }

    @ResponseBody
    @PostMapping(value = "/userInfo")
    public Result getUserInfo(@RequestBody String param) {
        if (Objects.isNull(clientLoginUserMap)){
            //当前用户尚未登陆
        }
        Principal principal = clientLoginUserMap.get(HttpUtils.getRealIp(getRequest()));
        if (Objects.isNull(principal)) {
            //当前用户尚未登陆
        }
        UserEntity userByAccount = userService.getUserByAccount(principal.getAccount());
        return Result.build("200", "获取用户信息成功", FastJsonUtils.convertObjectToJSON(userByAccount));
    }

    /**
     * 5.3心跳
     */
    @ResponseBody
    @PostMapping(value = "/heartbeat")
    public Result heartbeat(@RequestBody String param) {
        if (Objects.isNull(clientLoginUserMap)){
            //当前用户尚未登陆
        }
        Principal principal = clientLoginUserMap.get(HttpUtils.getRealIp(getRequest()));
        if (Objects.isNull(principal)) {
            //当前用户尚未登陆
        }
        UserEntity userByAccount = userService.getUserByAccount(principal.getAccount());
        userByAccount.setIsOnline(1);
        userByAccount.setHeartBeatTime(new Date());
        userService.update(userByAccount);
        return Result.build("成功");
    }

    @ResponseBody
    @PostMapping(value = "/systemParam")
    public String getSystemParam() {

        if (Objects.isNull(clientLoginUserMap)){
            //当前用户尚未登陆
        }
        Principal principal = clientLoginUserMap.get(HttpUtils.getRealIp(getRequest()));
        if (Objects.isNull(principal)) {
            //当前用户尚未登陆
        }
        HashMap<String, String> responseResult = $Maps.newHashMap();
        responseResult.put(PlatformConstants.ACCESS_APP_ID, String.valueOf(servletContext.getAttribute(PlatformConstants.PLATFORM_APP_ID)));
        responseResult.put(PlatformConstants.ACCESS_APP_SECRET, String.valueOf(servletContext.getAttribute(PlatformConstants.PLATFORM_APP_SECRET)));
        return FastJsonUtils.convertObjectToJSON(responseResult);
    }


}
