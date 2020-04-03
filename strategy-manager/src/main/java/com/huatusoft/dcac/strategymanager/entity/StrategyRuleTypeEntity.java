package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;
import org.omg.PortableInterceptor.ObjectReferenceFactory;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author yhj
 * @date 2020-3-30
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_STRATEGY_RULE_TYPE")
public class StrategyRuleTypeEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 231353295335259120L;

    /**类型编码*/
    @Column(name = "TYPE_CODE",length = 1)
    private String typeCode;

    /**类型名称*/
    @Column(name = "TYPE_NAME",length = 100)
    private String typeName;
}
