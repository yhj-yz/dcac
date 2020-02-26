package com.huatusoft.dcac.organizationalstrucure.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.*;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/25 14:29
 */
@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@Entity
@Table(name = "HT_ELECTRONICTAG_USER_ROLE_AUTHORITY")
public class AuthorityEntity extends BaseEntity {
    @Column(name = "AUTHORITY_NAME")
    private String authorityName;
    @ManyToOne(cascade = {CascadeType.PERSIST, CascadeType.MERGE})
    @JoinColumn(name = "ROLE_ID")
    private RoleEntity role;
}
