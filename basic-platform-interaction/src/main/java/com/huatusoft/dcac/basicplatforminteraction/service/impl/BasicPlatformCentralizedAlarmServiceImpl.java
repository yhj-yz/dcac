package com.huatusoft.dcac.basicplatforminteraction.service.impl;

import com.alibaba.fastjson.JSON;
import com.google.inject.internal.util.$Lists;
import com.huatusoft.dcac.base.service.BasicPlatformService;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformCentralizedAlarmService;
import com.huatusoft.dcac.basicplatforminteraction.vo.AlarmIdVo;
import com.huatusoft.dcac.common.util.HttpClientUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/7 14:17
 */
@Service
public class BasicPlatformCentralizedAlarmServiceImpl extends AbstractBasicPlatformService implements BasicPlatformCentralizedAlarmService, BasicPlatformService {
    @Override
    public String alarm(String appId, String appName, String accessToken, String type, String mCode, String ip, String uid, String uName, String time, String level, String result, String warnDetail) throws Exception {
        ArrayList<String> keys = $Lists.newArrayList(
                ACCESS_APP_ID
                , ACCESS_TOKEN
                , ACCESS_TYPE
                , ACCESS_M_CODE
                , ACCESS_IP
                , ACCESS_USER_ID
                , ACCESS_USER_NAME
                , ACCESS_TIME
                , ACCESS_LEVEL
                , ACCESS_RESULT
                , ACCESS_WARN_DETAIL

        );
        ArrayList<String> values = $Lists.newArrayList(
                appId
                , appName
                , accessToken
                , type
                , mCode
                , ip
                , uid
                , uName
                , time
                , level
                , result
                , warnDetail
        );
        super.requestPreparationParam(keys, values);
        String httpRequestResult = HttpClientUtils.doPost(
                String.format(ALARMREPORT_URL
                        , String.valueOf(servletContext.getAttribute(PLATFORM_IP))
                        , String.valueOf(servletContext.getAttribute(PLATFORM_PORT))), super.requestPreparationParam(keys, values)).getContent();
        return JSON.parseObject(httpRequestResult).getObject("data", AlarmIdVo.class).getId();
    }
}
