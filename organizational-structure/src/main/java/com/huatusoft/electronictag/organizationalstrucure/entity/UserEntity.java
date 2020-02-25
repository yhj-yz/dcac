package com.huatusoft.electronictag.organizationalstrucure.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.electronictag.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.hibernate.annotations.Type;

import javax.persistence.*;
import java.util.Date;
import java.util.List;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/9/27 12:50
 */
@Getter
@Setter
@Entity
@Cacheable
@Table(name = "HT_ELECTRONICTAG_USER")
@NoArgsConstructor
@AllArgsConstructor
public class UserEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 1664213045998967055L;

    @Transient
    private String did;

    @Transient
    private String roleName;

    /**用户名*/
    @Column(name = "USER_NAME", length = 15)
    private String name;

    /**用户帐号*/
    @Column(name = "USER_ACCOUNT", length = 16)
    private String account;

    /**密码*/
    @Column(name = "USER_PASSWORD", length = 50)
    private String password;

    /**是否禁用*/
    @Column(name = "USER_ISDISABLE", length = 1)
    private Integer isDisable = 0;

    /** 策略是否有更新0没有1有*/
    @Column(name = "USER_POLICY", length = 1)
    private Integer policy = 0;

    /**智能卡账号，不超过 64 字节**/
    @Column(name = "USER_KEY_USER", length = 64)
    private String keyUser;

    /**性别:0女 1男**/
    @Column(name = "USER_SEX", length = 1)
    private Integer sex = 1;

    /** 是否锁定 */
    @Column(name = "USER_ISLOCKED", length = 6)
    private Integer isLocked = 0;

    /** 连续登录失败次数 */
    @Column(name = "USER_LOGIN_FAILURE_COUNT", length = 6)
    private Integer loginFailureCount;

    /** 锁定日期 */
    @Column(name = "USER_LOCKED_DATE_TIME", length = 20)
    private Date lockedDate;

    /** 最后登录日期 */
    @Column(name = "USER_LOGIN_DATE_TIME", length = 20)
    private Date loginDate;

    @Column(name = "USER_IS_SYSTEM", length = 1)
    private Integer isSystem;

    /** 下发的策略文件是否有修改*/
    @Column(name = "USER_POLICY_FILE_EDITED", length = 20)
    private Boolean policyFileEdited = false;

    /**军官证号*/
    @Column(name = "USER_MILITARY_ID", length = 64)
    private String militaryId;

    /**口令*/
    @Column(name = "USER_PWD_USER", length = 64)
    private String pwdUser;

    /** 状态：0启用 1禁用 2已删除*/
    @Column(name = "USER_STATUS", length = 1)
    private Integer status = 0;

    /**职务：用户岗位名称*/
    @Column(name = "USER_POST", length = 64)
    private String post;

    /**签名证书：不超过4095字节，采用base64编码存储*/
    @Lob
    @Type(type="text")
    @Column(name = "USER_SIGN_CERT", length = 4095)
    private String signCert;

    /**加密证书：不超过4095字节，采用base64编码存储*/
    @Lob
    @Type(type="text")
    @Column(name = "USER_ENC_CERT", length = 2084)
    private String encCert;

    /**证书级别，1 一级证书 2 二级证书 3 三级证书*/
    @Column(name = "USER_CERT_LEVEL", length = 1)
    private Integer certLevel=1;

    /**用户密级：密级 1 绝密 2 机密 3 秘密 4 内部 5 公开*/
    @Column(name = "USER_M_LEVEL", length = 1)
    private Integer mLevel = 1;

    /** 描述信息：可以为空，不超过255*/
    @Column(name = "USER_DESCRIPTION", length = 255)
    private String description;

    /**手机号码**/
    @Column(name = "USER_TELEPHONE", length = 20)
    private String telephone;
    /**是否在线*/
    @Column(name = "USER_IS_ONLINE", length = 1)
    private Integer isOnline;
    @Column(name = "USER_HEART_BEAT_TIME", length = 20)
    private Date heartBeatTime;
    @Column(name = "USER_UNIT_CODE", length = 255)
    private String unitCode;
    /** 部门 */
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "USER_DEPT_ID")
    private DepartmentEntity department;
    /** 角色 */
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "USER_ROLE_ID")
    private RoleEntity role;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "USER_PERMISSION_ID")
    private PermissionEntity permissions;

    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "USER_CONTROLLEDSTRATEGY_ID")
    private ControlledStrategyEntity controlledStrategy;

    /**软件*/
    @OneToMany(mappedBy = "userEntity",fetch = FetchType.LAZY)
    @JsonIgnore
    private List<SoftWareEntity> softWareEntities;
}
