package com.huatusoft.electronictag.basicplatforminteraction.vo;

import lombok.Data;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/18 14:13
 */
@Data
public class BasicPlatformUserVo {

    /**
     * 用户 id，不超过 64 字节
     */
    private String id;
    /**
     * 用户登录账号，不超过 64 字节
     */
    private String pwduser;
    /**
     * 用户姓名，不超过 64 字节
     */
    private String name;
    /**
     * 部门 id
     */
    private String did;
    /**
     * sys 系统管理员 sec 安全管理员 audit 审计管理员 user 普通用户
     */
    private String role;
    /**
     * 智能卡账号，不超过 64 字节
     */
    private String keyuser;
    /**
     * 签名证书（PEM 格式），不超过 2048 字节
     */
    private String signcert;
    /**
     * 加密证书（PEM 格式），不超过 2048 字节
     */
    private String enccert;
    /**
     * 证书级别，1 一级证书 2 二级证书 3 三级证书
     */
    private String certlevel;
    /**
     * 密级 1 绝密 2 机密 3 秘密 4 内部 5 公开
     */
    private String mlevel;
    /**
     * 性别 0 女 1 男
     */
    private String sex;
    /**
     * 职务，不超过 64 字节
     */
    private String post;
    /**
     * 军官证号，不超过 64 字节
     */
    private String militarynum;
    /**
     * 电话，不超过 16 字节
     */
    private String telephone;
    /**
     * 状态 0 启用 1 禁用 2 删除
     */
    private String status;

    /**
     * 单位编码
     */
    private String unitcode;

}
