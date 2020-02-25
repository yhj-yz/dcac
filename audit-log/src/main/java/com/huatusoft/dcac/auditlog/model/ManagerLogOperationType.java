package com.huatusoft.dcac.auditlog.model;

import lombok.Getter;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/10 16:47
 */
@Getter
public enum  ManagerLogOperationType {
    SUCCESS("成功"),
    FAILURE("失败");
    private String name;
    ManagerLogOperationType(String name) {
        this.name = name;
    }
}
