package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.naming.ldap.PagedResultsControl;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author yhj
 * @date 2020-4-3
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_STRATEGY_MASK_TYPE")
public class StrategyMaskTypeEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 241563713963421213L;

    /**脱敏类型编码*/
    @Column(name = "TYPE_CODE",length = 1)
    private String typeCode;

    /**脱敏类型名称*/
    @Column(name = "TYPE_NAME",length = 100)
    private String typeName;
}
