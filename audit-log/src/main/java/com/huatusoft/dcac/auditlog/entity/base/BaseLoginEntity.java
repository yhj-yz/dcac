package com.huatusoft.dcac.auditlog.entity.base;

import lombok.Getter;
import lombok.Setter;

/**
 * @author yhj
 * @date 2020-4-9
 */
@Getter
@Setter
public class BaseLoginEntity{
    /**客户端唯一id*/
    private String clientGuid;
    /**客户端ip*/
    private String ip;
    /**mac地址*/
    private String mac;
    /**用户名*/
    private String loginName;
    /**在线状态标示*/
    private String sessionId;
}
