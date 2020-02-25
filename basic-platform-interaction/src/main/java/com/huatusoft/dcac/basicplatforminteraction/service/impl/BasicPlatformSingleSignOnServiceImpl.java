package com.huatusoft.dcac.basicplatforminteraction.service.impl;

import com.alibaba.fastjson.JSON;
import com.google.inject.internal.util.$Lists;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformSingleSignOnService;
import com.huatusoft.dcac.basicplatforminteraction.vo.PlatformLoginUserVo;
import com.huatusoft.dcac.common.util.HttpClientUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/25 17:27
 */
@Service
public class BasicPlatformSingleSignOnServiceImpl extends AbstractBasicPlatformService implements BasicPlatformSingleSignOnService {
    @Override
    public PlatformLoginUserVo requestPlatformLoginUser(String accessToken, String appId) throws Exception {
        ArrayList<String> keys = $Lists.newArrayList(
                ACCESS_TOKEN
                , ACCESS_APP_ID);
        ArrayList<String> values = $Lists.newArrayList(
                accessToken
                , appId
        );

        return JSON.parseObject(HttpClientUtils.doPost(
                String.format(VERIFYTOKEN_URL, servletContext.getAttribute(PLATFORM_IP), servletContext.getAttribute(PLATFORM_PORT))
                , super.requestPreparationParam(keys, values)).getContent()).getObject("data", PlatformLoginUserVo.class);
    }
}
