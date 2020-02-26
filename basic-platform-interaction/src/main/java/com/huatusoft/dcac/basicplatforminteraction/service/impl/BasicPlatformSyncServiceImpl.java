package com.huatusoft.dcac.basicplatforminteraction.service.impl;

import com.alibaba.fastjson.JSON;
import com.google.inject.internal.util.$Lists;
import com.huatusoft.dcac.basicplatforminteraction.service.BasicPlatformSyncService;
import com.huatusoft.dcac.basicplatforminteraction.vo.BasicPlatformDepartmentVo;
import com.huatusoft.dcac.basicplatforminteraction.vo.BasicPlatformUserVo;
import com.huatusoft.dcac.basicplatforminteraction.vo.PlatformSyncResult;
import com.huatusoft.dcac.common.util.HttpClientUtils;
import org.apache.commons.lang.time.DateFormatUtils;
import org.springframework.stereotype.Service;

import javax.servlet.ServletContext;
import java.util.ArrayList;
import java.util.Date;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 14:05
 */
@Service
public class BasicPlatformSyncServiceImpl extends AbstractBasicPlatformService implements BasicPlatformSyncService {

    @Override
    public PlatformSyncResult<BasicPlatformUserVo> syncUsers(
            Date syncTime
            , String accessToken
            , Integer pageNumber
            , Integer pageSize) throws Exception {
        return requestPlatform(
                syncTime
                , accessToken
                , pageNumber
                , pageSize
                , SYNC_USER
                , BasicPlatformUserVo.class);
    }

    @Override
    public PlatformSyncResult<BasicPlatformDepartmentVo> syncDepartments(
            Date syncTime
            , String accessToken
            , Integer pageNumber
            , Integer pageSize) throws Exception {
        return requestPlatform(
                syncTime
                , accessToken
                , pageNumber
                , pageSize
                , SYNC_DEPT
                , BasicPlatformDepartmentVo.class);
    }

    private <T> PlatformSyncResult<T> requestPlatform(
            Date syncTime
            , String accessToken
            , Integer pageNumber
            , Integer pageSize
            , String type
            , Class<T> t) throws Exception {
        //封装请求参数
        ArrayList<String> keys = $Lists.newArrayList(
                SYNC_TIME
                , ACCESS_TOKEN
                , SYNC_TYPE
                , SYNC_PAGE
                , SYNC_ROWS
        );
        ArrayList<String> values = $Lists.newArrayList(
                DateFormatUtils.format(syncTime, SYNC_TIME_PATTERN)
                , accessToken
                , type
                , String.valueOf(pageNumber)
                , String.valueOf(pageSize)
        );
        //请求基础平台服务器获取返回结果
        String httpRequestResult = HttpClientUtils.doPost(
                String.format(DEPT_USER_SYNC_URL
                        , String.valueOf(servletContext.getAttribute(PLATFORM_IP))
                        , String.valueOf(servletContext.getAttribute(PLATFORM_PORT)))
                , super.requestPreparationParam(keys, values)).getContent();
        return JSON.parseObject(httpRequestResult, PlatformSyncResult.class);
    }

    @Override
    public void setServletContext(ServletContext servletContext) {
        this.servletContext = servletContext;
    }
}
