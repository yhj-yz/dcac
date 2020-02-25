package com.huatusoft.dcac.basicplatforminteraction.service.impl;

import com.alibaba.fastjson.JSON;
import com.google.inject.internal.util.$Lists;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformSyncUnitCertService;
import com.huatusoft.dcac.basicplatforminteraction.vo.BasicPlatformUnitCertVo;
import com.huatusoft.dcac.basicplatforminteraction.vo.PlatformSyncResult;
import com.huatusoft.dcac.common.util.HttpClientUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/7 13:11
 */
@Service
public class BasicPlatformSyncUnitCertServiceImpl extends AbstractBasicPlatformService implements BasicPlatformSyncUnitCertService {

    @Override
    public PlatformSyncResult<BasicPlatformUnitCertVo> syncBasicPlatformUnitCert(String appId, String appName, String access_token) throws Exception {
        ArrayList<String> keys = $Lists.newArrayList(
                ACCESS_APP_ID
                , SYNC_APP_NAME
                , ACCESS_TOKEN);
        ArrayList<String> values = $Lists.newArrayList(
                String.valueOf(appId)
                , String.valueOf(appName)
                , String.valueOf(access_token));
        //请求获取结果
        String httpRequestResult = HttpClientUtils.doPost(String.format(GETUNITCERT_URL
                , String.valueOf(servletContext.getAttribute(PLATFORM_IP))
                , String.valueOf(servletContext.getAttribute(PLATFORM_PORT))), super.requestPreparationParam(keys, values)).getContent();
        return JSON.parseObject(httpRequestResult, PlatformSyncResult.class);
    }
}
