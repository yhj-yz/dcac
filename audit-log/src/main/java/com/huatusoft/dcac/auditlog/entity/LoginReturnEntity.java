package com.huatusoft.dcac.auditlog.entity;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Getter;
import lombok.Setter;

/**
 * @author yhj
 * @date 2020-4-9
 */
@Getter
@Setter
public class LoginReturnEntity {
    /**在线状态标示*/
    private String sessionId;
    /**登陆用户名*/
    private String userName;
}
