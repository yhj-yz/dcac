package com.huatusoft.electronictag.auditlog.model;

import lombok.Getter;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/10 16:45
 */
@Getter
public enum  ManagerLogOperationModel {
    LOGIN("登陆认证");
    private String name;
    ManagerLogOperationModel(String name) {
        this.name = name;
    }
}
