package com.huatusoft.dcac.basicplatforminteraction.service;

import com.huatusoft.dcac.base.service.BasicPlatformService;
import com.huatusoft.dcac.basicplatforminteraction.vo.PlatformLoginUserVo;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/25 17:22
 */
public interface BasicPlatformSingleSignOnService extends BasicPlatformService {

    /**
     * 请求基础平台,获取基础平台当前登陆用户
     * @param accessToken 基础平台校验令牌
     * @param appId 基础平台appId
     * @throws Exception
     * @return
     */
    PlatformLoginUserVo requestPlatformLoginUser(String accessToken, String appId) throws Exception;
}
