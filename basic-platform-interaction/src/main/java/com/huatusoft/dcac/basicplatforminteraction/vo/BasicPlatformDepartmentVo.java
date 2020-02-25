package com.huatusoft.dcac.basicplatforminteraction.vo;

import lombok.Data;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 14:13
 */
@Data
public class BasicPlatformDepartmentVo {

    /**
     * 部门ID，不超过 64 字节
     */
    private String id;

    /**
     * 部门名称，不超过 64 字节
     */
    private String name;

    /**
     * 上级部门
     */
    private String pid;

    /**
     * 部门描述，不超过 256 字节
     */
    private String desc;

    /**
     * 是否为单位，0 表示不是单位，1 表示该部门具有单位属性
     */
    private String isorg;

    /**
     * 0 启用 1 禁用 2 删除
     */
    private String status;
    /**
     * 单位编码
     */
    private String unitcode;
}
