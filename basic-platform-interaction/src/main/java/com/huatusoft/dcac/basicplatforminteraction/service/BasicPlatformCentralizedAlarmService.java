package com.huatusoft.dcac.basicplatforminteraction.service;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/11/7 14:12
 */
public interface BasicPlatformCentralizedAlarmService {

    /**
     * 基础平台为其他子系统提供了统一的告警接口。其他子系统服务端通过该接
     * 口将各自收集的告警信息以统一格式传递到基础平台服务端。
     * @param appId 子系统 ID，本 ID 由子系统在基础平台注册时生成。
     * @param appName 子系统名称。
     * @param accessToken 访问控制令牌。
     * @param type 告警类别。各子系统自定义类别，类别名称需简短，不超过 32 字节。
     * @param mCode 保密终端编码。
     * @param ip 告警主体 IP。
     * @param uid 用户 ID。
     * @param uName 用户姓名。
     * @param time 时间格式为"2019-01-01 22:52:00"
     * @param level 告警等级，致命（0）、严重（1）、错误（2）、警告（3）
     * @param result 处置结果
     * @param warnDetail 告警详细描述信息。
     * @return 基础平台告警信息id
     */
    String alarm(String appId, String appName, String accessToken, String type, String mCode, String ip, String uid, String uName, String time, String level, String result, String warnDetail) throws Exception;

}
