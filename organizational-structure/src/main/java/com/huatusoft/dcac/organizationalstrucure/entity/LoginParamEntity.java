package com.huatusoft.dcac.organizationalstrucure.entity;

import lombok.Getter;
import lombok.Setter;

/**
 * @author yhj
 * @date 2020-4-10
 */
@Getter
@Setter
public class LoginParamEntity {

    /**登陆名称*/
    private String loginName;

    /**登陆密码*/
    private String password;
}
