package com.huatusoft.electronictag.basicplatforminteraction.service;

import com.huatusoft.electronictag.base.service.BasicPlatformService;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 15:17
 */
public interface BasicPlatformAccessControlService extends BasicPlatformService {

    /**
     * 基础平台提供子系统服务端注册页面，子系统需在基础平台子系统注册页面
     * 进行注册。注册时需指定子系统名称、厂商、服务端 IP 地址、服务端管理后台
     * URL、状态查询 URL 和组织结构信息变化通知 URL 等信息。基础平台会根据这
     * 些信息为子系统生成唯一的授权码和子系统标识，子系统使用该授权码 （app_secret）和子系统标识调用访问控制接口获取访问控制令牌以实现接口调 用的管控。
     * @param appId 基础平台注册时产生的子系统标识。
     * @param appSecret 基础平台注册时产生的子系统授权密钥。
     * @param grantType 其中授权类型固定为”app”。
     * @return 访问Token
     * @throws Exception
     */
    String getBasicPlatformAccessToken(String appId, String appSecret, String grantType ) throws Exception;

}
