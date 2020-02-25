package com.huatusoft.electronictag.organizationalstrucure.vo;

import com.huatusoft.electronictag.base.vo.BaseVo;
import com.huatusoft.electronictag.organizationalstrucure.entity.DepartmentEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;
import java.util.Date;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/27 12:50
 */
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class UserVo extends BaseVo {
    @Transient
    private static final long serialVersionUID = 1664213045998967055L;

    /**用户名*/
    private String name;

    /**用户帐号*/
    private String account;

    /**密码*/
    private String password;

    /**是否禁用*/
    private Integer isDisable = 0;

    /** 策略是否有更新0没有1有*/
    private Integer policy = 0;

    /**智能卡账号，不超过 64 字节**/
    private String keyUser;

    /**性别:0女 1男**/
    private Integer sex = 1;

    /** 是否锁定 */
    private Integer isLocked = 0;

    /** 连续登录失败次数 */
    private Integer loginFailureCount = 0;

    /** 锁定日期 */
    private Date lockedDate;

    /** 最后登录日期 */
    private Date loginDate;

    /** 下发的策略文件是否有修改*/
    private Boolean policyFileEdited = false;

    /**军官证号*/
    private String militaryId;

    /**口令*/
    private String pwdUser;

    /** 状态：0启用 1禁用 2已删除*/
    private Integer status = 0;

    /**职务：用户岗位名称*/
    private String post;

    /**签名证书：不超过4095字节，采用base64编码存储*/
    private String signCert;

    private String encCert;

    /**证书级别：1，2，3*/
    private Integer certLevel=1;

    /**用户密级：0绝密 1机密 2秘密 3内部 4公开*/
    private Integer mLevel=0;

    /** 描述信息：可以为空，不超过255*/
    private String description;

    /**手机号码**/
    private String telephone;
    /**是否在线*/
    private Integer isOnline;
    private Date heartBeatTime;
    private String unitCode;
    /** 部门 */
    private DepartmentEntity department;
    /** 角色 */
    private RoleVo role;

    private PermissionVo permissions;

    private ControlledStrategyVo controlledStrategy;
}
