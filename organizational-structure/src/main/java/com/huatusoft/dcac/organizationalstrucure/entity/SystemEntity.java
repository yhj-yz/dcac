package com.huatusoft.dcac.organizationalstrucure.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author yhj
 * @date 2020-5-15
 */
@Getter
@Setter
@Entity
@Table(name = "HT_DCAC_SYSTEM_PARAM")
public class SystemEntity extends BaseEntity{
    @Transient
    private static final long serialVersionUID = 122352623123625236L;
    /**
     * 产品编号
     */
    @Column(name = "APP_ID",length = 50)
    private String appId;
    /**
     * 产品密钥
     */
    @Column(name = "PRODUCT_KEY",length = 50)
    private String productKey;
}
