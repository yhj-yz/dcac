package com.huatusoft.electronictag.organizationalstrucure.entity;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.huatusoft.electronictag.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 10:21
 */
@Getter
@Setter
@Entity
@Table(name = "HT_ELECTRONICTAG_PERMISSION")
public class PermissionEntity extends BaseEntity {

    /** 权限集名称 */
    @Column(length = 32)
    private String permissionName;

    /** 权限集描述 */
    @Column(length = 256)
    private String permissionDesc;

    /** 权限 */
    private Integer userAuthority = 0;

    @OneToMany(mappedBy = "permissions", fetch = FetchType.LAZY)
    @JsonIgnore
    private List<UserEntity> users = new ArrayList<UserEntity>();

}
