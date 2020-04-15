package com.huatusoft.dcac.strategymanager.entity;

import com.huatusoft.dcac.base.entity.BaseEntity;
import lombok.Getter;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * @author yhj
 * @date 2020-4-8
 */
@Entity
@Getter
@Setter
@Table(name = "HT_DCAC_STRATEGY_RESPONSE")
public class StrategyResponseEntity extends BaseEntity {
    @Transient
    private static final long serialVersionUID = 123355191431319235L;

    /**响应类型编码*/
    @Column(name = "RESPONSE_TYPE_CODE",length = 1)
    private String responseTypeCode;

    /**响应类型名称*/
    @Column(name = "RESPONSE_TYPE_NAME",length = 100)
    private String responseTypeName;
}
