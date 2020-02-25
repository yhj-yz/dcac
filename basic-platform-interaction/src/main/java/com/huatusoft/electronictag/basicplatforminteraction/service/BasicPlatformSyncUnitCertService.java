package com.huatusoft.electronictag.basicplatforminteraction.service;

import com.huatusoft.electronictag.base.service.BasicPlatformService;
import com.huatusoft.electronictag.basicplatforminteraction.vo.BasicPlatformUnitCertVo;
import com.huatusoft.electronictag.basicplatforminteraction.vo.PlatformSyncResult;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/7 13:11
 */
public interface BasicPlatformSyncUnitCertService extends BasicPlatformService {
    /**
     * 基础平台单位证书同步
     * @param appId 子系统 ID，本 ID 由子系统在基础平台注册时生成。String类型
     * @param appName 子系统名称。String 类型
     * @param access_token 访问控制令牌。String 类型
     * @throws Exception
     * @return 基础平台返回证书对象集合
     */
    PlatformSyncResult<BasicPlatformUnitCertVo> syncBasicPlatformUnitCert(String appId, String appName, String access_token) throws Exception;
}
