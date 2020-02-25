package com.huatusoft.dcac.basicplatforminteraction.service.impl;

import com.alibaba.fastjson.JSON;
import com.google.inject.internal.util.$Lists;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformAccessControlService;
import com.huatusoft.dcac.basicplatforminteraction.vo.AccessTokenVo;
import com.huatusoft.dcac.common.util.HttpClientUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 15:17
 */
@Service
public class BasicPlatformAccessControlServiceImpl extends AbstractBasicPlatformService implements BasicPlatformAccessControlService {


    @Override
    public String getBasicPlatformAccessToken(String appId, String appSecret, String grantType) throws Exception {
        ArrayList<String> keys = $Lists.newArrayList(
                ACCESS_APP_ID
                , ACCESS_APP_SECRET
                , ACCESS_GRANT_TYPE
        );
        ArrayList<String> values = $Lists.newArrayList(
                appId
                , appSecret
                , grantType
        );
        //封装参数
        //请求获取结果
        String httpRequestResult = HttpClientUtils.doPost(
                String.format(GETTOKEN_URL
                        , String.valueOf(servletContext.getAttribute(PLATFORM_IP))
                        , String.valueOf(servletContext.getAttribute(PLATFORM_PORT))), super.requestPreparationParam(keys, values)).getContent();
        return JSON.parseObject(httpRequestResult).getObject("data", AccessTokenVo.class).getAccess_token();
    }
}
