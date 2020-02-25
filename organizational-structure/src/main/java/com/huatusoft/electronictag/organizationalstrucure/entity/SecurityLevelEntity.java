package com.huatusoft.electronictag.organizationalstrucure.entity;

import com.huatusoft.electronictag.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * @author WangShun
 * @version 1.0
 * @date 2019/10/15 11:09
 */
@Getter
@Setter
@Entity
@Table(name = "HT_ELECTRONICTAG_SECURITY_LEVEL")
public class SecurityLevelEntity extends BaseEntity {

    /** 密级名称 */
    @Column(nullable = false, length = 64)
    private String securityName;
    /** 密级描述 */
    @Column(length = 1024)
    private String securityDesc;
}
